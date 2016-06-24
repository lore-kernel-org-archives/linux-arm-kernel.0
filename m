From: julian.calaby@gmail.com (Julian Calaby)
Date: Fri, 24 Jun 2016 12:53:19 +1000
Subject: [linux-sunxi] [PATCH 11/14] ARM: sun8i: clk: Add clk-factor rate
 application method
In-Reply-To: <20160623192104.18720-12-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-12-megous@megous.com>
Message-ID: <CAGRGNgWU88xwRRA3Q9tnKc79zq1TfJw6iTB10c3TOmmdH=L3qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ondrej,

On Fri, Jun 24, 2016 at 5:21 AM,  <megous@megous.com> wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> PLL1 on H3 requires special factors application algorithm,
> when the rate is changed. This algorithm was extracted
> from the arisc code that handles frequency scaling
> in the BSP kernel.
>
> This commit adds optional apply function to
> struct factors_data, that can implement non-trivial
> factors application method, when necessary.
>
> Also struct clk_factors_config is extended with position
> of the PLL lock flag.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi |  2 +-
>  drivers/clk/sunxi/clk-factors.c | 34 +++++++++----------
>  drivers/clk/sunxi/clk-factors.h | 12 +++++++
>  drivers/clk/sunxi/clk-sunxi.c   | 72 +++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 98 insertions(+), 22 deletions(-)

Shouldn't the .dtsi changes be in a separate patch?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
