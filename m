From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 30 Jan 2013 08:57:20 -0300
Subject: [PATCH 2/3] arm: sunxi: Add clock definitions for the new clock
 driver
In-Reply-To: <5108D8BE.1080906@free-electrons.com>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
 <1358835176-7197-3-git-send-email-emilio@elopez.com.ar>
 <5108D8BE.1080906@free-electrons.com>
Message-ID: <BLU0-SMTP4897778EE63E9FB119BDBD8A1E0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 30/01/13 05:24, Maxime Ripard escribi?:
> Hi Emilio,
> 
> Le 22/01/2013 07:12, Emilio L?pez a ?crit :
> 
>> +		cpu: cpu at 01c20054 {
>> +			#clock-cells = <0>;
>> +			compatible = "allwinner,sunxi-cpu-clk";
>> +			reg = <0x01c20054 0x4>;
>> +			clocks = <&osc32k>, <&osc24M>, <&pll1>;
>> +		};
> 
> Why do you need these three clocks here ? From what you said in patch 3,
> it seems like the 24M oscillator is not a direct parent, but only the
> pll1 and the 32k oscillator, right?

There are two reasons:
 * Hardware wise it actually is a parent, as in, it is an usable source
you can choose on the mux. There is also PLL6 as an option, but it has
no representation yet so I have not listed it.

  Quoting the linux-sunxi wiki:

    0x00 = 32 KHz internal RC clock
    0x01 = 24 MHz external Oscillator
    0x02 = PLL1
    0x03 = 200 MHz sourced from PPL6

 * The example in patch 3 is simplified, you may want to switch to the
24M oscillator first. My intention was to just present the concept/idea,
the actual clock handling on standby contains some more steps; see:

https://github.com/linux-sunxi/linux-sunxi/blob/sunxi-3.0/arch/arm/mach-sun4i/pm/standby/standby.c#L179

Thanks for the review,

Emilio
