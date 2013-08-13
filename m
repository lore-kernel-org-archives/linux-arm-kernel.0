From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 13 Aug 2013 11:05:10 -0300
Subject: [PATCH v3 0/6] Armada 370/XP clocksource fixes
In-Reply-To: <520A2679.1040307@linaro.org>
References: <1376335016-16400-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <520A2679.1040307@linaro.org>
Message-ID: <20130813140509.GA2359@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 02:28:41PM +0200, Daniel Lezcano wrote:
> On 08/12/2013 09:16 PM, Ezequiel Garcia wrote:
> > This small patchset fixes a somewhat minor issue found in the clocksource
> > driver for Armada 370/XP SoC.
> > 
> > On one side the Armada 370 SoC has no 25 MHz fixed timer.
> > On the other side the Armada XP SoC cannot work properly without such 25 MHz
> > fixed timer selected, because otherwise the base clock frequency would vary
> > when doing cpufreq frequency changes.
> > 
> > Therefore we can consider the SoCs as not being compatible, being better to
> > have two compatible strings, one for each SoC. The previous compatible and
> > its behavior has been removed, considering there are no DT-enabled boards
> > in use in the field.
> > 
> > In addition, CLOCKSOURCE_OF_DECLARE is used to simplify the initialization.
> > 
> > This patchset is based on v3.11-rc4. Also, to ease maintainer's task this
> > is based on these two patches which are in linux-next:
> > 
> >   commit be14114934545f52be2ffddbe401ba0951007c59
> >   Author: Stephen Boyd <sboyd@codeaurora.org>
> >   "clocksource: time-armada-370-xp: Divorce from local timer API"
> > 
> >   commit 4047c794ae18c467a5ea987265238186bc253f61
> >   Author: Stephen Boyd <sboyd@codeaurora.org>
> >   "clocksource: time-armada-370-xp: Fix sparse warning"
> 
> Your patchset does not apply to my tree for timers/core
> 
> These two patches described above are in the ARM tree, not available in
> the timers/core tree.
> 
> The correct submission path for these would have been through timers/urgent:
> 
> timers/urgent -> v3.11-rcX -> arm-soc
>                            -> timers/core
> 
> Or alternatively if it depends on material in arm-soc, a pull request
> based in a v3.11-rcX where Olof and I can pull from.
> 
> I guess you have to rebase your patchset on top of timers/core.
> 

Sure. I'll just send this patchset on top of timers/core.

I guess it was just a silly thing to base this on top of those
two patches.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
