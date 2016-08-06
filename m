From: hzpeterchen@gmail.com (Peter Chen)
Date: Sat, 6 Aug 2016 15:42:58 +0800
Subject: [PATCH v2 04/22] usb: chipidea: Only read/write OTGSC from one
 place
In-Reply-To: <147043329762.26915.1413688974325107381@sboyd-linaro>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-5-stephen.boyd@linaro.org>
 <20160708091456.GC20485@shlinux2>
 <147043329762.26915.1413688974325107381@sboyd-linaro>
Message-ID: <20160806074258.GA12298@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2016 at 02:41:37PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-07-08 02:14:57)
> > On Thu, Jul 07, 2016 at 03:20:55PM -0700, Stephen Boyd wrote:
> > > diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
> > > index 03b6743461d1..a6fc60934297 100644
> > > --- a/drivers/usb/chipidea/otg.c
> > > +++ b/drivers/usb/chipidea/otg.c
> > > @@ -104,7 +104,31 @@ void ci_handle_vbus_change(struct ci_hdrc *ci)
> > >               usb_gadget_vbus_disconnect(&ci->gadget);
> > >  }
> > >  
> > > -#define CI_VBUS_STABLE_TIMEOUT_MS 5000
> > > +/**
> > > + * When we switch to device mode, the vbus value should be lower
> > > + * than OTGSC_BSV before connecting to host.
> > > + *
> > > + * @ci: the controller
> > > + *
> > > + * This function returns an error code if timeout
> > > + */
> > > +static int hw_wait_otgsc_bsv(struct ci_hdrc *ci)
> > 
> > I think the function name should reflect "we wait for vbus lower than bsv"
> > Care to change one?
> > 
> 
> Sure, something like hw_wait_vbus_lower_bsv()?

Agree.

-- 

Best Regards,
Peter Chen
