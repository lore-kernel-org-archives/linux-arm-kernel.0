From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 14 Aug 2014 03:12:29 +0200
Subject: Building kernel for more than one SoC
In-Reply-To: <lsbi2f$pib$1@ger.gmane.org>
References: <lrdi48$ls1$1@ger.gmane.org>
 <20140804201712.GK30282@n2100.arm.linux.org.uk> <53E8E469.9050807@atmel.com>
 <lsaoih$e9$1@ger.gmane.org>
 <CAOCHtYgPoxveSjYpWWo8W+_0WwQdaCBga0piazg_Oq6aeZ=w-g@mail.gmail.com>
 <lsb9tn$nnv$1@ger.gmane.org> <20140811205909.GC30401@n2100.arm.linux.org.uk>
 <lsbbp9$j4n$1@ger.gmane.org> <20140811224328.GD30401@n2100.arm.linux.org.uk>
 <lsbi2f$pib$1@ger.gmane.org>
Message-ID: <53EC0CFD.70303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.08.2014 01:02, Grant Edwards wrote:
> On 2014-08-11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>>
>>> The problem is now you've got a kernel image that won't run on both
>>> the '9g20 and the '9g25.  The requirement is to have a kernel image
>>> that will run on either.
>>
>> It depends what you call a kernel image.
>>
>> As far as I'm concerned (and as I've been concerned from day one of uboot
>> coming into ARM), the kernel image is the zImage, not the crap that uboot
>> decides to dictate that you must provide for it to use.
>>
>> I've been pretty clear over the years that I utterly despise uboot's
>> custom format - and you're starting to find out why.  Welcome to the
>> inflexibility has caused. :)
> 
> Yea, I've got my own issues with U-Boot, but that's a whole 'nother
> thread.  In the end, it was a lot less painful to put up with U-Boot's
> issues than it was to write/port something else.
> 
>> While you have a point there, that's a choice of how you do your
>> kernel upgrades.
>>
>> If you supply a zImage, all the dtbs, a script which does the
>> programming of the kernel onto the target, and a copy of mkimage,
>> then you can do all the steps I've highlighted above on the target -
>> without the customer even having to know what platform they're on,
>> because your script can work it out.
> 
> Good point.
> 
>> There's plenty of workarounds possible for the old uboot dilemma...
> 
> Definitely.  It all comes to do trying to figure out when the
> work-arounds add up to more work than doing it the "right" way and
> upgrading everything.
> 

Is this maybe what you're looking for?

https://github.com/zonque/pxa-impedance-matcher

Best regards,
Tomasz
