From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 05 Dec 2016 16:44:01 +0100
Subject: [PATCH] ARM: dts: orion5x: fix number of sata port for
 linkstation ls-gl
In-Reply-To: <20161201151112.930-1-rogershimizu@gmail.com> (Roger Shimizu's
 message of "Fri, 2 Dec 2016 00:11:12 +0900")
References: <20161201151112.930-1-rogershimizu@gmail.com>
Message-ID: <87twaigz3y.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,
 
 On jeu., d?c. 01 2016, Roger Shimizu <rogershimizu@gmail.com> wrote:

> Bug report from Debian [0] shows there's minor changed model of
> Linkstation LS-GL that uses the 2nd SATA port of the SoC.
> So it's necessary to enable two SATA ports, though for that specific
> model only the 2nd one is used.
>
> [0] https://bugs.debian.org/845611
>
> Fixes: b1742ffa9ddb ("ARM: dts: orion5x: add device tree for buffalo linkstation ls-gl")
> Reported-by: Ryan Tandy <ryan@nardis.ca>
> Tested-by: Ryan Tandy <ryan@nardis.ca>
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>

Applied on mvebu/fixes

Thanks,

Gregory


> ---
>  arch/arm/boot/dts/orion5x-linkstation-lsgl.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
> index 1cf644b..51dc734 100644
> --- a/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
> +++ b/arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
> @@ -82,6 +82,10 @@
>  	gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>  };
>  
> +&sata {
> +	nr-ports = <2>;
> +};
> +
>  &ehci1 {
>  	status = "okay";
>  };
> -- 
> 2.10.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
