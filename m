From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 30 Jan 2016 18:57:14 +0100
Subject: [PATCH v3 2/2] clk: sunxi: Refactor A31 PLL6 so that it can be
 reused
In-Reply-To: <1454008958-12655-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1454008958-12655-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454008958-12655-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160130185714.7abcf1de9ef8108c2f48c7fe@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jan 2016 20:22:38 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Remove the fixed dividers from the PLL6 driver to be able to have a
> reusable driver that can be used across several SoCs that share the same
> controller, but don't have the same set of dividers for this clock, and to
> also be reused multiple times in the same SoC, since we're droping the
> clock name.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> Changes from v2
>   - Rebased and converted over to the new factors refactoring. Fixed the
>     retrieved rate
> 
>  arch/arm/boot/dts/sun6i-a31.dtsi     | 36 ++++++++++++++++++------------------
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 25 +++++++++++++++++--------
>  arch/arm/boot/dts/sun8i-a23.dtsi     |  2 +-
>  arch/arm/boot/dts/sun8i-a33.dtsi     |  4 ++--
>  arch/arm/boot/dts/sun8i-h3.dtsi      | 36 ++++++++++++++++++------------------
>  drivers/clk/sunxi/clk-sunxi.c        | 32 ++++++++++++++++----------------
>  6 files changed, 72 insertions(+), 63 deletions(-)

Hi Maxime,

Do you know that the DT definitions cannot be changed when they are in
the mainline kernel?

Also, for the H3 PLL periph1 (aka PLL8), why didn't you create a
'pll8x2' clock with 'pll8' as a divider?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
