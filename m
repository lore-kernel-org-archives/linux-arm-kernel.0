From: cphealy@gmail.com (Chris Healy)
Date: Tue, 17 Jul 2018 07:55:12 -0700
Subject: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
In-Reply-To: <20180717144638.GB16320@lunn.ch>
References: <20180717040651.641-1-andrew.smirnov@gmail.com>
 <20180717144638.GB16320@lunn.ch>
Message-ID: <CAFXsbZpKyLjp0bO7MVR5StKf=3UkXUANydhM+8_13G3itRmE+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 7:46 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, Jul 16, 2018 at 09:06:51PM -0700, Andrey Smirnov wrote:
>> Add support for Zodiac Inflight Innovations SSMB SPU3
>> board (VF610-based).
>>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: cphealy at gmail.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile                |   3 +-
>>  arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 343 ++++++++++++++++++++++
>>  2 files changed, 345 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index bea41b129493..e331b2c16539 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -570,7 +570,8 @@ dtb-$(CONFIG_SOC_VF610) += \
>>       vf610m4-cosmic.dtb \
>>       vf610-twr.dtb \
>>       vf610-zii-dev-rev-b.dtb \
>> -     vf610-zii-dev-rev-c.dtb
>> +     vf610-zii-dev-rev-c.dtb \
>> +     vf610-zii-ssmb-spu3.dtb
>>  dtb-$(CONFIG_ARCH_MXS) += \
>>       imx23-evk.dtb \
>>       imx23-olinuxino.dtb \
>> diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
>> new file mode 100644
>> index 000000000000..b692117d7839
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
>> @@ -0,0 +1,343 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +
>> +/*
>> + * Device tree file for ZII's SSMB SPU3 board
>> + *
>> + * SSMB - SPU3 Switch Management Board
>> + * SPU - Seat Power Unit
>
> I think this is the first Zodiac board with mutually recursive
> acronyms.
>
> Probably a question for Chris: Does SSMB specifically refer to version
> 3 of the SPU?
>
>    Andrew

SPU3 is the third generation of seat power unit.
SSMB is the SPU3 Switch Management Board.

So, SSMB is a backronym.  This naming scheme breaks down a bit though
when follow on designs (that are not the SPU3) also use the SSMB, but
that's what it is... ;-)
