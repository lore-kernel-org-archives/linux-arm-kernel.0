From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 2 Feb 2010 01:50:38 +0800
Subject: [PATCH] [ARM] pxa: match camera clock by struct device
In-Reply-To: <1264931178-29177-1-git-send-email-mike@compulab.co.il>
References: <1264931178-29177-1-git-send-email-mike@compulab.co.il>
Message-ID: <f17812d71002010950v2bff262j43700d2be04da3e3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2010 at 5:46 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
> ?arch/arm/mach-pxa/pxa3xx.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
> index fcb0721..9d338a7 100644
> --- a/arch/arm/mach-pxa/pxa3xx.c
> +++ b/arch/arm/mach-pxa/pxa3xx.c
> @@ -257,7 +257,7 @@ static struct clk_lookup pxa3xx_clkregs[] = {
> ? ? ? ?/* Power I2C clock is always on */
> ? ? ? ?INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
> ? ? ? ?INIT_CLKREG(&clk_pxa3xx_lcd, "pxa2xx-fb", NULL),
> - ? ? ? INIT_CLKREG(&clk_pxa3xx_camera, NULL, "CAMCLK"),
> + ? ? ? INIT_CLKREG(&clk_pxa3xx_camera, "pxa27x-camera.0", NULL),

Interesting, but not keeping an eye on pxa27x camera driver for a while,
does that support pxa3xx as well? I seem to remember the DMA logic
is a bit different, making it quite difficult to support both in a
single driver.

And the hardware in pxa320 differs from the one in pxa310 as well.

> ? ? ? ?INIT_CLKREG(&clk_pxa3xx_ac97, NULL, "AC97CLK"),
> ? ? ? ?INIT_CLKREG(&clk_pxa3xx_ffuart, "pxa2xx-uart.0", NULL),
> ? ? ? ?INIT_CLKREG(&clk_pxa3xx_btuart, "pxa2xx-uart.1", NULL),
> --
> 1.6.4.4
>
>
