From: icenowy@aosc.io (icenowy at aosc.io)
Date: Mon, 24 Jul 2017 11:09:08 +0800
Subject: [linux-sunxi] [PATCH 03/10] ARM: sunxi: h3/h5: Add r_i2c pinmux
 node
In-Reply-To: <CAGb2v67CFxsPYFVUfbUKzidVrPHFkZL10FxvhbC_RN0pvYtbfA@mail.gmail.com>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-4-icenowy@aosc.io>
 <CAGb2v67CFxsPYFVUfbUKzidVrPHFkZL10FxvhbC_RN0pvYtbfA@mail.gmail.com>
Message-ID: <c2afc3c3786536fe240b3c89ed7f5f3f@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-07-24 11:07?Chen-Yu Tsai ???
> On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> From: Ondrej Jirman <megous@megous.com>
>> 
>> H3/H5 SoCs contain an I2C controller optionally available
>> on the PL0 and PL1 pins. This patch adds pinmux configuration
>> for this controller.
>> 
>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>> [Icenowy: change commit message and node name]
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi 
>> b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
>> index 6f2162608006..b240099bc865 100644
>> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
>> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
>> @@ -639,6 +639,11 @@
>>                                 pins = "PL11";
>>                                 function = "s_cir_rx";
>>                         };
>> +
>> +                       r_i2c_pins: r-i2c {
>> +                               pins = "PL0", "PL1";
>> +                               function = "s_twi";
> 
> Can we fix the pinctrl driver to use standard names first? :(

Oh good problem.

Let me fix it.

> 
> ChenYu
> 
>> +                       };
>>                 };
>>         };
>>  };
>> --
>> 2.13.0
>> 
>> --
>> You received this message because you are subscribed to the Google 
>> Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send 
>> an email to linux-sunxi+unsubscribe at googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
