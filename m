From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 19 Nov 2015 11:29:50 +0100
Subject: [PATCH] ARM: dts: Kirkwood: Fix QNAP TS219 power-off
In-Reply-To: <1447250584-10153-1-git-send-email-andrew@lunn.ch> (Andrew Lunn's
 message of "Wed, 11 Nov 2015 15:03:04 +0100")
References: <1447250584-10153-1-git-send-email-andrew@lunn.ch>
Message-ID: <87y4duxowx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew and Helmut,
 
 On mer., nov. 11 2015, Andrew Lunn <andrew@lunn.ch> wrote:

> From: Helmut Klein <hgkr.klein@gmail.com>
>
> The "reg" entry in the "poweroff" section of "kirkwood-ts219.dtsi"
> addressed the wrong uart (0 = console). This patch changes the address
> to select uart 1, which is the uart connected to the pic
> microcontroller, which can switch the device off.
>
> Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Fixes: 4350a47bbac3 ("ARM: Kirkwood: Make use of the QNAP Power off
> driver.")


Applied on mvebu/fixes

Thanks,

Gregory

> ---
>
> Hi Helmut
>
> I made a few minor changes to your patch:
>
> 1) Made subject line consistent with other patches to kirkwood-ts219.dtsi
> 2) Added a Fixes: tag, so that it gets backported to stable
> 3) Put comments after the ---, so they don't land in the change log.
>
> Hi Gregory
>
> This is a fix, i guess too late for this merge window, so please could
> you send it after -rc1 is out?
> ---
>  arch/arm/boot/dts/kirkwood-ts219.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
> index c56ab6bbfe3c..0e46560551f4 100644
> --- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
> @@ -40,7 +40,7 @@
>  		};
>  		poweroff at 12100 {
>  			compatible = "qnap,power-off";
> -			reg = <0x12000 0x100>;
> +			reg = <0x12100 0x100>;
>  			clocks = <&gate_clk 7>;
>  		};
>  		spi at 10600 {
> -- 
> 2.6.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
