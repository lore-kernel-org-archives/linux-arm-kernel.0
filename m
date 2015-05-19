From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 20:24:04 +0200
Subject: [PATCH v7 08/13] ARM: unify MMU/!MMU addruart calls
In-Reply-To: <b41ebeb9d62b9c49faec6500f73460b9@agner.ch>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
 <2419398.cbLWQC7K5f@wuerfel> <b41ebeb9d62b9c49faec6500f73460b9@agner.ch>
Message-ID: <5548280.7uBnLuun8k@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 18:06:53 Stefan Agner wrote:
> On 2015-05-19 13:50, Arnd Bergmann wrote:
> > On Tuesday 19 May 2015 13:23:22 Stefan Agner wrote:
> >> On 2015-05-19 12:16, Russell King - ARM Linux wrote:
> <snip>
> >> Not sure how we can deal with the EFM32 vs. IMX changes... Patches 08-10
> >> has no dependencies on the clock changes which Thomas merged. They could
> >> go through whatever EFM32 is merged normally (last time Arnd directly
> >> merged from Uwe), and then Shawn could base the rest of the changes on
> >> that too?
> > 
> > Do you have a dependency on patch 10 (the one for EFM32) in your later
> > patches?
> 
> Unfortunately, there is a dependency on that patch: I change the default
> of UNCOMPRESS_INCLUDE to debug/uncompress.h for all ARM_SINGLE_ARMV7M
> platforms. Without that patch, it would default to mach/uncompress.h,
> which does not exist for MACH_MXC/SOC_VF610.

An easy approach would be to list both ARM_SINGLE_ARMV7M and
EFM32 in the UNCOMPRESS_INCLUDE option initially, and then
follow-up with a patch that converts the three other platforms
(efm32, stm32 and lpc18xx) to ARM_SINGLE_ARMV7M and also
change the UNCOMPRESS_INCLUDE statement.

Note that I've already added both stm32 and lpc18xx to the
UNCOMPRESS_INCLUDE list in the next/soc branch.

> > If not, you can send the other ones to Shawn, so I pull them as
> > a branch, and then I apply that on top of the merges. I have also
> > merged two other ARMv7M platforms for 4.2 now (both in next/soc),
> > so we should do the same change for those as well, and I'd rather
> > apply a patch for that, than merge a branch that is based on
> > next/soc.
> 
> I guess, in that case, you need to take the others too? (08/09?)

I'm fine with that, too. If Shawn thinks the patches are ok, you can
just send all patches you want me to apply in arm-soc based on
the appropriate branches (next/soc, next/dt and next/defconfig, I
presume), and I'll apply them this time. In the future, you should
send all patches to Shawn though.

	Arnd
