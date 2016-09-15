From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 15 Sep 2016 15:01:49 +0200
Subject: [GIT PULL] STi DT update for v4.9
In-Reply-To: <ede2d2b6-7e0c-f31e-72bd-06aae5838327@st.com>
References: <ede2d2b6-7e0c-f31e-72bd-06aae5838327@st.com>
Message-ID: <499175b9-d743-1f2c-be62-236ec5f3577e@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/14/2016 03:15 PM, Patrice Chotard wrote:
> Hi Arnd, Kevin, Olof
> 
> PLease consider this next batch for v4.9
> 
> The following changes since commit ba5ba11906d5462993f5fd4e3da4d234505427a0:
> 
>   ARM: dts: STiH41x-b2020: Update gpio specifier (2016-09-02 15:15:14 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-dt-for-v4.9-2
> 
> for you to fetch changes up to 443fd7c92f5a000796b02683157d17b2575450e1:
> 
>   ARM: DT: STi: stihxxx-b2120: Add DT nodes for STi audio card (2016-09-14 13:37:29 +0200)
> 
> ----------------------------------------------------------------
> STi dts update:
> 
> Update gpio-cells and gpio specifier for STiH415/416
> Add PWM capture support for STiH416 and STiH407 family
> Add USB3 support for B2260
> Add HVA support for STiH410
> Add clk_ignore_unused in bootargs of B2260
> Add Flexible Direct Memory Access (FDMA) support for STiH407 family
> Add internal audio codec IP spport for STiH407 family
> Add uniperif player/reader IP blocks for STiH407 family
> 
> ----------------------------------------------------------------
> Jean-Christophe Trotin (1):
>       ARM: dts: STiH410: Add hva dt nodes
> 
> Lee Jones (6):
>       ARM: dts: STiH407: Supply PWM Capture IRQ
>       ARM: dts: STiH407: Declare PWM Capture data lines via Pinctrl
>       ARM: dts: STiH416: Supply PWM Capture IRQs
>       ARM: dts: STiH416: Declare PWM Capture data lines via Pinctrl
>       ARM: dts: STiH416: Define PWM Capture clock
>       ARM: dts: STiH416: Define the number of PWM Capture channels
> 
> Patrice Chotard (7):
>       ARM: dts: STiH415-pinctrl: update gpio-cells to 2
>       ARM: dts: STiH416-pinctrl: update gpio-cells to 2
>       ARM: dts: STiHxxx-b2120: update gpio specifier
>       ARM: dts: STiH41x-b2000: update gpio specifier
>       ARM: dts: STiH416-b2020e: update gpio specifier
>       ARM: dts: STiH410-b2260: add USB3 node
>       ARM: dts: STiH410-b2260: add clk_ignore_unused in bootargs
> 
> Peter Griffin (8):
>       ARM: STi: DT: STiH407: Add FDMA driver dt nodes.
>       ARM: DT: STiH407: Add i2s_out pinctrl configuration
>       ARM: DT: STiH407: Add i2s_in pinctrl configuration
>       ARM: DT: STiH407: Add spdif_out pinctrl config
>       ARM: STi: DT: STiH407: Add sti-sasg-codec dt node
>       ARM: STi: DT: STiH407: Add uniperif player dt nodes
>       ARM: STi: DT: STiH407: Add uniperif reader dt nodes
>       ARM: DT: STi: stihxxx-b2120: Add DT nodes for STi audio card
> 
>  arch/arm/boot/dts/stih407-family.dtsi  | 168 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/stih407-pinctrl.dtsi |  58 ++++++++++++
>  arch/arm/boot/dts/stih410-b2260.dts    |   6 +-
>  arch/arm/boot/dts/stih410.dtsi         |  10 ++
>  arch/arm/boot/dts/stih415-pinctrl.dtsi |  54 +++++------
>  arch/arm/boot/dts/stih416-b2020e.dts   |   6 +-
>  arch/arm/boot/dts/stih416-pinctrl.dtsi |  65 +++++++------
>  arch/arm/boot/dts/stih416.dtsi         |   8 +-
>  arch/arm/boot/dts/stih41x-b2000.dtsi   |   5 +-
>  arch/arm/boot/dts/stihxxx-b2120.dtsi   |  51 +++++++++-
>  10 files changed, 362 insertions(+), 69 deletions(-)
> 

Hi Arnd

1) As you indicated on IRC, this pull request has been send after the 
11th September, it must be applied as well on arm-soc/for-next.

2) This morning we just had confirmation from Stephen Boyd that a 
STi clocks series will be applied as well. This series was submitted 
since a while for v4.8 but unfortunately, clock maintainers forgot to 
merge it and we missed v4.8 merge window.

It's important for us to get it in v4.9 which will support the 
new ST's 96Board. 
Will you accept the STi DT counterpart of this clocks series ? 
If yes, i have a STi clocks DT pull request to send (already ready, 
just to push the button ;-) )

Thanks

Patrice
