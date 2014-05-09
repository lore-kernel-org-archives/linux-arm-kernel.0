From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 09 May 2014 15:26:52 +0200
Subject: [PATCH v5 0/3] ARM: sunxi: Add support for consumer infrared
 devices
In-Reply-To: <E54FF549-B53A-406B-9871-E2C3B1ED8157@hackerdom.ru>
References: <1398871010-30681-1-git-send-email-bay@hackerdom.ru>
 <536B8CDD.7040600@redhat.com>
 <E54FF549-B53A-406B-9871-E2C3B1ED8157@hackerdom.ru>
Message-ID: <536CD79C.8080800@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/09/2014 03:21 PM, Alexander Bersenev wrote:
> Hello, I am in Austria/Germany in 1-11 may. I plan to make v6 after returning back to Russia.

Ok, when you do please also pick up this fix:
https://github.com/jwrdegoede/linux-sunxi/commit/180a3e59361ceddeed26543529ca757cc8112fb0

Which fixes an oops at startup.

Other then needing that fix + coding style fixes it works well for me on
the cubietruck. I'll try to also test it on sun4i and sun5i if I can find some
time to do so.

Regards,

Hans


> 
> Best,
> Alexander Bersenev
> 
>> 08 ??? 2014 ?., ? 15:55, Hans de Goede <hdegoede@redhat.com> ???????(?):
>>
>> Hi,
>>
>>> On 04/30/2014 05:16 PM, Alexander Bersenev wrote:
>>> This patch introduces Consumer IR(CIR) support for sunxi boards.
>>>
>>> This is based on Alexsey Shestacov's work based on the original driver 
>>> supplied by Allwinner.
>>>
>>> Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
>>> Signed-off-by: Alexsey Shestacov <wingrime@linux-sunxi.org>
>>
>> Alexander, v5 still has various issues which need fixing,
>> do you plan to do a v6 soon ?
>>
>> Regards,
>>
>> Hans
>>
>>>
>>> ---
>>> Changes since version 1: 
>>> - Fix timer memory leaks 
>>> - Fix race condition when driver unloads while interrupt handler is active
>>> - Support Cubieboard 2(need testing)
>>>
>>> Changes since version 2:
>>> - More reliable keydown events
>>> - Documentation fixes
>>> - Rename registers accurding to A20 user manual
>>> - Remove some includes, order includes alphabetically
>>> - Use BIT macro
>>> - Typo fixes
>>>
>>> Changes since version 3:
>>> - Split the patch on smaller parts
>>> - More documentation fixes
>>> - Add clock-names in DT
>>> - Use devm_clk_get function to get the clocks
>>> - Removed gpios property from ir's DT
>>> - Changed compatible from allwinner,sunxi-ir to allwinner,sun7i-a20-ir in DT
>>> - Use spin_lock_irq instead spin_lock_irqsave in interrupt handler
>>> - Add myself in the copyright ;)
>>> - Coding style and indentation fixes
>>>
>>> Changes since version 4:
>>> - Try to fix indentation errors by sending patches with git send-mail
>>>
>>> Alexander Bersenev (3):
>>>  ARM: sunxi: Add documentation for sunxi consumer infrared devices
>>>  ARM: sunxi: Add driver for sunxi IR controller
>>>  ARM: sunxi: Add IR controller support in DT on A20
>>>
>>> .../devicetree/bindings/media/sunxi-ir.txt         |  23 ++
>>> arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |   6 +
>>> arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   6 +
>>> arch/arm/boot/dts/sun7i-a20.dtsi                   |  31 +++
>>> drivers/media/rc/Kconfig                           |  10 +
>>> drivers/media/rc/Makefile                          |   1 +
>>> drivers/media/rc/sunxi-ir.c                        | 303 +++++++++++++++++++++
>>> 7 files changed, 380 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/media/sunxi-ir.txt
>>> create mode 100644 drivers/media/rc/sunxi-ir.c
>>>
