From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 16 Jan 2013 20:26:48 +0100
Subject: [PATCH] [RFC] ARM: compile fix for DEBUG_LL=y && MMU=n
In-Reply-To: <50F6E6C4.1050409@wwwdotorg.org>
References: <1358346726-27199-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <50F6E6C4.1050409@wwwdotorg.org>
Message-ID: <20130116192648.GZ14860@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 10:43:32AM -0700, Stephen Warren wrote:
> On 01/16/2013 07:32 AM, Uwe Kleine-K?nig wrote:
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
> > 
> > The problem was introduced in
> > 
> > 	e5c5f2a (ARM: implement debug_ll_io_init())
> 
> It may be useful to mention that in the commit message.
right.

> Sorry for the breakage. Are there any ARM defconfigs for !MMU?
I'm not aware of anything in mainline.
 
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
thanks

> (although should the second copy of debug_ll_addr at the end of the file
> be ifdef'd away too; the one for CONFIG_DEBUG_SEMIHOSTING)?
In contrast to the !CONFIG_DEBUG_SEMIHOSTING implementation this one
doesn't call addruart and should compile just fine. I don't care much.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
