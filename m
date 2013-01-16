From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Jan 2013 10:43:32 -0700
Subject: [PATCH] [RFC] ARM: compile fix for DEBUG_LL=y && MMU=n
In-Reply-To: <1358346726-27199-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1358346726-27199-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <50F6E6C4.1050409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 07:32 AM, Uwe Kleine-K?nig wrote:
> debug_ll_addr is only used on machines with an MMU so it can be #ifdef'ed
> out safely. This fixes:
> 
> arch/arm/kernel/debug.S: Assembler messages:
> arch/arm/kernel/debug.S:104: Error: too many positional arguments
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Olof Johansson <olof@lixom.net>
> ---
> The obvious alternative fix is to make addruart on !MMU take 3
> arguments, too.
> 
> The problem was introduced in
> 
> 	e5c5f2a (ARM: implement debug_ll_io_init())

It may be useful to mention that in the commit message.

Sorry for the breakage. Are there any ARM defconfigs for !MMU?

Reviewed-by: Stephen Warren <swarren@nvidia.com>

(although should the second copy of debug_ll_addr at the end of the file
be ifdef'd away too; the one for CONFIG_DEBUG_SEMIHOSTING)?
