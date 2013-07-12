From: marex@denx.de (Marek Vasut)
Date: Fri, 12 Jul 2013 05:54:35 +0200
Subject: [PATCH v12 06/13] usb: chipidea: add otg_cap attribute for otg
 capable
In-Reply-To: <20130712025833.GA14793@nchen-desktop>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <201307111736.11065.marex@denx.de> <20130712025833.GA14793@nchen-desktop>
Message-ID: <201307120554.35403.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

> On Thu, Jul 11, 2013 at 05:36:10PM +0200, Marek Vasut wrote:
> > Dear Peter Chen,
> > 
> > > Since we need otgsc to know vbus's status at some chipidea
> > > controllers even it is peripheral-only mode. Besides, some
> > > SoCs (eg, AR9331 SoC) don't have otgsc register even
> > > the DCCPARAMS_DC and DCCPARAMS_HC are both 1 at CAP_DCCPARAMS.
> > > We inroduce otg_cap attribute to indicate if the controller
> > > is otg capable, defaultly, we follow the rule that if DCCPARAMS_DC
> > > and DCCPARAMS_HC are both 1 at CAP_DCCPARAMS are otg capable, but if
> > > there is exception, the platform can override it by device tree or
> > > platform data.
> > > 
> > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > ---
> > > 
> > >  drivers/usb/chipidea/core.c  |   35
> > >  ++++++++++++++++++++++++++++------- include/linux/usb/chipidea.h |  
> > >  13 +++++++++++++
> > >  2 files changed, 41 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > > index 93961ff..e8ceb04 100644
> > > --- a/drivers/usb/chipidea/core.c
> > > +++ b/drivers/usb/chipidea/core.c
> > > @@ -405,6 +405,18 @@ static inline void ci_role_destroy(struct ci_hdrc
> > > *ci)
> > > 
> > >  	ci_hdrc_host_destroy(ci);
> > >  
> > >  }
> > > 
> > > +static void ci_get_otg_capable(struct ci_hdrc *ci)
> > > +{
> > > +	if (ci->platdata->otg_cap != OTG_CAP_ATTR_IS_NOT_EXISTED)
> > 
> > IS_NONEXISTENT , no?
> 
> You mean the English for this string? ok, I can change.

Yes, IS_NOT_EXISTED doesn't make much sense. Sorry, don't mean to nitpick.

> It means if the "otg_cap" is not existed at platform data,
> then, the "otg_cap" can be determined by DCCPARAMS

Then maybe just call it OTG_CAP_ATTR_NOT_SET or something .

Best regards,
Marek Vasut
