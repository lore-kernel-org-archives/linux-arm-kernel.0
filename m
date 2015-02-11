From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Feb 2015 12:26:12 -0800
Subject: [PATCH] ARM: OMAP1: PM: fix some build warnings on 1510-only
 Kconfigs
In-Reply-To: <54DB93DA.8050308@gmail.com>
References: <alpine.DEB.2.02.1502070020530.3767@utopia.booyaka.com>
 <54D9CFBC.3070405@nvidia.com> <54D9E42C.7010105@gmail.com>
 <alpine.DEB.2.02.1502110218090.3767@utopia.booyaka.com>
 <54DB93DA.8050308@gmail.com>
Message-ID: <20150211202611.GF2531@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jgchunter@gmail.com> [150211 09:43]:
> 
> Thinking about this some more, I don't understand the dependency on the
> DM_TIMER here. For an omap1 device, regardless of whether the DM_TIMERs
> are enable or not, the device should be able to enter low power if the
> 32K is enabled. Hence, shouldn't this have been !(CONFIG_OMAP_32K_TIMER)
> above?

Sounds about right, there are separate timers on omap1 and additional
gp timers. There's no 32KiHz timer on 1510 variants, including
720 and 730.
 
> Furthermore, you will get the above warning on a omap16xx only build if
> you disable DM_TIMERs and keep MPU_TIMER enabled, which should be a
> valid thing to do.
> 
> Tony, I see you added the DM_TIMER dependency in commit
> be26a008414414c69a4ae9fe9877401c3ba62c5a. I understand your motivation,
> but why not just use !(CONFIG_OMAP_32K_TIMER) here? Bit 9 of the idlect1
> is only for the TIMCK clock that is used for the MPU timers and not the
> DM_TIMERs.

Hmm yes looks like you're right. That check be done based on
!CONFIG_OMAP_32K_TIMER like you're saying.

Regards,

Tony
