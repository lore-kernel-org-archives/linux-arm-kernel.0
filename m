From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 18 Apr 2012 04:53:58 -0600 (MDT)
Subject: [PATCH] ARM: omap: hwmod: warn only when clkdm is missing from
 both clk and hwmod
In-Reply-To: <4F8E9794.5090403@ti.com>
References: <1334238098-29859-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1204121106010.29473@utopia.booyaka.com>
 <4F8E76C3.7080803@ti.com>
 <alpine.DEB.2.00.1204180217380.29048@utopia.booyaka.com>
 <4F8E84DC.70600@ti.com>
 <alpine.DEB.2.00.1204180312160.29048@utopia.booyaka.com>
 <4F8E8FF7.4000706@ti.com>
 <alpine.DEB.2.00.1204180406550.29048@utopia.booyaka.com>
 <4F8E9794.5090403@ti.com>
Message-ID: <alpine.DEB.2.00.1204180448350.29048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Apr 2012, Cousson, Benoit wrote:

> But the model is already different for OMAP4.

We're running both models at the same time in mainline for OMAP4, 
effectively.

> Yeah, I'm just reluctant to add some more data in an already big file, 
> knowing that this information will be useless, just because a couple of 
> broken drivers does need that.
> 
> What we plan to do with the migration to CCF is to keep these specific 
> nodes only for the broken drivers to highlight that these ones need to 
> be fixed. And thus only these nodes will need the clkdm information.

Sounds like after your series, we'll only take both approaches for the 
broken drivers, and then just do the hwmod clockdomain sequence for the 
majority?  That sounds reasonable to me.  We should probably log a warning 
for those cases too.


regards,

- Paul
