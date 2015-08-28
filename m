From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 28 Aug 2015 10:08:09 +0200
Subject: linux-next: manual merge of the rtc tree with the arm-soc tree
In-Reply-To: <20150827162229.10fe7255@canb.auug.org.au>
References: <20150827162229.10fe7255@canb.auug.org.au>
Message-ID: <20150828080809.GU13155@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 27/08/2015 at 16:22:29 +1000, Stephen Rothwell wrote :
>   		clock-frequency = <12000000>;
>   	};
>   
>  +	sound0: sound at 0 {
>  +		compatible = "simple-audio-card";
>  +		simple-audio-card,name = "AM437x-GP-EVM";
>  +		simple-audio-card,widgets =
>  +			"Headphone", "Headphone Jack",
>  +			"Line", "Line In";
>  +		simple-audio-card,routing =
>  +			"Headphone Jack",	"HPLOUT",
>  +			"Headphone Jack",	"HPROUT",
>  +			"LINE1L",		"Line In",
>  +			"LINE1R",		"Line In";
>  +		simple-audio-card,format = "dsp_b";
>  +		simple-audio-card,bitclock-master = <&sound0_master>;
>  +		simple-audio-card,frame-master = <&sound0_master>;
>  +		simple-audio-card,bitclock-inversion;
>  +
>  +		simple-audio-card,cpu {
>  +			sound-dai = <&mcasp1>;
>  +			system-clock-frequency = <12000000>;
>  +		};
>  +
>  +		sound0_master: simple-audio-card,codec {
>  +			sound-dai = <&tlv320aic3106>;
>  +			system-clock-frequency = <12000000>;
>  +		};
>  +	};
> ++
> + 	/* fixed 32k external oscillator clock */
> + 	clk_32k_rtc: clk_32k_rtc {
> + 		#clock-cells = <0>;
> + 		compatible = "fixed-clock";
> + 		clock-frequency = <32768>;
> + 	};

It is just a matter of taste but maybe both oscillators/clocks can be
grouped.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
