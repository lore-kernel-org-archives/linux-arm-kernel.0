From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Aug 2011 22:54:02 +0200
Subject: [RFC PATCH] ARM: sched_clock: allow sched_clock to be selected at
	runtime
In-Reply-To: <1312910015-20043-1-git-send-email-marc.zyngier@arm.com>
References: <1312910015-20043-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CACRpkdYfr_Rbzc1Xa3mSk41dYVZBGH+E_Pj9NfnSuSOsHcjmYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2011 at 7:13 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> sched_clock() is yet another blocker on the road to the single
> image. This patch implements an idea by Russell King:
>
> http://www.spinics.net/lists/linux-omap/msg49561.html
>
> Instead of asking the platform to implement both sched_clock()
> itself and the rollover callback, simply register a read()
> function, and let the ARM code care about sched_clock() itself,
> the conversion to ns and the rollover. sched_clock() uses
> this read() function as an indirection to the platform code.
>
> This allow some simplifications and possibly some footprint gain
> when multiple platforms are compiled in. Among the drawbacks,
> the removal of the *_fixed_sched_clock optimization which could
> negatively impact some platforms (sa1100, tegra, versatile
> and omap).
>
> Tested on 11MPCore, OMAP4 and Tegra.
>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Erik Gilling <konkers@android.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

For Nomadik, U300.

Thanks!
Linus Walleij
