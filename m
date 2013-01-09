From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Jan 2013 17:43:32 +0000
Subject: [PATCH 05/10] ARM: OMAP2+: PM/powerdomain: move
 omap_set_pwrdm_state() to powerdomain code
In-Reply-To: <50C85ABD.8040409@ti.com>
References: <20121209011755.19716.25244.stgit@dusk.lan>
 <20121209012339.19716.10548.stgit@dusk.lan> <50C85ABD.8040409@ti.com>
Message-ID: <20130109174332.GC2637@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 03:51:49PM +0530, Vaibhav Hiremath wrote:
> > -int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
> > -{
> > -	u8 curr_pwrst, next_pwrst;
> > -	int sleep_switch = -1, ret = 0, hwsup = 0;
> > -
> > -	if (!pwrdm || IS_ERR(pwrdm))
> 
> You can use IS_ERR_OR_NULL here.

As this is removing code...

However, if you pay attention to linux-kernel or linux-arm-kernel, you will
notice that I've sent a patch deprecating IS_ERR_OR_NULL() and I'm starting
to remove its use.  IS_ERR_OR_NULL() creates more problems than it solves
because people don't think about what the hell they're doing with it, or
even whether it's appropriate to use it.
