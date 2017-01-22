From: peter.chen@nxp.com (Peter Chen)
Date: Sun, 22 Jan 2017 01:34:40 +0000
Subject: [PATCH v7 3/5] phy: Add set_vbus callback
In-Reply-To: <20170120185057.16206-4-stephen.boyd@linaro.org>
References: <20170120185057.16206-1-stephen.boyd@linaro.org>
 <20170120185057.16206-4-stephen.boyd@linaro.org>
Message-ID: <VI1PR04MB145568B8A2FFB8BE45E208948B730@VI1PR04MB1455.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
>  * @set_mode: set the mode of the phy
>+ * @set_vbus: enable/disable vbus in the phy (USB)
>  * @reset: resetting the phy
>  * @owner: the module owner containing the ops
>  */
>@@ -45,6 +46,7 @@ struct phy_ops {
> 	int	(*power_on)(struct phy *phy);
> 	int	(*power_off)(struct phy *phy);
> 	int	(*set_mode)(struct phy *phy, enum phy_mode mode);
>+	int	(*set_vbus)(struct phy *phy, int on);

How about using the name notify_vbus? The main purpose of this API is notify
PHY vbus status.

Peter
