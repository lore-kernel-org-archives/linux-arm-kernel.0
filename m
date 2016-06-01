From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 01 Jun 2016 10:43:28 -0700
Subject: [PATCH v3 0/4] Amlogic: Meson: Add reset controller
In-Reply-To: <1464790113.3522.4.camel@pengutronix.de> (Philipp Zabel's message
 of "Wed, 01 Jun 2016 16:08:33 +0200")
References: <1464614838-28107-1-git-send-email-narmstrong@baylibre.com>
 <1464790113.3522.4.camel@pengutronix.de>
Message-ID: <7heg8geren.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philipp Zabel <p.zabel@pengutronix.de> writes:

> Hi Kevin,
>
> Am Montag, den 30.05.2016, 15:27 +0200 schrieb Neil Armstrong:
>> Patchset to add and enable the reset controller driver on Meson SoCs platforms.
>> 
>> This reset controller has up to 256 reset lines with reset pulse generation only,
>> so the assert and deassert calls are not available.
>> 
>> Depends on the patch :
>>  - "reset: add devm_reset_controller_register API" [1]
>> 
>> Changes since v2 at http://lkml.kernel.org/r/1464169758-26975-1-git-send-email-narmstrong at baylibre.com :
>> - Get back __iomem in _reset() callback
>> - Get rid of MODULE_ALIAS
>> 
>> Changes since v1 at http://lkml.kernel.org/r/1463732875-23141-1-git-send-email-narmstrong at baylibre.com :
>> - Remove _gxbb_ in names
>> - Depends build on ARCH_MESON only
>> - Add meson8b compatible and bindings
>> - Re-indent dt-bindings headers
>> - Switch to devm_ reset controller register
>> - Remove platform "remove" callback
>> - Update Dual BSD/GPL file headers
>> 
>> Changes since the RFC at http://lkml.kernel.org/r/1463148012-25988-1-git-send-email-narmstrong at baylibre.com :
>> - Fix register mapping and bit defines in bindings header
>> - Remove assert and unassert calls
>> - Fix missing __iomem
>> 
>> [1] https://patchwork.kernel.org/patch/8988471/
>> 
>> Neil Armstrong (4):
>>   reset: Add support for the Amlogic Meson SoC Reset Controller
>>   dt-bindings: reset: Add bindings for the Meson SoC Reset Controller
>>   ARM64: dts: amlogic: Enable Reset Controller on GXBB-based platforms
>>   ARM: dts: amlogic: Enable Reset Controller on Meson8b platforms
>
> Should I take the two device tree patches into the reset tree?

You can take the driver and the bindings. We will take the DT patches
through the amlogic tree, and submit via arm-soc.

> Is resolving the reset/deassert situation a prerequisite for these
> patches?

No, not a prerequisite.  Go ahead and merge the driver.

It just means that hardware reset doesn't actually happen when using
drivers/net/ethernet/stmicro/stmmac/* because it only uses
assert/reassert currently.

Kevin
