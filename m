From: rmallon@gmail.com (Ryan Mallon)
Date: Mon, 12 Sep 2011 09:15:12 +1000
Subject: [PATCH 0/7] ASoC: ep93xx: convert to use snd_soc_register_card()
In-Reply-To: <cover.1315732452.git.mika.westerberg@iki.fi>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
Message-ID: <4E6D4100.7060007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/11 19:28, Mika Westerberg wrote:

> Here is a series of patches which convert ep93xx ASoC drivers to use
> snd_soc_register_card(). This has the advantage that the machine drivers get
> loaded automatically by udev. Also this gets rid of machine_is_xxx() from the
> machine drivers.
> 
> Tested on Sim.One. The edb93xx and snappercl15 changes are compile tested
> only.


Thanks for doing this. Unfortunately I don't have any hardware to test
any more, but the code looks correct to me.

Whole series:
Reviewed-by: Ryan Mallon <rmallon@gmail.com>

> 
> Mika Westerberg (7):
>   ASoC: ep93xx-pcm: add MODULE_ALIAS
>   ASoC: simone: convert to use snd_soc_register_card()
>   ASoC: edb93xx: convert to use snd_soc_register_card()
>   ASoC: snappercl15: convert to use snd_soc_register_card()
>   ARM: ep93xx: simone: register audio platform device
>   ARM: ep93xx: edb93xx: register audio platform device
>   ARM: ep93xx: snappercl15: register audio platform device
> 
>  arch/arm/mach-ep93xx/edb93xx.c     |    6 +++
>  arch/arm/mach-ep93xx/simone.c      |   13 +++++++-
>  arch/arm/mach-ep93xx/snappercl15.c |   13 +++++++-
>  sound/soc/ep93xx/edb93xx.c         |   60 ++++++++++++++++++---------------
>  sound/soc/ep93xx/ep93xx-pcm.c      |    1 +
>  sound/soc/ep93xx/simone.c          |   64 ++++++++++++++++++++----------------
>  sound/soc/ep93xx/snappercl15.c     |   53 ++++++++++++++++++++---------
>  7 files changed, 136 insertions(+), 74 deletions(-)
> 
