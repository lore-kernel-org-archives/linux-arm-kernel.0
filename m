From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 27 May 2013 14:46:52 +0200
Subject: [PATCH v3] ARM: at91: Fix link breakage when !CONFIG_PHYLIB
In-Reply-To: <51A34BF9.5000905@atmel.com>
References: <1369651702-9207-1-git-send-email-alexandre.belloni@free-electrons.com>
 <51A34BF9.5000905@atmel.com>
Message-ID: <51A355BC.6090309@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/05/2013 14:05, Nicolas Ferre wrote:
> On 27/05/2013 12:48, Alexandre Belloni :
>> Fixes:
>> arch/arm/mach-at91/built-in.o: In function `ksz9021rn_phy_fixup':
>> :(.text+0x1174): undefined reference to `mdiobus_write'
>> :(.text+0x1188): undefined reference to `mdiobus_write'
>> :(.text+0x119c): undefined reference to `mdiobus_write'
>> :(.text+0x11b0): undefined reference to `mdiobus_write'
>> arch/arm/mach-at91/built-in.o: In function `sama5_dt_device_init':
>> :(.init.text+0x1e34): undefined reference to
>> `phy_register_fixup_for_uid'
>>
>> when CONFIG_PHYLIB is not selected.
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>> ---
>> Changes in v3:
>>     added SoB
>>     added Acked-By
>
> A v3 is not needed simply for this. Thanks, anyway!
>

It was not much and I have to stop forgetting my SoB ;)

> One question though: why not just add
>
>         select PHYLIB
>
> In Kconfig entry:
>
>  config MACH_SAMA5_DT
>
> ?
>

That would simply mean that you have to enable NET when using a SAMA5
which is not what every user will want.

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
