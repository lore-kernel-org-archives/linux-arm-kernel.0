From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 27 Apr 2015 15:06:14 +0200
Subject: [PATCH v2] ARM: mvebu: Fix the main PLL frequency on Armada 375,
 38x and 39x SoCs
In-Reply-To: <20150427112804.GC2394@lunn.ch>
References: <1430117718-11818-1-git-send-email-gregory.clement@free-electrons.com>
 <20150427112804.GC2394@lunn.ch>
Message-ID: <CAPv3WKcek4-1Tt+9001vTmC-EN_G1N8w070Zw+KiNiy4Hvjz4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-27 13:28 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Mon, Apr 27, 2015 at 08:55:18AM +0200, Gregory CLEMENT wrote:
>> Whereas for Armada 370 and XP the main PLL frequency was 2GHz for the
>> Armada 375, 38x and 39x, the frequency is 1GHz. When writing support
>> for these last SoCs, there was no official value for the PLL. Now that
>> we have it, this patch fixes it in the device tree.
>>
>> This value is currently only used by the NAND driver for the setting
>> the NAND timing. Fortunately it is not actually used: all the mainline
>> board with a NAND flash comes with a NAND device tree node using the
>> "marvell,nand-keep-config" property. With this property the timings
>> are not modified in the kernel driver and are kept from the
>> bootloader.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>> Hi,
>>
>> The only change for this patch is the spell fixes and it was also
>> rebased onto v4.1-rc1. Unless there is any objection I will apply it
>> on mvebu/fixes for 4.1.
>
> Hi Gregory
>
> No objection. Without access to the data sheet or hardware, there is
> little any of us can say against this.
>
> Acked-by: Andrew Lunn <andrew@lunn.ch>
>
>           Andrew
>

Hi Gregory,

Having an access to both HW and the spec, I can confirm the change is needed.

Acked-by: Marcin Wojtas <mw@semihalf.com>

Best regards,
Marcin
