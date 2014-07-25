From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 25 Jul 2014 16:08:48 +0200
Subject: [PATCH] ARM: rockchip: Fix missing dtbs in Makefile
In-Reply-To: <1406295371-2517-1-git-send-email-daniel.lezcano@linaro.org>
References: <1406295371-2517-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <6733241.HeFFY6HYNT@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Am Freitag, 25. Juli 2014, 15:36:11 schrieb Daniel Lezcano:
> The dtb for rockchip are missing in the Makefile.
> 
> Add the missing ones.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Doug Anderson posted yesterday a similar patch [0]
	"ARM: dts: Build dtbs for Rockchip boards"
which I've added already.


Heiko

[0] https://lkml.org/lkml/2014/7/24/652
> ---
>  arch/arm/boot/dts/Makefile |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index adb5ed9..fb7c589 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -445,6 +445,9 @@ dtb-$(CONFIG_MACH_DOVE) += dove-cm-a510.dtb \
>  	dove-d2plug.dtb \
>  	dove-d3plug.dtb \
>  	dove-dove-db.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += \
> +	rk3288-evb-act8846.dtb \
> +	rk3288-evb-rk808.dtb
> 
>  targets += dtbs dtbs_install
>  targets += $(dtb-y)
