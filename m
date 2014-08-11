From: grant.b.edwards@gmail.com (Grant Edwards)
Date: Mon, 11 Aug 2014 23:02:40 +0000 (UTC)
Subject: Building kernel for more than one SoC
References: <lrdi48$ls1$1@ger.gmane.org>
 <20140804201712.GK30282@n2100.arm.linux.org.uk>
 <53E8E469.9050807@atmel.com> <lsaoih$e9$1@ger.gmane.org>
 <CAOCHtYgPoxveSjYpWWo8W+_0WwQdaCBga0piazg_Oq6aeZ=w-g@mail.gmail.com>
 <lsb9tn$nnv$1@ger.gmane.org>
 <20140811205909.GC30401@n2100.arm.linux.org.uk>
 <lsbbp9$j4n$1@ger.gmane.org>
 <20140811224328.GD30401@n2100.arm.linux.org.uk>
Message-ID: <lsbi2f$pib$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-08-11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>
>> The problem is now you've got a kernel image that won't run on both
>> the '9g20 and the '9g25.  The requirement is to have a kernel image
>> that will run on either.
>
> It depends what you call a kernel image.
>
> As far as I'm concerned (and as I've been concerned from day one of uboot
> coming into ARM), the kernel image is the zImage, not the crap that uboot
> decides to dictate that you must provide for it to use.
>
> I've been pretty clear over the years that I utterly despise uboot's
> custom format - and you're starting to find out why.  Welcome to the
> inflexibility has caused. :)

Yea, I've got my own issues with U-Boot, but that's a whole 'nother
thread.  In the end, it was a lot less painful to put up with U-Boot's
issues than it was to write/port something else.

> While you have a point there, that's a choice of how you do your
> kernel upgrades.
>
> If you supply a zImage, all the dtbs, a script which does the
> programming of the kernel onto the target, and a copy of mkimage,
> then you can do all the steps I've highlighted above on the target -
> without the customer even having to know what platform they're on,
> because your script can work it out.

Good point.

> There's plenty of workarounds possible for the old uboot dilemma...

Definitely.  It all comes to do trying to figure out when the
work-arounds add up to more work than doing it the "right" way and
upgrading everything.

-- 
Grant Edwards               grant.b.edwards        Yow! All of life is a blur
                                  at               of Republicans and meat!
                              gmail.com            
