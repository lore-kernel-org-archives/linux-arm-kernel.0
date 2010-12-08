From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Dec 2010 18:00:19 -0800
Subject: [PATCH 3/4] omap1: Add omap1_defconfig
In-Reply-To: <AANLkTi=siEk_ZLY0k94ktv_sUAF5AO3PTkT-4ynDqLX7@mail.gmail.com>
References: <20101204213358.32208.4195.stgit@baageli.muru.com>
	<20101204213657.32208.50997.stgit@baageli.muru.com>
	<AANLkTi=siEk_ZLY0k94ktv_sUAF5AO3PTkT-4ynDqLX7@mail.gmail.com>
Message-ID: <20101208020019.GO17435@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Contreras <felipe.contreras@gmail.com> [101207 04:28]:
> On Sat, Dec 4, 2010 at 11:36 PM, Tony Lindgren <tony@atomide.com> wrote:
> > The omap1_defconfig this should be eventually usable for booting
> > all omap1 machines. Generated based on:
> >
> > $ grep ARCH_OMAP1=y arch/arm/configs/* | cut -d: -f1 | xargs cat | \
> > ? ? sort | uniq >> arch/arm/configs/omap1_defconfig
> >
> > Then change few things manually, like use Nokia 770 CONFIG_CMDLINE
> > as it does not allow setting it in the bootloader.
> >
> > After make oldconfig, ran reduce_defconfig python script on it
> > as posted by Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> 
> AFAIK you should use 'make savedefconfig'.

OK cool thanks for the tip. Updating the description for that
and also will take out CONFIG_DEBUG_DRIVER=y as it's too noisy.

Regards,

Tony
