From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Aug 2013 20:54:10 +0200
Subject: [RFC 02/17] ARM: call clk_of_init from time_init
In-Reply-To: <5213CF58.50703@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <5213C90F.9010407@wwwdotorg.org> <5213CF58.50703@gmail.com>
Message-ID: <201308212054.10417.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 August 2013, Sebastian Hesselbarth wrote:
> Perhaps Tegra is the common case but other SoC haven't dug deep enough?
> IMHO from a HW point-of-view clocks are really among the essential
> things that need to be running before you can do anything useful.
> 
> Just consider boot loaders that run fine without irqs but don't without
> clocks (even if just represented by API). Maybe you are right, and we
> should call of_clk_init(NULL) as early as possible. That would also
> eliminate patch 1/17 as you suggest.

Timers and interrupts are also things that are required really early,
and from my experience they tend to be needed earlier than clock
management. Obviously you need some clocks to be enabled in order
to do anything (including interrupt handling), but those clocks tend
to be enabled in the boot loader, so we don't have to worry about
reprogramming them this early.

	Arnd
