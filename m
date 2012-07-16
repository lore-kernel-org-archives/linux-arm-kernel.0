From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Jul 2012 00:28:14 +0200
Subject: [PATCH 2/2] [RFC] cpufreq: omap: scale regulator from clk notifier
In-Reply-To: <1342225001-22962-3-git-send-email-mturquette@linaro.org>
References: <1342225001-22962-1-git-send-email-mturquette@linaro.org>
 <1342225001-22962-3-git-send-email-mturquette@linaro.org>
Message-ID: <CACRpkda7g2qMErwf-nebKSOW=044=YadEzEoKWM1dT=29yueeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2012 at 2:16 AM, Mike Turquette <mturquette@linaro.org> wrote:
'
> This patch moves direct control of the MPU voltage regulator out of the
> cpufreq driver .target callback and instead puts that logic into a clock
> rate change notifier callback.

That's heavy stuff.

I was hoping that the first example of using clk notifiers would be
something like mach-davinci replacing it's legacy clock framework
with drivers/clk and then go in and change the horrid cpufreq hack
that is currently in drivers/mmc/host/davinci_mmc.c to use a
clock notifier instead of cpufreq.

Sekhar/Kevin, any chance to have DaVinci converted to Mikes new
clock framework? It doesn't look super-complex and would be a
good example for others I think.

Yours,
Linus Walleij
