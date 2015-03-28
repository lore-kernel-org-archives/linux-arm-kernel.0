From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 28 Mar 2015 09:29:59 +0100
Subject: [PATCH v4 2/4] mfd: lubbock_cplds: add lubbock IO board
In-Reply-To: <201503280335.16280.arnd@arndb.de> (Arnd Bergmann's message of
 "Sat, 28 Mar 2015 03:35:15 +0100")
References: <20150216130549.GF14545@x1> <20150325140725.GA11499@kroah.com>
 <871tkbxwup.fsf@free.fr> <201503280335.16280.arnd@arndb.de>
Message-ID: <87fv8pwmm0.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 26 March 2015, Robert Jarzmik wrote:
>> 
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> > On Fri, Feb 20, 2015 at 05:02:57PM +0100, Robert Jarzmik wrote:
>> >> If there is no solution, I'll fallback through arch/arm/plat-pxa, not very nice,
>> >> but it has to land somewhere, I don't want lubbock to remain broken.
>> >
>> > drivers/platform/arm ?
>> Most certainly.
>> 
>> I'll submit that to drivers/platform/arm/pxa, and maintain that pxa tree. As for
>> drivers/platform/arm, do you want also maintainers to step up, or will you take
>> the review/merge burden ?
>> 
>
> I'd much prefer not to add drivers/platform/arm, which would make it too easy
> to add random stuff there. What is the problem with leaving it in mach-pxa?
Hi Arnd,

It's not as much a problem as a generic question : does a driver belong to
arch/* ?

Personaly it would have been far simpler for me to have it through the pxa tree,
but I want to be sure it's the right place. Others will follow, pxa mainstone is
such a candidate.

I was thinking so far that arch/arm/mach-* was for machine description,
ie. wirings, interconnections, initial setup etc ... The "driver" part, ie. code
really driving dynamics in IPs was as per my understanding in drivers/...

Now I can create arch/arm/mach-pxa/lubbock_cplds.c, that won't make any
difference to me, provided that it's the right thing to do.

Cheers.

-- 
Robert
