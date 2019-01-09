Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61943C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:14:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2140320660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r0gcV6BK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2140320660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=09Ffhkjyb05qRMQ2xqew/GU/7RWMIYhImbLtGpHNiok=; b=r0gcV6BK+wS6m6
	oRf16bBm/7z6qKl8fE2D75/m70lLXQJUEBVlSIhQd2OWFELQkw8rkpKLVEwS+2ECTM1z3w9zyAeqx
	tDvT9fRI3ELbubUteYHf2QDRi8QU9nrxjh62HedtBT56oS/G7Ebv3QB5nBQaDuBmI7IwM54uqYf/0
	l/lEFOYQl5Qm+O3ntTxInx0CfwCqI2AFR3usci++L+ugXIse4lerbyNEDfEUSZrwqQhB4gacvmQvZ
	zoF1QanRdrh/psT4vdBLssQ1R7ToQIWzNWbKPrfK1++qTY5ucvcz6AQyj998N2exIv+pIw9iCUOxk
	sic6cbX8tpPTyoag4CHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghHR4-0004nG-B5; Wed, 09 Jan 2019 17:14:34 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghHQz-0004mA-H5; Wed, 09 Jan 2019 17:14:31 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: eballetbo) with ESMTPSA id 4EA9526024A
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] phy: phy-rockchip-inno-usb2: drop reading the utmi-avalid
 property
Date: Wed,  9 Jan 2019 18:14:15 +0100
Message-Id: <20190109171415.9954-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_091429_694919_A0FB5723 
X-CRM114-Status: GOOD (  13.76  )
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
Cc: heiko@sntech.de, groeck@google.com, kieran.bingham@ideasonboard.com,
 Kishon Vijay Abraham I <kishon@ti.com>, linux-rockchip@lists.infradead.org,
 kernel@collabora.com, bleung@chromium.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

That property is no used in mainline and is not documented. The only
board using that property is the rk33-99-evb-rev1 and -rev2 in the
vendor kernel. The existence of a further -rev3 (which also looks way
better cared for compared rev1+2) indicates that the older ones are
probably some sort of preproduction models, where some wiring (on the soc
or board) may have gone wrong.

It is also not clear why this is a hardware-description or a DT
property, so, as noboby seems to care of this just drop reading that
property.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Hi all,

This patch was send for the first time within these series [1], but
might have more sense sent alone as doesn't depedends on the rest of
the series, so, remove from these series and send a second version
that can be applied independently.

Best regards,
Enric

[1] https://lkml.org/lkml/2018/8/15/141

Changes in v2:
- Split from the first version and send as a separate patch.
- Include the research that Heiko did in the commit message.

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index a1f2253d60c1..ba07121c3eff 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -168,9 +168,6 @@ struct rockchip_usb2phy_cfg {
  * @phy: generic phy.
  * @port_id: flag for otg port or host port.
  * @suspended: phy suspended flag.
- * @utmi_avalid: utmi avalid status usage flag.
- *	true	- use avalid to get vbus status
- *	false	- use bvalid to get vbus status
  * @vbus_attached: otg device vbus status.
  * @bvalid_irq: IRQ number assigned for vbus valid rise detection.
  * @ls_irq: IRQ number assigned for linestate detection.
@@ -189,7 +186,6 @@ struct rockchip_usb2phy_port {
 	struct phy	*phy;
 	unsigned int	port_id;
 	bool		suspended;
-	bool		utmi_avalid;
 	bool		vbus_attached;
 	int		bvalid_irq;
 	int		ls_irq;
@@ -545,12 +541,8 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 	unsigned long delay;
 	bool vbus_attach, sch_work, notify_charger;
 
-	if (rport->utmi_avalid)
-		vbus_attach = property_enabled(rphy->grf,
-					       &rport->port_cfg->utmi_avalid);
-	else
-		vbus_attach = property_enabled(rphy->grf,
-					       &rport->port_cfg->utmi_bvalid);
+	vbus_attach = property_enabled(rphy->grf,
+				       &rport->port_cfg->utmi_bvalid);
 
 	sch_work = false;
 	notify_charger = false;
@@ -1024,9 +1016,6 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 	INIT_DELAYED_WORK(&rport->chg_work, rockchip_chg_detect_work);
 	INIT_DELAYED_WORK(&rport->otg_sm_work, rockchip_usb2phy_otg_sm_work);
 
-	rport->utmi_avalid =
-		of_property_read_bool(child_np, "rockchip,utmi-avalid");
-
 	/*
 	 * Some SoCs use one interrupt with otg-id/otg-bvalid/linestate
 	 * interrupts muxed together, so probe the otg-mux interrupt first,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
