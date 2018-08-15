From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Wed, 15 Aug 2018 11:59:31 +0200
Subject: [PATCH 1/4] phy: rockchip-inno-usb2: fix misspelling and kernel-doc
 documentation.
In-Reply-To: <20180815095934.11205-1-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
Message-ID: <20180815095934.11205-2-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 35 ++++++++++---------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 5049dac79bd0..e1ef3e34163c 100644
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
2.18.0
