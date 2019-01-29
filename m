Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5723C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:35:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62D520844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KBQTAt4R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMLbavHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62D520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0xBHVmMZ7fe18PgUrZHJW6P8u2Gfq7UmdnNq89Xs0bg=; b=KBQTAt4RIMKjiF9QB5kSbBlq+e
	fw3oWIVLYVoTx10BE4k6TFLfFPx1729EtazykMs1kLie3KSTbZSyIWWKKhbylkwsBK8jcrxmpe9Vc
	TsDVfDckckQf2aeX+/6cdJIMKaFglFY/zLQgFD3PLi48lbp4wtuNCVBFM6efI/I3OOEecBUzRrZHK
	VAxdrsAPBQ78kGRE8BVNUh2TdnxELZNj+zG1UhtlrxWxzmvrh6KFXUADlkC1Wf2+AJmIRur2juORt
	xyy1Fy94uj5tQRSf/j5JXw+zvazumQnMVm0pvcBdZ1sodSLrxM9olXddjUD9yLjA+eKDowwhiKHet
	oZutWVow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goRg3-0007z1-VW; Tue, 29 Jan 2019 11:35:39 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRfn-0007iz-4L
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 11:35:25 +0000
Received: by mail-wm1-x343.google.com with SMTP id a62so17442186wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 03:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vJnKrcfM/+d9v4u5OjjWenwaWoG5s67rgvvgtB7HnPo=;
 b=AMLbavHhWoi6TWDvhbqvNZYHidPLMTf8rCfWS2eoDhSByogT6TK3QbVJEl8EQ61R8P
 bKeeHTnZYfvAEbqucIc9d3KdfeoHHcxGAY4vxSPDkkGO0CMcU08GcYKpBtu66mW/o7XD
 CjcWDxk3mgzmwFfhcTzoWckakzejfTuXOyo7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vJnKrcfM/+d9v4u5OjjWenwaWoG5s67rgvvgtB7HnPo=;
 b=tdKxFB4IUe5mnbYs9xP3w/WUwnuI3JTQRglZpgqAsQj23JUaeUNfVCXJJFsGTjzK49
 EvSmmKXTlq4hMJeHpuzhbnrfdxGzq5SzqVkgblnNV2DskX82S712b1V/CX22GpPsnRWr
 iJaSOei0DPeDX1k2WBAqskLsPrNVYQoO+2E9m+A7Fpl+W221+L/EfsXZdtdxZcptVAmT
 3sMsfKRf3F73FfzSmLHasd24sAF6rvfWjrF9eODEfps8A1qPbGvCIouZhBkWpMXFh4Hr
 41hAurz9t58PSw5LKfiow7RUf3L1G84xdtBOGNhgedTvV11hpiVU18XTMfKCF0knApnH
 xRKw==
X-Gm-Message-State: AJcUukdCCJnfy+NJPtqQJw0j/iltN1cbc1c2WrcbNtSFZvkAMoLTijVf
 vA+tZTDEomU4/LhZHZ5x+Y0tMQ==
X-Google-Smtp-Source: ALg8bN5gPUfareuVF/+xOPS2D1Dc/OcgeVwYJG0RopNBAzp444G93viziKhe7kZlRodp5BFMnUKTrA==
X-Received: by 2002:a1c:b10a:: with SMTP id a10mr20438892wmf.148.1548761720574; 
 Tue, 29 Jan 2019 03:35:20 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id i192sm1960129wmg.7.2019.01.29.03.35.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 29 Jan 2019 03:35:20 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org,
 mark.rutland@arm.com, kishon@ti.com, jackp@codeaurora.org,
 andy.gross@linaro.org, swboyd@chromium.org
Subject: [PATCH v2 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY bindings
Date: Tue, 29 Jan 2019 12:35:14 +0100
Message-Id: <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_033523_174558_3CA6893B 
X-CRM114-Status: GOOD (  12.33  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-usb@vger.kernel.org, khasim.mohammed@linaro.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
 shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
controller embedded in QCS404.

Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
definitions.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt

diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
new file mode 100644
index 0000000..8ef6e39
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
@@ -0,0 +1,73 @@
+Qualcomm Synopsys 1.0.0 SS phy controller
+===========================================
+
+Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
+chipsets
+
+Required properties:
+
+- compatible:
+    Value type: <string>
+    Definition: Should contain "qcom,usb-ssphy".
+
+- reg:
+    Value type: <prop-encoded-array>
+    Definition: USB PHY base address and length of the register map.
+
+- #phy-cells:
+    Value type: <u32>
+    Definition: Should be 0. See phy/phy-bindings.txt for details.
+
+- clocks:
+    Value type: <prop-encoded-array>
+    Definition: See clock-bindings.txt section "consumers". List of
+		 three clock specifiers for reference, phy core and
+		 pipe clocks.
+
+- clock-names:
+    Value type: <string>
+    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
+		 property. Must contain "ref", "phy" and "pipe".
+
+- vdd-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator VDD supply node.
+
+- vdda1p8-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator 1.8V supply node.
+
+
+Optional child nodes:
+
+- vbus-supply:
+    Value type: <phandle>
+    Definition: phandle to the VBUS supply node.
+
+- resets:
+    Value type: <prop-encoded-array>
+    Definition: See reset.txt section "consumers". PHY reset specifiers
+		 for phy core and COR resets.
+
+- reset-names:
+    Value type: <string>
+    Definition: Names of the resets in 1-1 correspondence with the "resets"
+		 property. Must contain "com" and "phy".
+
+Example:
+
+usb3_phy: phy@78000 {
+	compatible = "qcom,usb-ssphy";
+	reg = <0x78000 0x400>;
+	#phy-cells = <0>;
+	clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+		 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+		 <&gcc GCC_USB3_PHY_PIPE_CLK>;
+	clock-names = "ref", "phy", "pipe";
+	resets = <&gcc GCC_USB3_PHY_BCR>,
+		 <&gcc GCC_USB3PHY_PHY_BCR>;
+	reset-names = "com", "phy";
+	vdd-supply = <&vreg_l3_1p05>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	vbus-supply = <&usb3_vbus_reg>;
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
