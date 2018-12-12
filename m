Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405C9C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:31:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEE92084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VGLwD+tu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ljl2FdHM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L7ouhFP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEE92084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=20BozJauyge1tqklcEn4JZaWq9fFAh0KztY5e9++6zc=; b=VGLwD+tuulebbZprB+WwSo6d8I
	srwoDt8BkMUlqDEWE0yFm+8fpB3RQTd+aJuO68Ksb5Tt81PSjQ+xiwBuaM9Af9C7hZiu/LPoWCCoG
	BSh0dOxvdozvQT0JU6y2tE4rERPjdKlI+UDOg/XgV8QZmQmXx/UpdM+ONez3MRODStpupXYdtQ0Nu
	/V8Ck9YDkdCTvqPvE1T8X+MaAu54MtucJyfwI3tFrRekgyyt6FTiYVhAapkT9RlS2RQyazF2CtUBr
	yh7J2zHTOr/KzxpRH7gCYcfz9n3x84HW4V1qUhcJDDMROAV5RCVLb0xWd5mEbwYzAuDL8yzFQMW9/
	ZtBduytw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX8M1-000136-0b; Wed, 12 Dec 2018 17:31:25 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX8Lx-00011H-IL
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 17:31:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id A8D8E602FF; Wed, 12 Dec 2018 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544635871;
 bh=FmbJSqlzxLvWWfd5CtWfLAB0InZIDSPkI49VqFpBiro=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ljl2FdHMUvTnvzE8CMhqqMV8T+ZkzNb7r5DBZ5B698NX+RprQ89re/zySPtI8KGmn
 1tAuuppCAyQJLSJQT+a80MRmChV4QBBRmMCuMUMXpmT5l37i8ijVAiKC6Mp2ZOdujj
 43Pvb1ysTN0+rzrDO5W/hDVGfEOg+OhCsfeDWmrw=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 18DED601B4;
 Wed, 12 Dec 2018 17:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544635870;
 bh=FmbJSqlzxLvWWfd5CtWfLAB0InZIDSPkI49VqFpBiro=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L7ouhFP54gBPRSLXHzOmc9A4Xh15Ad+Cyp4v1j8yF2XWwbVUjk3z0+lDhclyOq4lV
 b/TahjY2aq5sbPkZrUl8yAwcRmOu/ADoEiINQxRv810yuTTuNWyT4oMbFHrpzllBGQ
 kk4GQ363Qp6yxO3zYL3xOfY6ZNSOOJ1lFjuEnloM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18DED601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 1/2] dt-bindings: Document,qcom,adreno-gmu
Date: Wed, 12 Dec 2018 10:31:05 -0700
Message-Id: <20181212173106.29618-2-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181212173106.29618-1-jcrouse@codeaurora.org>
References: <20181212173106.29618-1-jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_093121_641569_D74ECF0E 
X-CRM114-Status: GOOD (  13.78  )
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

Document the device tree bindings for the Adreno GMU device
available on Adreno a6xx targets.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 .../devicetree/bindings/display/msm/gmu.txt   | 54 +++++++++++++++++++
 .../devicetree/bindings/display/msm/gpu.txt   |  2 +
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
new file mode 100644
index 000000000000..f65bb49fff36
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
@@ -0,0 +1,54 @@
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
+			<0xb200000 0x300000>;
+		reg-names = "gmu", "gmu_pdc";
+
+		interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "hfi", "gmu";
+
+		clocks = <&clock_gpucc GPU_CC_CX_GMU_CLK>,
+			<&clock_gpucc GPU_CC_CXO_CLK>,
+			<&clock_gcc GCC_DDRSS_GPU_AXI_CLK>,
+			<&clock_gcc GCC_GPU_MEMNOC_GFX_CLK>;
+		clock-names = "gmu", "cxo", "axi", "memnoc";
+
+		power-domains = <&clock_gpucc GPU_CX_GDSC>;
+		iommus = <&adreno_smmu 5>;
+
+	i	operating-points-v2 = <&gmu_opp_table>;
+	};
+};
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
index 43fac0fe09bb..754f6c6f34e5 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
@@ -14,6 +14,8 @@ Required properties:
   * "core"
   * "iface"
   * "mem_iface"
+- qcom,gmu: For a6xx and newer targets a phandle to the GMU device that will
+  control the power for the GPU
 
 Example:
 
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
