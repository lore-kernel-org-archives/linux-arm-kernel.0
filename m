From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 13 Jan 2015 23:50:21 +0100
Subject: [PATCH v3 4/6] ARM: at91/dt: add SRAM nodes
In-Reply-To: <1421172746-18727-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421172746-18727-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421172746-18727-5-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150113225021.GG3843@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13/01/2015 at 19:12:24 +0100, Alexandre Belloni wrote :
> diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
> index 72424371413e..c055da2f151f 100644
> --- a/arch/arm/boot/dts/at91sam9rl.dtsi
> +++ b/arch/arm/boot/dts/at91sam9rl.dtsi
> @@ -70,6 +70,11 @@
>  		};
>  	};
>  
> +	sram: sram at 00300000 {
> +		compatible = "mmio-sram";
> +		reg = <0x00300000 0x4000>;
> +	};
> +

Actually, I'm not sure about the sam9rl. The previous code was doing:
        switch (at91_soc_initdata.cidr & AT91_CIDR_SRAMSIZ) {
                case AT91_CIDR_SRAMSIZ_32K:
                        sram_size = 2 * SZ_16K;
                        break;
                case AT91_CIDR_SRAMSIZ_16K:
                default:
                        sram_size = SZ_16K;
        }

So the SRAM size should be 16k or 32k but what I get from the only cidr
registered for sam9rl (0x019b03a0, also from the datasheet) is SRAMSIZ=
0xb which give 64k. Could you confirm?

Thanks,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
