From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 May 2015 16:59:21 +0200
Subject: [PATCH RFC] ARM: use -marm unconditionally for THUMB2_KERNEL=n
 builds
In-Reply-To: <20150527095339.GQ2067@n2100.arm.linux.org.uk>
References: <1432719727-28860-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150527095339.GQ2067@n2100.arm.linux.org.uk>
Message-ID: <20150527145921.GT24769@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Wed, May 27, 2015 at 10:53:39AM +0100, Russell King - ARM Linux wrote:
> On Wed, May 27, 2015 at 11:42:07AM +0200, Uwe Kleine-K?nig wrote:
> > The only possible culprit is a compiler that doesn't understand -marm.
> > My compiler collection only goes back to 4.0.3 which does work with this
> > option. The use of cc-option to test for -marm was introduced in commit
> > 5636810d6f17 ([ARM] 3982/2: Explicitly select 32-bit ARM ISA (-marm))
> > back in 2006 when the minimal compiler version was already 3.3.
> 
> According to gcc 3.3's --target-help, it supports -mthumb, but not -marm.
> 
> What we could possibly do is to change the := to a plain =, and then
> evaluate all the options together via:
> 
> KBUILD_CFLAGS :=$(KBUILD_CFLAGS)
You mean

	KBUILD_CFLAGS += $(arch-y)

as soon as arch-y is defined to assert it's already present when -marm
is tested for, right? I will give that a try.

> after their final +=.
> 
> In any case, please don't add a after the =, I've found that certain gnu
> make flavours like to collect all that white space up into the executed
> command, which makes reading the verbose make output more annoying.  Rule
> number one of modification: stick to the established style in the file,
> even if it's wrong.  Do style modifications separately and uniformly.
ok

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
