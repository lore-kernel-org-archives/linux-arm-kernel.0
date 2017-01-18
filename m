From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 18 Jan 2017 15:34:32 +0800
Subject: [PATCH v6 23/25] usb: chipidea: Pullup D+ in device mode via phy
 APIs
In-Reply-To: <148467591341.23457.3638889856786813589@sboyd-linaro>
References: <20161228225711.698-1-stephen.boyd@linaro.org>
 <20161228225711.698-24-stephen.boyd@linaro.org>
 <20170103065318.GB14542@b29397-desktop>
 <148418039309.32258.7247753739063801774@sboyd-linaro>
 <20170112095040.GA15726@b29397-desktop>
 <148426139182.20672.2422337338087784924@sboyd-linaro>
 <20170113033536.GA20723@b29397-desktop>
 <148433778067.32719.6179204976256776867@sboyd-linaro>
 <20170116034551.GA27364@b29397-desktop>
 <148467591341.23457.3638889856786813589@sboyd-linaro>
Message-ID: <20170118073432.GA26659@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 09:58:33AM -0800, Stephen Boyd wrote:
> Quoting Peter Chen (2017-01-15 19:45:51)
> > 
> > So, you need to call phy_set_mode when switching between host and device.
> > Besides, you also need to toggle VBUSVLDEXT when the external vbus
> > is on or off at device mode (doesn't need for host mode), is it correct?
> 
> Correct.
> 
> > 
> > At include/linux/usb/phy.h, we have .set_vbus interface, maybe you need
> > to port it to generic phy framework.
> > 
> 
> Ok. I'll look into that. Can the other patches in this series be picked
> up? Otherwise I can resend them all again once I fix the phy_set_mode()
> call location and introduce a new phy op.

I can pick up chipidea patches after you test the patch I supplied at:

	[PATCH v6 11/25] usb: chipidea: vbus event may exist before starting
gadget

You may ping other maintainers to pick up other patches.

-- 

Best Regards,
Peter Chen
