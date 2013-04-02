From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 02 Apr 2013 17:47:41 +0100
Subject: [PATCH v2 07/13] ARM: dts: vexpress: disable CA9 core tile
 sp804 timer
In-Reply-To: <1364854883-5961-8-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
 <1364854883-5961-8-git-send-email-robherring2@gmail.com>
Message-ID: <1364921261.3019.38.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-04-01 at 23:21 +0100, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> The motherboard sp804 timer is used, but core tile sp804 timer is not.
> According to Russell King, the clock configuration is undocumented and
> defaults to 32kHz which is not desireable. So mark core tile sp804 timer
> as disabled.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/boot/dts/vexpress-v2p-ca9.dts |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> index 1420bb1..62d9b22 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> @@ -98,6 +98,7 @@
>  			     <0 49 4>;
>  		clocks = <&oscclk2>, <&oscclk2>;
>  		clock-names = "timclk", "apb_pclk";
> +		status = "disabled";
>  	};
>  
>  	watchdog at 100e5000 {

I'm not sure if this is necessary. The parent oscclk2 (frequency
33-100MHz) should provide enough information for SP804 to work. One
thing that worries me is that it may be not available (not registered
yet) at the time of SP804 initialisation, but then the driver would
simply give up (I hope) on this instance so we would be us back in the
situation where it's not used. I'll try to give this stuff a spin soon.

Pawe?
