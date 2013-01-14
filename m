From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 14 Jan 2013 22:00:26 +0800
Subject: [PATCH] ARM: imx: disable cpu in .cpu_kill hook
In-Reply-To: <50F40E58.4030808@gmail.com>
References: <1358168977-9631-1-git-send-email-shawn.guo@linaro.org>
 <50F40E58.4030808@gmail.com>
Message-ID: <20130114140024.GE24575@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 07:55:36AM -0600, Rob Herring wrote:
> Can't you do:
> 
> set_cr(get_cr() | CR_C);
> 
Yes, this is nice.  But I'm taking Russell's suggestion to remove
the recovery piece, which is unnecessary for imx6q.

Shawn

> > +	"	mrc	p15, 0, %0, c1, c0, 1\n"
> > +	"	orr	%0, %0, %2\n"
> > +	"	mcr	p15, 0, %0, c1, c0, 1\n"
> 
> Setting or clearing the SMP bit is showing up in multiple places
> (big.LITTLE series, Tegra cpuidle). I did inline versions of
> set_auxcr/get_auxcr for highbank cpuidle. We should be make those common.
> 
