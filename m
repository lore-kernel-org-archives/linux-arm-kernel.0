From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 24 Jun 2012 03:28:09 -0300
Subject: [PATCH] ARM: mx28: Add LCD pinmux
In-Reply-To: <1340477119-2835-1-git-send-email-marex@denx.de>
References: <1340477119-2835-1-git-send-email-marex@denx.de>
Message-ID: <CAOMZO5Dr4JK1gF6pPD80XbRDJ79V-2mkUHaLv-ZdrxKrqmTn8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Sat, Jun 23, 2012 at 3:45 PM, Marek Vasut <marex@denx.de> wrote:
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Detlev Zundel <dzu@denx.de>
> CC: Dong Aisheng <b29396@freescale.com>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> CC: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
> ?arch/arm/boot/dts/imx28.dtsi | ? 45 ++++++++++++++++++++++++++++++++++++++++++
> ?1 file changed, 45 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 464303c..ab29cbe 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -221,6 +221,51 @@
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?fsl,pull-up = <0>;
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?};
>
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? lcd_data_pins_8bpp_a: lcd at 0 {

Please remove the "bpp" from all the names.

bpp is usually used for the pixel depth in a framebuffer, and what you
are describing here is how many bits are physically connected into the
LCD interface.

Regards,

Fabio Estevam
