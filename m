From: koen@dominion.thruhere.net (Koen Kooi)
Date: Thu, 18 Oct 2012 10:30:36 +0200
Subject: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
In-Reply-To: <20121018030654.GE2867@netboy.at.omicron.at>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
 <20121017235045.GB30550@atomide.com>
 <20121018030654.GE2867@netboy.at.omicron.at>
Message-ID: <41EC10C9-F961-40EA-992E-1D765F70BE03@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 18 okt. 2012, om 05:06 heeft Richard Cochran <richardcochran@gmail.com> het volgende geschreven:

> On Wed, Oct 17, 2012 at 04:50:46PM -0700, Tony Lindgren wrote:
>> * Paul Walmsley <paul@pwsan.com> [121017 16:39]:
>>> Hi Richard
>>> 
>>> On Wed, 17 Oct 2012, Richard Cochran wrote:
>>> 
>>>> Would you please take this bugfix for 3.7-rc2? The suggestion to mail
>>>> you came from Toni Lindgren. The context where it came from is here:
>>>> 
>>>> http://lists.arm.linux.org.uk/lurker/message/20121015.191630.bdae3c50.en.html
>>> 
>>> This patch appears to add a new feature, correct?  I don't think the CPSW 
>>> could have worked in the past without this data present.  So it looks to 
>>> me like this is 3.8 material, unless Tony would like it to go in sooner?
>> 
>> Yeah unless it fixes something, we should just queue it for v3.8 merge
>> window.
> 
> So there has been this cpsw driver since v3.4-rc1~177^2~5
> 
>   df82859 netdev: driver: ethernet: Add TI CPSW driver
> 
> and four people signed off on it, so it must have been working at one
> point. Since the device tree make-over, the driver is a derelict, and
> thus the present patch is fixing a regression.

Have a look at the tscadc driver for am335x that has had a few rounds of review. That one lacks DT bindings, so it can't be tested on this DT only platform. That a driver has been accepted in mainline does not mean it works, for am335x it just means that it compiles.

The patches I needed to get cpsw to work on beaglebone: https://github.com/beagleboard/kernel/tree/3.7/patches/cpsw

regards,

Koen
