From: tony@atomide.com (Tony Lindgren)
Date: Sat, 16 Nov 2013 07:22:40 -0800
Subject: [PATCH 03/11] ARM: dts: omap3-igep: Update to use the TI
 AM/DM37x processor.
In-Reply-To: <52878D0F.7040204@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
 <1384608224-9452-4-git-send-email-javier.martinez@collabora.co.uk>
 <20131116144412.GH10317@atomide.com>
 <52878D0F.7040204@collabora.co.uk>
Message-ID: <20131116152239.GK10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131116 07:21]:
> On 11/16/2013 03:44 PM, Tony Lindgren wrote:
> > * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131116 05:25]:
> >> From: Enric Balletbo i Serra <eballetbo@gmail.com>
> >> 
> >> Most of the boards are using the TI AM/DM37x processor, there is only a small
> >> quantity of IGEP Processor Boards based on TI OMAP3530. So it's better use the
> >> omap36xx.dtsi include instead of omap34xx.dtsi include.
> >> 
> >> To avoid confusion we have added to the model the (TI AM/DM37x) comment.
> > 
> > You could have omap3-igep-common.dtsi that contains most configurations
> > and then files including that where only the SoC type and name is set.
> > 
> > Regards,
> > 
> > Tony
> >  
> 
> Hi Tony,
> 
> We do have a common DTSI file for IGEP boards which is
> arch/arm/boot/dts/omap3-igep.dtsi. Maybe it should be renamed to -common to make
> it more clear?

No that's fine.
 
> Anyways, there are two models OMAP3 based IGEP boards that include this common
> DTSI: IGEPv2 (omap3-igep0020.dts) and IGEP COM Module (omap3-igep0030.dts).
> 
> However there are different revisions for each model with variations of the SoC
> version used (AM/DM37x or OMAP3530), with wifi or not wifi, flash memory
> technology (NAND or OneNAND) and different flash memory sizes.
> 
> So, we don't plan to support every single variation on mainline since this will
> unnecessary increase the complexity of DTS adding not much benefit.
> 
> We just prefer to support the latter and most popular revision for each model
> which is AM/DM37x SoC, wifi, 512 MB NAND flash.
> 
> Users that have a less popular revision can modify the reference DTS in mainline
> to reflect their board.

OK sounds fine to me and can be revisited if needed naturally.

Regards,

Tony
