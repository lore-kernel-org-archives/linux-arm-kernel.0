From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Jan 2013 09:12:33 +0100
Subject: [PATCH] [RFC] ARM: compile fix for DEBUG_LL=y && MMU=n
In-Reply-To: <50F6FCC0.6040204@gmail.com>
References: <1358346726-27199-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <50F6FCC0.6040204@gmail.com>
Message-ID: <20130117081233.GC8668@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 01:17:20PM -0600, Rob Herring wrote:
> On 01/16/2013 08:32 AM, Uwe Kleine-K?nig wrote:
> > debug_ll_addr is only used on machines with an MMU so it can be #ifdef'ed
> > out safely. This fixes:
> > 
> > arch/arm/kernel/debug.S: Assembler messages:
> > arch/arm/kernel/debug.S:104: Error: too many positional arguments
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Stephen Warren <swarren@nvidia.com>
> > Cc: Olof Johansson <olof@lixom.net>
> > ---
> > The obvious alternative fix is to make addruart on !MMU take 3
> > arguments, too.
> 
> We never envision a need to get the uart address from C code on !MMU?
On MMU addruart takes 3 arguments: physical address output, virtual
address output and a tmp. On !MMU physical == virtual, so only one
register for the address is needed.

(BTW, it was commit 639da5e (ARM: add an extra temp register to the low
level debugging addruart macro) that only changed the MMU variants of
addruart.)
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
