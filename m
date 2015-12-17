From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Dec 2015 11:26:35 +0100
Subject: [PATCH v2 0/8] Raspberry Pi 2 support.
In-Reply-To: <567276F9.5070903@i2se.com>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <874mfhsyem.fsf@eliezer.anholt.net> <567276F9.5070903@i2se.com>
Message-ID: <3363412.hB2NWDcUxf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 December 2015 09:48:57 Stefan Wahren wrote:
> Am 17.12.2015 um 01:37 schrieb Eric Anholt:
> > Arnd Bergmann <arnd@arndb.de> writes:
> >
> >> On Wednesday 16 December 2015 15:55:07 Eric Anholt wrote:
> >>> This is a major rewrite of the previous Raspberry Pi 2 submission.
> >>> SMP support is now included, and the DT includes are cleaned up to
> >>> avoid massive duplication.
> >>>
> >>> The branch (based on 4.4-rc5, to get the USB regression fixes) can be
> >>> found at:
> >>>
> >>> https://github.com/anholt/linux/tree/bcm2836-4.4
> >> Looks all good to me, but when we get the pull request, I'd strongly
> >> prefer to have that based on -rc3 or earlier.
> >>
> >> What commit is the USB regression fix you refer to above? Is that in a
> >> branch that is -rc3 based? Maybe you can rebase the changes on top
> >> of that branch, to minimize the amount of backmerges?
> > Top 4 commits of drivers/usb/dwc2 for 4.4-rc5 (possibly not all of them
> > are required, but it's what I've been using).  
> >
> 
> Unfortunately all 4 of them are required:
> 
> d0464bcf12af ("usb: dwc2: Make PHY optional")
> 
> 6c2dad69163f ("usb: dwc2: Return errors from PHY")
> 
> 8aa90cf2a286 ("usb: dwc2: make otg clk optional")
> 
> f74875dc3613 ("usb: dwc2: fix kernel oops during driver probe")

Ok, that's good. They are all based on -rc1, so you you can just rebase
on top of f74875dc3613, which was pulled by GregKH.

> But they should apply to -rc3 too.

Please don't rebase them, use the commits that got merged, otherwise we'd
get duplicate commits and that would be worse than the backmerge.

	Arnd
