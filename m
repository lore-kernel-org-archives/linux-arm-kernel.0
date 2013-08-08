From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 8 Aug 2013 13:48:52 +0200
Subject: [PATCH v2 0/6] Armada 370/XP clocksource fixes
In-Reply-To: <1375961552-12967-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375961552-12967-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130808114852.GE29815@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 08:32:26AM -0300, Ezequiel Garcia wrote:
> This small patchset fixes a somewhat minor issue found in the clocksource
> driver for Armada 370/XP SoC.
> 
> On one side the Armada 370 SoC has no 25 MHz fixed timer.
> On the other side the Armada XP SoC cannot work properly without such 25 MHz
> fixed timer selected, because otherwise the base clock frequency would vary
> when doing cpufreq frequency changes.
> 
> Therefore we can consider the SoCs as not being compatible, being better to
> have two compatible strings, one for each SoC. The previous compatible and
> its behavior has been maintained to preserve backwards compatibility.
> 
> In addition, CLOCKSOURCE_OF_DECLARE is used to simplify the initialization.
> 
> This patchset is based on v3.11-rc4. Also, to ease maintainer's task this
> is based on these two patches which are in linux-next:
> 
>   commit be14114934545f52be2ffddbe401ba0951007c59
>   Author: Stephen Boyd <sboyd@codeaurora.org>
>   "clocksource: time-armada-370-xp: Divorce from local timer API"
> 
>   commit 4047c794ae18c467a5ea987265238186bc253f61
>   Author: Stephen Boyd <sboyd@codeaurora.org>
>   "clocksource: time-armada-370-xp: Fix sparse warning"
> 
> Any testing and feedback is highly appreciated!

Hi Ezequiel

Sorry, i don't have access to hardware to test on at the moment.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

     Andrew
