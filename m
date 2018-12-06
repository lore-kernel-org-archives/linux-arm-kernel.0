Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722F4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:03:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B6F20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LNyj5BjO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="LkX0SAMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B6F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JI72cpF0u4H9rbpwRk2b+6LtOx0CisfA1oPnd0hpbKE=; b=LNyj5BjOyotuZH2CqB+Rou7W4y
	6bIFYnjs/fuD3x9nuxMuFLuTsr6zRpeXCpaTKzp17dSdI83AMXixQBTO3J+fKBZZBHKhb7fDv88IO
	iTYdDwWaZ+CsapwLpKYa/h+9gwNGHbQpsnfT4BoBmgEx4kILhQHvHSOcp1FbYCp6Fr4sjXxqiTtL+
	pS2SUu/ZcpWAX8BNJFqo4eiFbz8X7s5sZzk8LwnKSpeGMxqYqNRWDvUfpTaoz1c34jRxz5eHEUPvJ
	Z0Fx5ue6GBylV+eIocYGZkt+oUplypQ7aM4U0/aBcmNYQovBRPjAB/0ckA3wOQmYUDumqoPm/o5xK
	F0DlQZTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1jW-0004xw-Pi; Thu, 06 Dec 2018 22:02:58 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1jE-0004aB-TP
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:02:55 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 572BF25BEF0;
 Fri,  7 Dec 2018 08:58:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133514; bh=byqC1gdPrQtUmBdEvRqfbpOK0d5t1Ix8lfulkjHTvWQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LkX0SAMy7fhMW1s4yvdFUw5mVaYFBQxjwp0oD4yjrh/wDWFOAD5VfS58Bx7+VkDwc
 x3biK6wF+9BogaCTjrDksrACtsZ403P3JWZsPYeb93YyntVKel7DIPfQ9+bEo0Cu9s
 Iuf5cyG7v6865pZtDuOGsaH26rAUJylwSGNyXjLA=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 504BEE2329B; Thu,  6 Dec 2018 13:58:31 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 15/34] ARM: dts: r8a7744: USB 2.0 host support
Date: Thu,  6 Dec 2018 13:58:10 -0800
Message-Id: <ce28396b7a8621e048cfb8d002bc869b428a905e.1544125558.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544125558.git.horms+renesas@verge.net.au>
References: <cover.1544125558.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_140241_796615_A5C52EFD 
X-CRM114-Status: GOOD (  11.08  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Biju Das <biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Describe internal PCI bridge devices, USB phy device and
link PCI USB devices to USB phy.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7744.dtsi | 77 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 3f7674b2aac5..1d4cb5e447cd 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -454,8 +454,25 @@
 		};
 
 		usbphy: usb-phy@e6590100 {
+			compatible = "renesas,usb-phy-r8a7744",
+				     "renesas,rcar-gen2-usb-phy";
 			reg = <0 0xe6590100 0 0x100>;
-			/* placeholder */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cpg CPG_MOD 704>;
+			clock-names = "usbhs";
+			power-domains = <&sysc R8A7744_PD_ALWAYS_ON>;
+			resets = <&cpg 704>;
+			status = "disabled";
+
+			usb0: usb-channel@0 {
+				reg = <0>;
+				#phy-cells = <1>;
+			};
+			usb2: usb-channel@2 {
+				reg = <2>;
+				#phy-cells = <1>;
+			};
 		};
 
 		dmac0: dma-controller@e6700000 {
@@ -847,23 +864,73 @@
 		};
 
 		pci0: pci@ee090000 {
-			reg = <0 0xee090000 0 0xc00>;
+			compatible = "renesas,pci-r8a7744",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			reg = <0 0xee090000 0 0xc00>,
+			      <0 0xee080000 0 0x1100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			power-domains = <&sysc R8A7744_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			status = "disabled";
 
 			bus-range = <0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-			/* placeholder */
+			ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
+			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
+					 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
+					 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb@1,0 {
+				reg = <0x800 0 0 0 0>;
+				phys = <&usb0 0>;
+				phy-names = "usb";
+			};
+
+			usb@2,0 {
+				reg = <0x1000 0 0 0 0>;
+				phys = <&usb0 0>;
+				phy-names = "usb";
+			};
 		};
 
 		pci1: pci@ee0d0000 {
-			reg = <0 0xee0d0000 0 0xc00>;
+			compatible = "renesas,pci-r8a7744",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			reg = <0 0xee0d0000 0 0xc00>,
+			      <0 0xee0c0000 0 0x1100>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			power-domains = <&sysc R8A7744_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			status = "disabled";
 
 			bus-range = <1 1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-			/* placeholder */
+			ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
+			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+					 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+					 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb@1,0 {
+				reg = <0x10800 0 0 0 0>;
+				phys = <&usb2 0>;
+				phy-names = "usb";
+			};
+
+			usb@2,0 {
+				reg = <0x11000 0 0 0 0>;
+				phys = <&usb2 0>;
+				phy-names = "usb";
+			};
 		};
 
 		sdhi0: sd@ee100000 {
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
