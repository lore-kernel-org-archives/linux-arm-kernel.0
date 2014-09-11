From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Thu, 11 Sep 2014 08:21:58 +0000
Subject: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <62651744.c71MLsL3Q5@wuerfel>
References: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
 <1410253952-15631-2-git-send-email-jingchang.lu@freescale.com>
 <62651744.c71MLsL3Q5@wuerfel>
Message-ID: <cd69af536cd248b8add94a468fa97095@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Arnd Bergmann [mailto:arnd at arndb.de]
>Sent: Tuesday, September 09, 2014 7:53 PM
>To: linux-arm-kernel at lists.infradead.org
>Cc: Lu Jingchang-B35083; Guo Shawn-R65073; devicetree at vger.kernel.org;
>Zhao Chenhui-B35336; Fu Chao-B44548; Leekha Shaveta-B20052; Gupta Suresh-
>B42813; Sharma Bhupesh-B45370; Xiubo Li-B47053; Gupta Ruchika-R66431; Lu
>Jingchang-B35083; Badola Nikhil-B46172
>Subject: Re: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
>LS1021A
>
>On Tuesday 09 September 2014 17:12:27 Jingchang Lu wrote:
>> +       aliases {
>> +               serial0 = &lpuart0;
>> +               serial1 = &lpuart1;
>> +               serial2 = &lpuart2;
>> +               serial3 = &lpuart3;
>> +               serial4 = &lpuart4;
>> +               serial5 = &lpuart5;
>> +               ethernet0 = &enet0;
>> +               ethernet1 = &enet1;
>> +               ethernet2 = &enet2;
>> +               sysclk = &sysclk;
>> +       };
>> +
>> +       memory at 80000000 {
>> +               device_type = "memory";
>> +               reg = <0x0 0x80000000 0x0 0x20000000>;
>> +       };
>> +
>>
>
>
>One more thing: these should all go into the board specific files.
>
>The installed memory is almost always a property of the board, not the SoC,
>and a lot of boards only connect a subset of the serial ports, or they may
>have them in a different order.
>
>In particular, you only provide aliases for the six out of the ten
>available uarts, which seems arbitrary.
>
>	Arnd

The memory size info will be fixed up in u-boot before booting the kernel image,
so I add the memory node in the SoC level device tree and keep only one copy. 
The lpuart derives the line number from the node's alias id, 8250 serial driver
doesn't rely on it, so only aliases for the lpuart are added, not arbitrary.
Thanks.

Best Regards,
Jingchang
