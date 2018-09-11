From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Sep 2018 11:41:50 -0700
Subject: [PATCH] gpio: omap: Add level wakeup handling for omap4 based SoCs
In-Reply-To: <20180910200624.4494-1-tony@atomide.com>
References: <20180910200624.4494-1-tony@atomide.com>
Message-ID: <20180911184150.GD5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [180910 20:10]:
> I noticed that unlike omap2 and 3 based SoCs, omap4 based SoCs keep
> the GPIO clocks enabled for GPIO level interrupts with wakeup enabled.
> This blocks deeper idle states as the whole domain will stay busy.

Linus, assuming people are OK with this one, I'd appreciate an
immutable branch against v4.19-rc1 for this and a follow-up patch
"[PATCH] gpio: omap: Remove custom PM calls and use cpu_pm instead".

That's because of the arch/arm/mach-omap2 dependency that might
conflict for v4.20 (although unlikely).

Regards,

Tony
