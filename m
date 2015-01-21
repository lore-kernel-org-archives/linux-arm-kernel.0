From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Jan 2015 15:19:31 -0800
Subject: [GIT PULL] at91: cleanup for 3.20 #2
In-Reply-To: <1421429141-5405-1-git-send-email-nicolas.ferre@atmel.com>
References: <1421429141-5405-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150121231931.GA29014@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 06:25:41PM +0100, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is another cleanup pull-request for AT91. This one depends on the Device
> Tree material that I posted yesterday, so I merged the at91-dt tag just before
> stacking up Alexandre's patches. This dependency is needed to make sure that
> SRAM gets initialized before using it.
> More cleanup will come soon to reach multi-platform.
> 
> Thanks, best regards,
> 
> The following changes since commit eca6f17253f33313eeb3020d0634a60d10f650c4:
> 
>   Merge tag 'at91-dt' into at91-3.20-cleanup (2015-01-16 17:18:34 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup2
> 
> for you to fetch changes up to 29ee506d0d56f6d39cc237de2512f9cb5629cbf7:
> 
>   ARM: at91: move at91rm9200_idle() to clk/at91/pmc.c (2015-01-16 18:08:42 +0100)
> 
> ----------------------------------------------------------------
> Second batch of cleanup for 3.20:
> - By reworking the PM code, we can remove the AT91 more specific initialization
> - We are using DT for SRAM initialization now, so we can remove its explicit
>   mapping
> - The PMC clock driver now hosts IDLE function for at91rm9200 with other
>   SoCs ones.

This adds a really annoying circular dependency for us. Cleanups are supposed
to be the base for other branches, not the other way around.

To break the cycle, I've merged this into next/soc instead of into cleanup. We
now have a dependency on soc coming after dt, which is also not what we usually
do, but it least it's better than putting the dt branch in front of cleanup.


-Olof
