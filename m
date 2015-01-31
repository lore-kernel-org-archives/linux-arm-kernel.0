From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 31 Jan 2015 21:27:05 +0300
Subject: [PATCH] ARM: shmobile: silk: initial device tree
In-Reply-To: <20150131042143.GB7605@verge.net.au>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <1608366.HtA9yBksdO@wasted.cogentembedded.com>
 <20150131042143.GB7605@verge.net.au>
Message-ID: <54CD1E79.6090700@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 1/31/2015 7:21 AM, Simon Horman wrote:

>> Add the initial device tree for the R8A7794 SoC based SILK low cost board.
>> SCIF2 serial port support is included, so that the serial console can work.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> This patch is against the 'renesas-devel-20150129-v3.19-rc6' tag of Simon
>> Horman's 'renesas.git' repo.

>>   arch/arm/boot/dts/Makefile         |    1
>>   arch/arm/boot/dts/r8a7794-silk.dts |   41 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 42 insertions(+)

[...]
>> Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
>> ===================================================================
>> --- /dev/null
>> +++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
>> @@ -0,0 +1,41 @@
>> +/*
>> + * Device Tree Source for the SILK board
>> + *
>> + * Copyright (C) 2014 Renesas Electronics Corporation
>> + * Copyright (C) 2014-2015 Renesas Solutions Corp.
>> + * Copyright (C) 2014-2015 Cogent Embedded, Inc.
>> + *
>> + * This file is licensed under the terms of the GNU General Public License
>> + * version 2.  This program is licensed "as is" without any warranty of any
>> + * kind, whether express or implied.
>> + */
>> +
>> +/dts-v1/;
>> +#include "r8a7794.dtsi"
>> +
>> +/ {
>> +	model = "SILK";
>> +	compatible = "renesas,silk", "renesas,r8a7794";
>> +
>> +	aliases {
>> +		serial0 = &scif2;
>> +	};
>> +
>> +	chosen {
>> +		bootargs = "console=ttySC0,38400 ignore_loglevel";

> Please remove console= for consistency with other boards
> based on Renesas SoCs.

    I can't, there will be no console at all.

WBR, Sergei
