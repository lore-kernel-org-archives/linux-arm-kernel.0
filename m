From: olof@lixom.net (Olof Johansson)
Date: Wed, 16 Jan 2013 14:31:44 -0800
Subject: [PATCH] [RFC] ARM: compile fix for DEBUG_LL=y && MMU=n
In-Reply-To: <1358346726-27199-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1358346726-27199-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130116223144.GA9071@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 03:32:06PM +0100, Uwe Kleine-K?nig wrote:
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
> 
> which appeared in v3.8-rc1.

Since we introduced the breakage in arm-soc, I've picked up the fix (I guess
it could have gone through Russell's tree as well though).

I've added the reference to the introducing commit, and the acks/review tags.

Adding a defconfig for a !MMU platform seems like a good idea, since there's
several of us who make sure that there is build coverage of the defconfigs and
follow up on most of the breakage. Feel free to send one in for 3.9.


-Olof
