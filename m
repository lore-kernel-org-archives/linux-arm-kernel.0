From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 17 Aug 2016 21:15:03 -0500
Subject: [PATCH v3 0/4] Amlogic: Meson: Add reset controller
In-Reply-To: <1464853333.3307.1.camel@pengutronix.de>
References: <1464614838-28107-1-git-send-email-narmstrong@baylibre.com>
 <1464853333.3307.1.camel@pengutronix.de>
Message-ID: <CAOi56cV4uUkx+H4fKjFESOs_Kc0p0x5XfAQjtTNQJRjCQmAtGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Thu, Jun 2, 2016 at 2:42 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Neil,
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
>
> I've applied these two patches to the reset/next branch.
>

I'm just noticing now that these didn't make it into v4.8-rc1.  Was
there reason for that?

Kevin
