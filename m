From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 25 Jun 2014 18:29:17 +0200
Subject: [GIT PULL] at91: fixes for 3.16 #1 (bis)
In-Reply-To: <1403699980-20797-1-git-send-email-nicolas.ferre@atmel.com>
References: <1403699980-20797-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <53AAF8DD.1050704@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/06/2014 14:39, Nicolas Ferre :
> Arnd, Olof, Kevin,
> 
> An AT91 fixes batch for 3.16 that collects mainly DT modifications in relation
> to the recent move to CCF on a couple of platforms.
> The recent modifications also lead us to add tiny DT corrections that enable
> available features like sound or DMA use for 9rl NAND.
> 
> As the previous "fixes" pull-request will be re-spin for 3.17 and shall be
> ignored, I use the same tag name "at91-fixes".
> 
> Thanks, best regards,
> 
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-fixes
> 
> for you to fetch changes up to fe6076a70dd7b50598a6b5ad7dad03f9322ecec9:
> 
>   ARM: at91/dt: sama5d3 crystals under the clocks node (2014-06-25 13:50:47 +0200)
> 
> ----------------------------------------------------------------
> First AT91 fixes batch for 3.16:
> - drivers/misc fix for Kconfig PWM symbol
> - addition of DMA and DMA + nand on at91sam9rl
> - correction of several values in DT after conversion to CCF
> - addition of clock entries for sound for CCF enabled platforms
> - little defconfig update for sound in relation with previous item
> - move of crystals DT definitions to the /clocks node

Some material is targeted for 3.17. I'll re-spin this for inclusion in
next kernel release.

So, ignore again this pull-request: I've just sent the "ter" ;-)

Sorry for the noise, bye,


> ----------------------------------------------------------------
> Alexandre Belloni (9):
>       ARM: at91/dt: sam9x5: correct PLLA ICPLL and OUT values
>       ARM: at91/dt: sam9n12: correct PLLA ICPLL and OUT values
>       ARM: at91/dt: sam9261: correctly define mainck
>       ARM: at91/dt: define sam9261ek slow crystal frequency
>       ARM: at91/dt: sam9261 crystals under the clocks node
>       ARM: at91/dt: sam9n12 crystals under the clocks node
>       ARM: at91/dt: sam9rl crystals under the clocks node
>       ARM: at91/dt: sam9x5 crystals under the clocks node
>       ARM: at91/dt: sama5d3 crystals under the clocks node
> 
> Bo Shen (4):
>       ARM: at91: sama5d3xek: switch sound to CCF
>       ARM: at91: at91sam9n12ek: switch sound to CCF
>       ARM: at91/at91_dt_defconfig: enable sound support
>       ARM: at91/sama5_defconfig: enable sound support
> 
> Nicolas Ferre (3):
>       misc: atmel_pwm: fix Kconfig symbols
>       ARM: at91/dt: add DMA controller node to at91sam9rl
>       ARM: at91/dt: add NAND + DMA property for at91sam9rl
> 
>  arch/arm/boot/dts/at91-sama5d3_xplained.dts | 12 +++++-----
>  arch/arm/boot/dts/at91sam9261.dtsi          | 30 +++++++++++++++----------
>  arch/arm/boot/dts/at91sam9261ek.dts         | 12 ++++++----
>  arch/arm/boot/dts/at91sam9n12.dtsi          | 24 ++++++++++----------
>  arch/arm/boot/dts/at91sam9n12ek.dts         | 18 ++++++++-------
>  arch/arm/boot/dts/at91sam9rl.dtsi           | 32 +++++++++++++++++----------
>  arch/arm/boot/dts/at91sam9rlek.dts          | 17 +++++++--------
>  arch/arm/boot/dts/at91sam9x5.dtsi           | 34 +++++++++++++++--------------
>  arch/arm/boot/dts/at91sam9x5cm.dtsi         | 12 +++++-----
>  arch/arm/boot/dts/sama5d3.dtsi              | 22 +++++++++----------
>  arch/arm/boot/dts/sama5d3xcm.dtsi           | 12 +++++-----
>  arch/arm/boot/dts/sama5d3xmb.dtsi           |  2 ++
>  arch/arm/configs/at91_dt_defconfig          | 10 +++++++++
>  arch/arm/configs/sama5_defconfig            |  5 +++++
>  drivers/misc/Kconfig                        |  2 +-
>  15 files changed, 147 insertions(+), 97 deletions(-)
> 


-- 
Nicolas Ferre
