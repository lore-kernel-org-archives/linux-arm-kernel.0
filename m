From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 30 Jun 2016 09:22:25 +0800
Subject: [PATCH 06/21] usb: chipidea: Initialize and reinitialize phy later
In-Reply-To: <146724983020.16253.12640673678669134952@sboyd-linaro>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-7-stephen.boyd@linaro.org>
 <20160629023052.GB25236@shlinux2>
 <146724983020.16253.12640673678669134952@sboyd-linaro>
Message-ID: <20160630012225.GA19928@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 06:23:50PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-06-28 19:30:52)
> > On Sun, Jun 26, 2016 at 12:28:23AM -0700, Stephen Boyd wrote:
> > > The ULPI phy on qcom platforms needs to be initialized and
> > > powered on after a USB reset and before we toggle the run/stop
> > > bit. Otherwise, the phy locks up and doesn't work properly.
> > 
> > This requirement is so strange, try to see if any other initialization
> > sequences.
> 
> I think the problem is that the reset bit also resets the phy because
> the phy is part of the same clock domain as the controller. Just a guess
> though.
> 
> >      
> > Since this driver is multi-platforms, I can't accept this change for
> > common, if you had to do that, would you please move your changes to
> > msm glue layer using CI_HDRC_CONTROLLER_RESET_EVENT and
> > CI_HDRC_CONTROLLER_STOPPED_EVENT? Besides, you need to add one flag
> > at ci_hdrc_platform_data.flags for your case to avoid normal
> > initialization.
> 
> Ok, let me see if I can make this work properly in the glue layer. I
> take it that you want me to add a flag for this specific case so that we
> don't do any phy control in the core and leave it up to the glue layer
> to handle, like CI_HDRC_DISABLE_PHY_CONTROL or something?

Yes

-- 

Best Regards,
Peter Chen
