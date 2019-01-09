Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780D9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:32:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453BF21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uii8Vt57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453BF21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jnmjKz2qWq6h8AttlTww2dDmkJZRnV5BuwK8Z/pg174=; b=uii8Vt5765Ofig
	Vjm2m8oqts+0JBzeXESpFhPVDJE+cBuU3q3YA4rwdBKe16S/xjsDSu1+KG1AjqcDfqa68wa2DFwqx
	DuuWqZ8i2VDwxaG0ojN0J0VRVHBG69BzhO/RSYOdNZ2/XIYGDviNaYeqp5IxuaUigR9ps1IGG87xs
	t9oX4OWXX4IJQyYch/B5idYyPoQGTc69AoJAxz/dyvjN3kh8htq6m1JluUJs2t4MES5LxpO+4a1kE
	9HNyfJnIRSyTdcvMIcxOiFiFGUGZo42cLDOKxEofd6VyHx7iR6e0eCr+SMtMR+BAeV5Re7VdpNrRk
	F4JvBcROm1o1PDfpEdMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghB9q-0007TE-Ny; Wed, 09 Jan 2019 10:32:22 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghB9m-0007SW-Jm; Wed, 09 Jan 2019 10:32:20 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: eballetbo) with ESMTPSA id 2865B2761EC
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] phy: rockchip-inno-usb2: fix misspelling and kernel-doc
 documentation
Date: Wed,  9 Jan 2019 11:32:06 +0100
Message-Id: <20190109103206.21796-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_023218_910374_C30D3A17 
X-CRM114-Status: GOOD (  11.78  )
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
 linux-arm-kernel@lists.infradead.org, amstan@chromium.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fix the typo flase -> false and clean up the kernel-doc documentation in
phy-rockchip-inno.usb2.c and fix the following warnings when documentation
is built.

  :58: warning: missing initial short description
  :69: warning: cannot understand function prototype: 'enum usb_chg_state '
  :97: warning: missing initial short description
  :136: warning: cannot understand function prototype: 'struct rockchip_usb2phy_port_cfg '
  :157: warning: cannot understand function prototype: 'struct rockchip_usb2phy_cfg '
  :163: warning: Function parameter or member 'port_cfgs' not described in 'rockchip_usb2phy_cfg'
  :187: warning: cannot understand function prototype: 'struct rockchip_usb2phy_port '
  :204: warning: Function parameter or member 'port_cfg' not described in 'rockchip_usb2phy_port'
  :207: warning: missing initial short description
  :234: warning: Function parameter or member 'dev' not described in 'rockchip_usb2phy'
  :234: warning: Function parameter or member 'clk480m_hw' not described in 'rockchip_usb2phy'

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Hi all,

This patch was send for the first time within these series [1], but
might have more sense sent alone as doesn't depends on the rest of the
series, so, remove from these series and send a second version adding
the Heiko's Reviewed-by tag.

Best regards,
  Enric

[1] https://lkml.org/lkml/2018/8/15/141

