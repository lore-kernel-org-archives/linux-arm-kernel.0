From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 18:22:53 +0000
Subject: [PATCH 6/6] clocksource: update and move armada-370-xp-timer
 documentation to timer directory
In-Reply-To: <1358790842-2986-7-git-send-email-gregory.clement@free-electrons.com>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <1358790842-2986-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201301211822.54129.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Gregory CLEMENT wrote:
> +
> +Required properties:
> +- compatible: Should be "marvell,armada-370-xp-timer"
> +- interrupts: Should contain the list of Global Timer interrupts and
> +  then local timer interrupts
> +- reg: Should contain location and length for timers register. First
> +  pair for the Global Timer registers, second pair for the
> +  local/private timers.
> +- clocks: clock driving the timer hardware
> +
> +Optional properties:
> +- marvell,timer-25Mhz: Tells whether the Global timer supports the 25
> +  Mhz fixed mode (available on Armada XP and not on Armada 370)

This works fine, but I would consider it slightly cleaner to kill
the marvell,timer-25Mhz property and instead have separate 
marvell,armada-370-timer and marvell,armada-xp-timer compatible
strings, since the two timers are actually different, rather than wired
differently.

	Arnd
