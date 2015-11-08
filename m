From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 8 Nov 2015 11:36:45 -0800
Subject: [PATCH v3 1/4] dt-bindings: add SMP enable-method for Broadcom NSP
In-Reply-To: <20151108173116.GV8644@n2100.arm.linux.org.uk>
References: <1446844273-6460-1-git-send-email-kapilh@broadcom.com>
 <1446844273-6460-2-git-send-email-kapilh@broadcom.com>
 <563E6FC7.6070700@gmail.com>
 <20151108173116.GV8644@n2100.arm.linux.org.uk>
Message-ID: <CAGVrzcb_c9y6WbV0XoO7rHe6urEXUhCTtD3XieL7E6FHUnS=PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-08 9:31 GMT-08:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:

>> Is it really how the ROM code is implemented, as a pen holding/release
>> mechanism (which sounds like how this was implemented previously in the
>> kernel actually) or should this be described in a more generic way as
>> the physical address of the register where the secondary CPUs reset
>> vector address must be written to? Or something along these lines.
>
> Why do people insist on using holding pens to bring their secondary CPUs
> into existence?  I hope the hardware people aren't being dumb and have no
> way to hold in reset or power down their secondary CPUs, either of which
> is a vital feature for things like kexec and the like.  If they do have
> a way to hold secondary CPUs in reset or powered down, why aren't they
> using that at boot instead of implementing the stupid Versatile scheme,
> which exists because Versatile _can't_ hold its CPUs in reset or power
> them down...

There are few implementations out there which suffer from this same
mistake (mostly MIPS implementations) but that is not really relevant
here. Most of the time this comes from not understanding software
models and/or not properly taking into account a complex (too complex)
reset model.

>
> It's times like this that I wonder what kind of drugs the hardware SoC
> people are on, but I'm well aware that people contributing SMP bringup
> solutions are also dumb idiots who copy the Versatile scheme with very
> little thought... (as you can see, I'm not mincing my words here - if
> people want to be lazy in this regard despite this having been brought
> up multiple times, and the lead developers having said that the versatile
> pen_release stuff should not be used, they earn themselves the right to
> be called dumb idiots.  Simple solution to avoid that title: don't be a
> dumb idiot by copy the Versatile SMP bring up code!  It's not a sane
> model for any SoC sane SoC to follow.)
>
> Is this clear enough?

The actual implementation of the SMP code in the next patches do not
use a pen holding/release mechanism anymore as it used in the previous
iterations of these same patches, so I would say, lesson learned. My
question was whether the binding was documenting the hardware
implementation (which it should) or the software implementation (which
it should not).
-- 
Florian
