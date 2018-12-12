Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDEBC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:20:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72DC2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B3UhZ2lH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="od1s6g9M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bQfoIvI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72DC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1fujjVcJK6XwTGfS+YWKO0ujYPUqjzN4BuqfWNqtIUw=; b=B3UhZ2lHMKdJ5W2besiD9ZOWQ3
	xqXWaBDQmbkdpru1lt79/p863vQTD3i4XUCwr8H6AW/JXSNFVgBlmuGvXWOfG9H993ROpbCj2AOOj
	C8TS5o6YoCJqJ7hi/vUSekVM2SDgQvxTO80XRm566seZjGApYMvPMysZLHwmcMLxnUyKJ2YIh7EqJ
	ieIbqts9IkRWFtm90qKF91idDPPlYH0vDH4zGMWgH5VoCSmqw5rRI/qbgYZVGMBAaXeVz0Ct8eN39
	BCdCWKdnGcNFbBhz1k3mjde7uC8fwea6rtJZybwO9S6ZlgjDduXg8xxi12Ukk3S7NfR0RCPC56Ohc
	jif7NHuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBvZ-0003nv-C7; Wed, 12 Dec 2018 21:20:21 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBuJ-0001kW-S0
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:19:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 7414760A71; Wed, 12 Dec 2018 21:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544649534;
 bh=Qyhl1U7xSdva1EVkW/+fyqUw5Hn2WV5PUWkjWF+5DXk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=od1s6g9MjGaha/+y0Fpc0XWYqbhcCn1Lzmp/NlA9JvjmyhQW/xduweRMfInpmOMJr
 en61uch65wxs+lI+wS4pptQdob7Da+xZTGMO0B4cIr4tKDnSlNox8IMb5ZT4BN0hku
 4Q9Cp4TcvGkjnafiLit7G7EcK9D6XLHaEhWbmXm0=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 53D6E6037C;
 Wed, 12 Dec 2018 21:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544649533;
 bh=Qyhl1U7xSdva1EVkW/+fyqUw5Hn2WV5PUWkjWF+5DXk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bQfoIvI6DKSQbQtVN52eRODJ0uu5ZqRk3h5tYiQd64kb98VMzTh9QOw1Zg4fsOJHq
 3ztNNo0HGL+IhiDfaRRS6YyxZaKvCvThdA8sgghz18PH0FU5qBuvqzefSmGHCPhtA7
 Zisf6kl2Q5ZdtTc0C0jlsdxWki2pI0kGBJDaH6A0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53D6E6037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v6 1/2] dt-bindings: drm/msm/a6xx: Document GMU and update GPU
 bindings
Date: Wed, 12 Dec 2018 14:18:47 -0700
Message-Id: <20181212211848.26768-2-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181212211848.26768-1-jcrouse@codeaurora.org>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131904_087805_AAC20FDB 
X-CRM114-Status: GOOD (  14.69  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 vireshk@kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Update the GPU bindings and document the new bindings for the GMU
device found with Adreno a6xx targets.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 .../devicetree/bindings/display/msm/gmu.txt   | 56 +++++++++++++++++++
 .../devicetree/bindings/display/msm/gpu.txt   | 41 +++++++++++++-
 2 files changed, 94 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
new file mode 100644
index 000000000000..6152cb551d29
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
@@ -0,0 +1,56 @@
+Qualcomm adreno/snapdragon GMU (Graphics management unit)
+
+The GMU is a programmable power controller for the GPU. the CPU controls the
+GMU which in turn handles power controls for the GPU.
+
+Required properties:
+- compatible:
+  * "qcom,adreno-gmu"
+- reg: Physical base address and length of the GMU registers.
+- reg-names: Matching names for the register regions
+  * "gmu"
+  * "gmu_pdc"
+  * "gmu_pdc_seg"
+- interrupts: The interrupt signals from the GMU.
+- interrupt-names: Matching names for the interrupts
+  * "hfi"
+  * "gmu"
+- clocks: phandles to the device clocks
+- clock-names: Matching names for the clocks
+   * "gmu"
+   * "cxo"
+   * "axi"
+   * "mnoc"
+- power-domains: should be <&clock_gpucc GPU_CX_GDSC>
+- iommus: phandle to the adreno iommu
+- operating-points-v2: phandle to the OPP operating points
+
+Example:
+
+/ {
+	...
+
+	gmu: gmu@506a000 {
+		compatible="qcom,adreno-gmu";
+
+		reg = <0x506a000 0x30000>,
+			<0xb280000 0x10000>,
+			<0xb480000 0x10000>;
+		reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
+
+		interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "hfi", "gmu";
+
+		clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
+			<&gpucc GPU_CC_CXO_CLK>,
+			<&gcc GCC_DDRSS_GPU_AXI_CLK>,
+			<&gcc GCC_GPU_MEMNOC_GFX_CLK>;
+		clock-names = "gmu", "cxo", "axi", "memnoc";
+
+		power-domains = <&gpucc GPU_CX_GDSC>;
+		iommus = <&adreno_smmu 5>;
+
+		operating-points-v2 = <&gmu_opp_table>;
+	};
+};
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
index 43fac0fe09bb..8d9415180c22 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
@@ -8,14 +8,21 @@ Required properties:
   with the chip-id.
 - reg: Physical base address and length of the controller's registers.
 - interrupts: The interrupt signal from the gpu.
-- clocks: device clocks
+- interrupt-names: List of names for the interrupt signals. The following can be
+  provided:
+  * "kgsl_3d0_irq"
+- clocks: device clocks (if applicable)
   See ../clocks/clock-bindings.txt for details.
-- clock-names: the following clocks are required:
+- clock-names: the following clocks can be provided:
   * "core"
   * "iface"
   * "mem_iface"
+- iommus: optional phandle to an adreno iommu instance
+- operating-points-v2: optional phandle to the OPP operating points
+- qcom,gmu: For a6xx and newer targets a phandle to the GMU device that will
+  control the power for the GPU
 
-Example:
+Example 3xx/4xx/a5xx:
 
 / {
 	...
@@ -36,3 +43,31 @@ Example:
 		    <&mmcc MMSS_IMEM_AHB_CLK>;
 	};
 };
+
+Example a6xx (with GMU):
+
+/ {
+	...
+
+	gpu@5000000 {
+		compatible = "qcom,adreno-630.2", "qcom,adreno";
+		#stream-id-cells = <16>;
+
+		reg = <0x5000000 0x40000>, <0x509e000 0x10>;
+		reg-names = "kgsl_3d0_reg_memory", "cx_mem";
+
+		/*
+		 * Look ma, no clocks! The GPU clocks and power are
+		 * controlled entirely by the GMU
+		 */
+
+		interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "kgsl_3d0_irq";
+
+		iommus = <&adreno_smmu 0>;
+
+		operating-points-v2 = <&gpu_opp_table>;
+
+		qcom,gmu = <&gmu>;
+	};
+};
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
