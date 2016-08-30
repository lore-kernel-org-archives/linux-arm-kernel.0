From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 30 Aug 2016 19:26:21 +0800
Subject: [PATCH] ARM: imx6: add missing BM_CLPCR_BYPASS_PMIC_READY
 setting for imx6sx
In-Reply-To: <AM3PR04MB1315B37C3A91FFF7F3A374B0F5E10@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1471881205-6389-1-git-send-email-Anson.Huang@nxp.com>
 <AM3PR04MB1315B37C3A91FFF7F3A374B0F5E10@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <20160830112621.GB8363@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 11:37:27PM +0000, Yongcai Huang wrote:
> Ping..
> 
> Just a kind reminder in case this patch is missed, without this patch, i.MX6SX latest suspend/resume can NOT work.
> 
> Best Regards!
> Anson Huang
> 
> 
> 
> > -----Original Message-----
> > From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org]
> > On Behalf Of Anson Huang
> > Sent: 2016-08-22 11:53 PM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>; Peter Chen
> > <peter.chen@nxp.com>; shawnguo at kernel.org; kernel at pengutronix.de
> > Subject: [PATCH] ARM: imx6: add missing BM_CLPCR_BYPASS_PMIC_READY
> > setting for imx6sx
> > 
> > i.MX6SX has bypass PMIC ready function, as this function is normally NOT
> > enabled on the board design, so we need to bypass the PMIC ready pin check
> > during DSM mode resume flow, otherwise, the internal DSM resume logic will
> > be waiting for this signal to be ready forever and cause resume fail.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied as a fix and Cc-ed stable as requested by Peter.

Shawn
