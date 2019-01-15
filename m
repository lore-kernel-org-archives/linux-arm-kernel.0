Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE49C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:44:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3661206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B/TSYYok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3661206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CKlObq2fklSqNVZ9vUuiguaH+QdVlpfkdWK3Wp1Ev3Y=; b=B/TSYYokwYV6xW
	k6CIa4mqcAGLZ0q56JVYhkDPr8GIlJFtg770l80VtKqkziR25woXH1NAxkLXegXBkXiDKjnRDPfgK
	+SHbx8Gf1pYSbPr6E2N/BwXXM9Dsn015LC+ogVMFOH4MP4GypTXXQ5oKqq8QZvWcXF7IOwrP/CoVb
	2dTL7m3mgO0kyrj+UpGKHorvw1ZqWPOElA5uOvuqy3ec5cJGeWr3/W2e1j9QxPfwexwAAW3hwjvVx
	jUKtnsB5ZhZZg0fHZdmjB8uug5w4C/3ez0CikrG6JDDjbDju0J18xXhWC1b2GydpFO8OuhVt+UplA
	y3F+nHzqzQV8QdHwouyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjDm1-0005RL-2m; Tue, 15 Jan 2019 01:44:13 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjDlw-0005PL-Nk; Tue, 15 Jan 2019 01:44:10 +0000
X-UUID: cf3a5501b1de4277b7b0cad3df737db0-20190114
X-UUID: cf3a5501b1de4277b7b0cad3df737db0-20190114
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1877873512; Mon, 14 Jan 2019 17:43:58 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Jan 2019 17:43:56 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 09:43:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Jan 2019 09:43:53 +0800
From: <min.guo@mediatek.com>
To: Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: usb: musb: Add support for MediaTek musb
 controller
Date: Tue, 15 Jan 2019 09:43:43 +0800
Message-ID: <1547516626-5084-2-git-send-email-min.guo@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_174408_783490_F80A930E 
X-CRM114-Status: GOOD (  12.97  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, Min Guo <min.guo@mediatek.com>,
 chunfeng.yun@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Min Guo <min.guo@mediatek.com>

This adds support for MediaTek musb controller in
host, peripheral and otg mode.

Signed-off-by: Min Guo <min.guo@mediatek.com>
---
 .../devicetree/bindings/usb/mediatek,musb.txt      | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt

diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
new file mode 100644
index 0000000..3e3f671
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
@@ -0,0 +1,43 @@
+MediaTek musb DRD/OTG controller
+-------------------------------------------
+
+Required properties:
+ - compatible      : should be "mediatek,mtk-musb"
+ - reg             : specifies physical base address and size of
+   the registers
+ - interrupts      : interrupt used by musb controller
+ - interrupt-names : must be "mc"
+ - phys            : PHY specifier for the OTG phy
+ - dr_mode         : should be one of "host", "peripheral" or "otg",
+   refer to usb/generic.txt
+ - clocks          : a list of phandle + clock-specifier pairs, one for
+   each entry in clock-names
+ - clock-names     : must contain "main", "mcu", "univpll"
+   for clocks of controller
+
+Optional properties:
+ - extcon : external connector for VBUS and IDPIN changes detection,
+   needed when supports dual-role mode.
+ - vbus-supply : reference to the VBUS regulator, needed when supports
+   dual-role mode.
+ - power-domains   : a phandle to USB power domain node to control USB's
+   MTCMOS
+
+Example:
+
+usb2: usb@11200000 {
+	compatible = "mediatek,mt2701-musb",
+		     "mediatek,mtk-musb";
+	reg = <0 0x11200000 0 0x1000>;
+	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-names = "mc";
+	phys = <&u2port2 PHY_TYPE_USB2>;
+	vbus-supply = <&usb_vbus>;
+	extcon = <&extcon_usb>;
+	dr_mode = "otg";
+	clocks = <&pericfg CLK_PERI_USB0>,
+		 <&pericfg CLK_PERI_USB0_MCU>,
+		 <&pericfg CLK_PERI_USB_SLV>;
+	clock-names = "main","mcu","univpll";
+	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
+};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
