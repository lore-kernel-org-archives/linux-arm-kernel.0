From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 26 Nov 2012 15:40:05 +0000
Subject: [PATCH v3 6/7] usb: chipidea: usbmisc: add mx53 support
In-Reply-To: <20121125080931.GB16062@nchen-desktop>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
 <1353506793-8354-7-git-send-email-m.grzeschik@pengutronix.de>
 <20121123065340.GD22420@nchen-desktop> <50AF49A5.6030708@pengutronix.de>
 <20121125080931.GB16062@nchen-desktop>
Message-ID: <20121126154005.8CC8D3E1ABE@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 25 Nov 2012 16:09:31 +0800, Peter Chen <peter.chen@freescale.com> wrote:
> On Fri, Nov 23, 2012 at 11:02:13AM +0100, Marc Kleine-Budde wrote:
> > On 11/23/2012 07:53 AM, Peter Chen wrote:
> > > On Wed, Nov 21, 2012 at 03:06:32PM +0100, Michael Grzeschik wrote:
> > >> This adds mx53 as the next user of the usbmisc driver and makes it
> > >> possible to disable the overcurrent-detection of the internal phy.
> > >>
> > >> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > >> ---
> > >> Changes since v2:
> > >> * added defines for register offsets and bitmasks
> > >> * fixed disable_oc option for all ports
> > >>
> > >>  drivers/usb/chipidea/usbmisc_imx.c |   51 ++++++++++++++++++++++++++++++++++++
> > >>  1 file changed, 51 insertions(+)
> > >>
> > >> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> > >> index e090e0f..b1811df 100644
> > >> --- a/drivers/usb/chipidea/usbmisc_imx.c
> > >> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> > >> @@ -19,6 +19,13 @@
> > >>  
> > >>  #define USB_DEV_MAX 4
> > >>  
> > >> +#define MX53_USB_OTG_PHY_CTRL_0_OFFSET	0x08;
> > >> +#define MX53_USB_UH2_CTRL_OFFSET	0x14;
> > >> +#define MX53_USB_UH3_CTRL_OFFSET	0x18;
> > >> +#define MX53_BM_OVER_CUR_DIS_H1		BIT(5)
> > >> +#define MX53_BM_OVER_CUR_DIS_OTG	BIT(8)
> > >> +#define MX53_BM_OVER_CUR_DIS_UHx	BIT(30)
> > >> +
> > >>  #define MX6_BM_OVER_CUR_DIS		BIT(7)
> > > 
> > > As every SoC platform's non-core register mapping is different,
> > > it is better to use .h to put register bit definition
> > 
> > AFAIK in the kernel we don't make extra .h files any more, if there is
> > only a single user of the contents.
> OK, if it is the current rule for kernel, then just keep it.
> My original mind was there will be more and more bit definition
> in future, and move it to .h to make the code clean and short.

Yeah. If there is only one user then keep it in the .c file. The kernel
is huge, so keeping things out of the global scope is a GoodThing(tm).

g.
