From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Sep 2012 10:42:53 -0600
Subject: linux-next: Tree for Sept 24 (irqchip)
In-Reply-To: <20120925020744.cc5beb9e65473605e5ca2240@canb.auug.org.au>
References: <20120925005328.f748dfa3d077cebb345a4291@canb.auug.org.au>
 <50607E99.6040303@xenotime.net>
 <20120925020744.cc5beb9e65473605e5ca2240@canb.auug.org.au>
Message-ID: <50608D8D.4060506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2012 10:07 AM, Stephen Rothwell wrote:
> Hi Randy,
> 
> On Mon, 24 Sep 2012 08:39:05 -0700 Randy Dunlap
> <rdunlap@xenotime.net> wrote:
>> 
>> On 09/24/2012 07:53 AM, Stephen Rothwell wrote:
>> 
>>> Today was a train wreck, with lots of new conflicts across
>>> several trees and a few build failures as well.
>> 
>> I agree.  I mostly get this:
>> 
>> drivers/Kconfig:157: can't open file "drivers/irqchip/Kconfig"
>> 
>> i.e., no such file.
>> 
>> How does this happen?  :(
>> 
>> who handles irqchip?
> 
> Hmm, commit 89214f009c1d ("ARM: bcm2835: add interrupt controller 
> driver") from the arm-soc tree adds that file as an empty file (I
> have the empty file in my tree).  Nothing adds anything to it.

That's odd. I just checked out next-20120924, and that (empty) file
does appear on my disk as expected. Do some versions of git not handle
creating empty files?

Note that IIRC the Kconfig file is required, because otherwise the
build process won't recurse into drivers/irqchip/ and hence code won't
be linked into the kernel image.

The file is empty because the Makefile there keys of
CONFIG_ARCH_BCM2835 and hence doesn't need drivers/irqchip/Kconfig to
define any new Kconfig variables.