Changes in v2:
- Add Heiko's Reviewed-by tag.
- Split from the first version and send as a separate patch.

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 35 ++++++++++---------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 91fba60267a0..a1f2253d60c1 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -55,16 +55,16 @@ enum rockchip_usb2phy_host_state {
 };
 
 /**
- * Different states involved in USB charger detection.
- * USB_CHG_STATE_UNDEFINED	USB charger is not connected or detection
+ * enum usb_chg_state - Different states involved in USB charger detection.
+ * @USB_CHG_STATE_UNDEFINED:	USB charger is not connected or detection
  *				process is not yet started.
- * USB_CHG_STATE_WAIT_FOR_DCD	Waiting for Data pins contact.
- * USB_CHG_STATE_DCD_DONE	Data pin contact is detected.
- * USB_CHG_STATE_PRIMARY_DONE	Primary detection is completed (Detects
+ * @USB_CHG_STATE_WAIT_FOR_DCD:	Waiting for Data pins contact.
+ * @USB_CHG_STATE_DCD_DONE:	Data pin contact is detected.
+ * @USB_CHG_STATE_PRIMARY_DONE:	Primary detection is completed (Detects
  *				between SDP and DCP/CDP).
- * USB_CHG_STATE_SECONDARY_DONE	Secondary detection is completed (Detects
- *				between DCP and CDP).
- * USB_CHG_STATE_DETECTED	USB charger type is determined.
+ * @USB_CHG_STATE_SECONDARY_DONE: Secondary detection is completed (Detects
+ *				  between DCP and CDP).
+ * @USB_CHG_STATE_DETECTED:	USB charger type is determined.
  */
 enum usb_chg_state {
 	USB_CHG_STATE_UNDEFINED = 0,
@@ -94,7 +94,7 @@ struct usb2phy_reg {
 };
 
 /**
- * struct rockchip_chg_det_reg: usb charger detect registers
+ * struct rockchip_chg_det_reg - usb charger detect registers
  * @cp_det: charging port detected successfully.
  * @dcp_det: dedicated charging port detected successfully.
  * @dp_det: assert data pin connect successfully.
@@ -120,7 +120,7 @@ struct rockchip_chg_det_reg {
 };
 
 /**
- * struct rockchip_usb2phy_port_cfg: usb-phy port configuration.
+ * struct rockchip_usb2phy_port_cfg - usb-phy port configuration.
  * @phy_sus: phy suspend register.
  * @bvalid_det_en: vbus valid rise detection enable register.
  * @bvalid_det_st: vbus valid rise detection status register.
@@ -148,10 +148,11 @@ struct rockchip_usb2phy_port_cfg {
 };
 
 /**
- * struct rockchip_usb2phy_cfg: usb-phy configuration.
+ * struct rockchip_usb2phy_cfg - usb-phy configuration.
  * @reg: the address offset of grf for usb-phy config.
  * @num_ports: specify how many ports that the phy has.
  * @clkout_ctl: keep on/turn off output clk of phy.
+ * @port_cfgs: usb-phy port configurations.
  * @chg_det: charger detection registers.
  */
 struct rockchip_usb2phy_cfg {
@@ -163,12 +164,13 @@ struct rockchip_usb2phy_cfg {
 };
 
 /**
- * struct rockchip_usb2phy_port: usb-phy port data.
+ * struct rockchip_usb2phy_port - usb-phy port data.
+ * @phy: generic phy.
  * @port_id: flag for otg port or host port.
  * @suspended: phy suspended flag.
  * @utmi_avalid: utmi avalid status usage flag.
  *	true	- use avalid to get vbus status
- *	flase	- use bvalid to get vbus status
+ *	false	- use bvalid to get vbus status
  * @vbus_attached: otg device vbus status.
  * @bvalid_irq: IRQ number assigned for vbus valid rise detection.
  * @ls_irq: IRQ number assigned for linestate detection.
@@ -178,7 +180,7 @@ struct rockchip_usb2phy_cfg {
  * @chg_work: charge detect work.
  * @otg_sm_work: OTG state machine work.
  * @sm_work: HOST state machine work.
- * @phy_cfg: port register configuration, assigned by driver data.
+ * @port_cfg: port register configuration, assigned by driver data.
  * @event_nb: hold event notification callback.
  * @state: define OTG enumeration states before device reset.
  * @mode: the dr_mode of the controller.
@@ -203,12 +205,13 @@ struct rockchip_usb2phy_port {
 };
 
 /**
- * struct rockchip_usb2phy: usb2.0 phy driver data.
+ * struct rockchip_usb2phy - usb2.0 phy driver data.
+ * @dev: pointer to device.
  * @grf: General Register Files regmap.
  * @usbgrf: USB General Register Files regmap.
  * @clk: clock struct of phy input clk.
  * @clk480m: clock struct of phy output clk.
- * @clk_hw: clock struct of phy output clk management.
+ * @clk480m_hw: clock struct of phy output clk management.
  * @chg_state: states involved in USB charger detection.
  * @chg_type: USB charger types.
  * @dcd_retries: The retry count used to track Data contact
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
