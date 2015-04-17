From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 18 Apr 2015 01:16:24 +0900
Subject: [PATCH 3/4] ARM: dts: UniPhier: add support for UniPhier SoCs and
 boards
In-Reply-To: <2204571.AOVr95oO32@wuerfel>
References: <1429170038-16757-1-git-send-email-yamada.masahiro@socionext.com>
 <1429170038-16757-4-git-send-email-yamada.masahiro@socionext.com>
 <2204571.AOVr95oO32@wuerfel>
Message-ID: <CAK7LNAQfUqZvTWZyETyXJUr3MDdMtU6MV++jfAcaoqzEKpUxtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2015-04-16 18:44 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 16 April 2015 16:40:37 Masahiro Yamada wrote:
>> +
>> +/ {
>> +     model = "UniPhier PH1-LD4 Reference Board";
>> +     compatible = "socionext,ph1-ld4-ref", "socionext,ph1-ld4";
>> +
>> +     memory {
>> +             device_type = "memory";
>> +             reg = <0x80000000 0x20000000>;
>> +     };
>> +
>> +     chosen {
>> +             bootargs = "console=ttyS0,115200 earlyprintk";
>> +     };
>
> I would remove the 'earlyprintk' option here. You don't add any options
> for the platform in Kconfig.debug, and I hope that we can eventually
> start using earlycon. Please add an appropriate stdio-path property
> here, but note that we are still lacking the fixmap patches to make
> earlycon work.
>
> Otherwise looks good.

I dropped earlyprintk, added stdout-path in v3.

Thanks!


-- 
Best Regards
Masahiro Yamada
