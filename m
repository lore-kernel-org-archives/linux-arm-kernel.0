From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Apr 2011 13:46:28 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <BANLkTineKF3Yw+o_PNaq=6btm2MU7TBB+g@mail.gmail.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<BANLkTi=kGxL9N-RNqxmeqs4zeYo0zzfmhQ@mail.gmail.com>
	<BANLkTinxThB+2+fv4qUD5dyguV-5hUva3A@mail.gmail.com>
	<201104211025.34420.arnd@arndb.de>
	<BANLkTineKF3Yw+o_PNaq=6btm2MU7TBB+g@mail.gmail.com>
Message-ID: <BANLkTimMpJAchM4NgOGYeTW7S7E03GQHaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/22 Linus Walleij <linus.walleij@linaro.org>:

> The big deviating thing is the clock tree, which also use calls to
> the PRCMU. I would argue that the problem is rather that clocks
> are not modeled as devices rather than that the PRCMU would
> be modeled as an MFD device.

Which sort of begets the question of whether Russell is OK with
pushing clock tree implementations to drivers/clk/*...

I'll be perfectly happy doing that too, so if I:

- Put the PRCMU driver in drivers/mfd/prcmu-db8500.c
- Put the cpufreq driver in drivers/cpufreq/cpufreq-db8500.c
- Put the clock tree in drivers/clk/clock-db8500.c

My diffstat (which was 50% of the ARM +++ in the next tree)
will most certainly instead go to NEGATIVE in arch/arm/* and
be an appetizing pull target.

Needless to say it'll require some ACK:ing. I have mixed feelings
about this but it does depopulate the ARM tree.

Yours,
Linus Walleij
