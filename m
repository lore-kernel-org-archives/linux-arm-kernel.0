From: bcousson@baylibre.com (Benoit Cousson)
Date: Tue, 15 Oct 2013 09:28:30 +0200
Subject: [PATCH] ARM: dts: omap4-panda-es: Do not reset gpio1
In-Reply-To: <1381423481-5920-1-git-send-email-nm@ti.com>
References: <1381313521-10422-1-git-send-email-rnayak@ti.com>
 <1381423481-5920-1-git-send-email-nm@ti.com>
Message-ID: <525CEE9E.9020507@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

On 10/10/2013 18:44, Nishanth Menon wrote:
> Do not reset GPIO1 at boot-up because GPIO 7 in GPIO1 block is used on
> OMAP4460 PandaBoard-ES to select voltage register in TPS62361 which
> supplies VDD_MPU.
>
> Without this, OMAP4460 PandaBoard-ES boards fail to boot-up because
> MPU voltage switches over to VSET0 voltage value (boot voltage) which
> is not sufficient to operate the device at OPP100.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> As explained here: http://marc.info/?l=u-boot&m=133066647800872&w=2
>
> GPIO1 reset causes PandaBoard-ES to stop functioning.
> This depends on Patch series from Rajendra:
> http://marc.info/?l=linux-doc&m=138131355520116&w=2
> Applies on Benoit's for_13/dts branch:
> https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts

I've just applied it after Rajendra's series.

Thanks,
Benoit


>
> Tested on PandaBoard-ES without the u-boot uenv hack
>
>   arch/arm/boot/dts/omap4-panda-es.dts |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
> index 56c4354..816d1c9 100644
> --- a/arch/arm/boot/dts/omap4-panda-es.dts
> +++ b/arch/arm/boot/dts/omap4-panda-es.dts
> @@ -62,3 +62,7 @@
>   		gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
>   	};
>   };
> +
> +&gpio1 {
> +	 ti,no-reset-on-init;
> +};
>


-- 
Beno?t Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
