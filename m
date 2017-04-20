From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Apr 2017 15:24:13 +0300
Subject: [PATCH 1/3] ARM: dts: r8a7743: add PFC support
In-Reply-To: <20170420085112.GF3760@verge.net.au>
References: <20170414211505.733692280@cogentembedded.com>
 <20170420085112.GF3760@verge.net.au>
Message-ID: <58926448-b1d7-668a-a0a3-40b245b59d27@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/20/2017 11:51 AM, Simon Horman wrote:

>> Define the generic R8A7743 part of the PFC device node.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>>  arch/arm/boot/dts/r8a7743.dtsi |    7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> Index: renesas/arch/arm/boot/dts/r8a7743.dtsi
>> ===================================================================
>> --- renesas.orig/arch/arm/boot/dts/r8a7743.dtsi
>> +++ renesas/arch/arm/boot/dts/r8a7743.dtsi
>> @@ -1,7 +1,7 @@
>>  /*
>>   * Device Tree Source for the r8a7743 SoC
>>   *
>> - * Copyright (C) 2016 Cogent Embedded Inc.
>> + * Copyright (C) 2016-2017 Cogent Embedded Inc.
>>   *
>>   * This file is licensed under the terms of the GNU General Public License
>>   * version 2. This program is licensed "as is" without any warranty of any
>> @@ -123,6 +123,11 @@
>>  			#power-domain-cells = <1>;
>>  		};
>>
>> +		pfc: pin-controller at e6060000 {
>> +			compatible = "renesas,pfc-r8a7743";
>> +			reg = <0 0xe6060000 0 0x250>;
>> +		};
>> +
>
> I am curious to know why pin-controller was chosen rather than pfc which
> is dominant in the DT for Renesas SoCs.

    The reason is simple: I was trying to follow the DT specs which require 
generic node names. The "pin-controller" looked more generic than "pfc".

> And as a follow-up question, do
> you think it would be worth creating patches to make this uniform
> across the DT for Renesas SoCs.

    Yes, probably.

[...]

MBR, Sergei
