Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18545C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:34:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC33D218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gML8VXUr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m0c+Yv7h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SsldPM2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC33D218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=re/sH2zhRBJyPjYnkV4QG1ewhNG51wmBL4z5+IBM/X4=; b=gML8VXUrYEyoEZW++T3G7PZEq2
	u1I0StKtCwpXJE7AOzDyUDXV5ksRGWfznauDPeWomiMXGMdWO/fR1Fquu5L6Y5V9/jbKi0Dv3sdnS
	vEUtgfabUPkRVkkaay/TzR5+WG+wWPTNiTmBS08thbuNYegUIdBc+Mn/1o0lIFhtE3Ya/mG/WFyR6
	9OKSbD5kdbkFRuWRxuF7ArEvmONDzcaZKvPoijdsDO/AIVV1QAmo+AgseACF1fxx/g+MzB0Kzcouc
	utvbXmx8HPssT5ynwi5qKW+11NUVi04yX7rabe2nJm+KClhZxPAy8Fby9ooRAz9iJPMgDqRAP5HPX
	I1vjAPhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZKCb-00016R-UT; Tue, 18 Dec 2018 18:34:45 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZKB3-00082P-2v
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:33:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 3CD9560A79; Tue, 18 Dec 2018 18:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157981;
 bh=2xZrjzhUxRf/8UD41Jynjt7ClDDaGXK825tdD93w/2A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m0c+Yv7h0McVtvQIk74lLj+Tgs7hsyypGYoEtTJBPkQLvgEk6/ml/cSTRlAekGeNC
 xx4Qfp3Rjjqa1p+1/AaYKTFBixTOrFXIqqfhDy3qizPstf7DOuuWKQ4xKQpqhuPQ8w
 fHIqqyS5XIEkAiApfDi/SkDUys37LraLRa3ORLJg=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 82A96609C4;
 Tue, 18 Dec 2018 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157972;
 bh=2xZrjzhUxRf/8UD41Jynjt7ClDDaGXK825tdD93w/2A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SsldPM2I5M/cTFAYDt2JzM60lI3tCVzXbH0BLr7aFGde6iNGthabeW3xyuZLrhopU
 t5uwp7brLMBTdZmcG7FWI2CWVPFkMI8QIqjFm2GcRPBdLr8mku3c0i9cTt7pyl4OEi
 OuWUbR2ra75UpiL2v/jxj2BNqSx91Jm6Q64BzNbE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82A96609C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v7 5/6] dt-bindings: drm/msm/a6xx: Document GMU and update GPU
 bindings
Date: Tue, 18 Dec 2018 11:32:40 -0700
Message-Id: <20181218183241.12830-6-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181218183241.12830-1-jcrouse@codeaurora.org>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_103309_852871_F1EE7587 
X-CRM114-Status: GOOD (  14.03  )
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
 vireshk@kernel.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Update the GPU bindings and document the new bindings for the GMU
device found with Adreno a6xx targets.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

v7: Updated the GMU compatible string and clarified details about when clocks
can be optional on the GPU

 .../devicetree/bindings/display/msm/gmu.txt   | 59 +++++++++++++++++++
 .../devicetree/bindings/display/msm/gpu.txt   | 42 ++++++++++++-
 2 files changed, 98 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
new file mode 100644
index 000000000000..59e6865898f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
@@ -0,0 +1,59 @@
+Qualcomm adreno/snapdragon GMU (Graphics management unit)
+
+The GMU is a programmable power controller for the GPU. the CPU controls the
+GMU which in turn handles power controls for the GPU.
+
+Required properties:
+- compatible: "qcom,adreno-gmu-XYZ.W", "qcom,adreno-gmu"
+    for example: "qcom,adreno-gmu-630.2", "qcom,adreno-gmu"
+  Note that you need to list the less specific "qcom,adreno-gmu"
+  for generic matches and the more specific identifier to identify
+  the specific device.
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
+		compatible="qcom,adreno-gmu-630.2", "qcom,adreno-gmu";
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
index 4ad5e70e5c3e..9c89f4fdb8ca 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
@@ -8,14 +8,23 @@ Required properties:
   with the chip-id.
 - reg: Physical base address and length of the controller's registers.
 - interrupts: The interrupt signal from the gpu.
-- clocks: device clocks
+- clocks: device clocks (if applicable)
   See ../clocks/clock-bindings.txt for details.
-- clock-names: the following clocks are required:
+- clock-names: the following clocks are required by a3xx, a4xx and a5xx
+  cores:
   * "core"
   * "iface"
   * "mem_iface"
+  For GMU attached devices the GPU clocks are not used and are not required. The
+  following devices should not list clocks:
+   - qcom,adreno-630.2
+- iommus: optional phandle to an adreno iommu instance
+- operating-points-v2: optional phandle to the OPP operating points
+- qcom,gmu: For GMU attached devices a phandle to the GMU device that will
+  control the power for the GPU. Applicable targets:
+    - qcom,adreno-630.2
 
-Example:
+Example 3xx/4xx/a5xx:
 
 / {
 	...
@@ -35,3 +44,30 @@ Example:
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
