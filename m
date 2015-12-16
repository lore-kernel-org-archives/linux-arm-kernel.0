From: sre@ring0.de (Sebastian Reichel)
Date: Wed, 16 Dec 2015 02:11:11 +0100
Subject: [PATCH v3 2/4] ARM: bcm2835: add rpi power domain driver
In-Reply-To: <87mvtbkyd0.fsf@eliezer.anholt.net>
References: <1450215622-27394-1-git-send-email-eric@anholt.net>
 <1450215622-27394-3-git-send-email-eric@anholt.net>
 <567093CD.1020208@gmail.com> <87oadrmfmi.fsf@eliezer.anholt.net>
 <5670AAB2.1080102@gmail.com> <87mvtbkyd0.fsf@eliezer.anholt.net>
Message-ID: <20151216011110.GA13147@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 15, 2015 at 04:53:31PM -0800, Eric Anholt wrote:
> >>> What motivated the location of this power domain driver in
> >>> arch/arm/mach-bcm? Should not we have this in drivers/power/ or
> >>> somewhere in drivers/ at the very least?
> >> 
> >> ls stronly suggests that power contains drivers for power supplies and
> >> batteries, not power domains.

Indeed it's used for fuel gauges and chargers, but also for
reboot/powerdown and adaptive voltage scaling, so another
subdirectory for power-domains wouldn't be that odd.

> >> There are 6 power domain drivers in
> >> arch/arm, 3 in drivers/clk, and 3 in drivers/soc.
> >
> > If we ever have to support a different architecture which happens to use
> > a similar power domain, then we want it to be in a location which makes
> > it easy for sharing it in the first place. As it stands today, it does
> > not seem useful to me to have this code in arch/arm/mach-bcm/ at all.
> >
> > Maybe there is room from a drivers/power/domains/ of some kind?

I like the idea, but let's include generic power domain maintainers
in this discussion, as I suggested here (I got a power domain driver
patch for drivers/power just a few days ago):

https://lkml.org/lkml/2015/12/15/815

Also somebody would have to step up to maintain that directory.

> The great thing about git is that moving code is easy, even after it's
> first committed.
>
> The subsystem maintainer didn't comment on the code's location in v1 or
> v2, and I think they probably have the final say on that.  Whatever they
> want, where there is currently a genpd driver, is fine with me.

sounds reasonable.

P.S.: Thanks for taking bringing RPI support upstream :)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151216/987f00f3/attachment.sig>
