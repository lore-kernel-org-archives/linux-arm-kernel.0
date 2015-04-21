From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 21 Apr 2015 16:23:12 +0900
Subject: [PATCH v3 3/4] ARM: dts: UniPhier: add support for UniPhier SoCs
 and boards
In-Reply-To: <2809229.iRV9NgGGKe@wuerfel>
References: <1429285698-11829-1-git-send-email-yamada.masahiro@socionext.com>
 <1429285698-11829-4-git-send-email-yamada.masahiro@socionext.com>
 <2809229.iRV9NgGGKe@wuerfel>
Message-ID: <CAK7LNAQoS4vbU_ZEsf=F8Sy8be8xn8N2taTVkEeJ3ROBQmar=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


2015-04-18 0:56 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Saturday 18 April 2015 00:48:17 Masahiro Yamada wrote:
>> +
>> +               smp_syscon at 59801208 {
>> +                       compatible = "socionext,uniphier-smp-reg", "syscon";
>> +                       reg = <0x59801208 0x4>;
>> +               };
>> +
>>
>
> Using syscon here is a good idea, but please name the register area
> according to what it is called in the data sheet, not according to how
> it is used in Linux, and list all the registers that belong in this
> device. It's quite possible that another driver needs a second
> register from the same syscon.
>
> E.g. if there is a device called a foo controller, make this device
>
>         foo-controller at 0x59800000 {
>                 compatible = "socionext,uniphier-foo-controller", "syscon";
>                 reg = <0x59800000 0x4000>;
>         };
>
> then hardcode the 0x1208 offset in the smp code, or add it as an
> argument to the property containing the phandle.
>

OK, I updated this part in v4.


-- 
Best Regards
Masahiro Yamada
