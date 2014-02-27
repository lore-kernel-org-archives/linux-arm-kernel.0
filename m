From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Feb 2014 16:43:03 -0800
Subject: [PATCH v3 1/9] Input: pmic8xxx-pwrkey - Migrate to regmap APIs
In-Reply-To: <20140227003009.GG18563@joshc.qualcomm.com>
References: <1393441562-685-1-git-send-email-sboyd@codeaurora.org>
 <1393441562-685-2-git-send-email-sboyd@codeaurora.org>
 <20140226235959.GD18563@joshc.qualcomm.com> <530E8154.9060403@codeaurora.org>
 <20140227001358.GF18563@joshc.qualcomm.com> <530E84B3.8020608@codeaurora.org>
 <20140227003009.GG18563@joshc.qualcomm.com>
Message-ID: <530E8A17.8060603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/14 16:30, Josh Cartwright wrote:
> On Wed, Feb 26, 2014 at 04:20:03PM -0800, Stephen Boyd wrote:
>> On 02/26/14 16:13, Josh Cartwright wrote:
>>> On Wed, Feb 26, 2014 at 04:05:40PM -0800, Stephen Boyd wrote:
>>>> On 02/26/14 15:59, Josh Cartwright wrote:
>>> However, I think it needs to be made clear that your if "Modernize pm8921
>>> with irqdomains, regmap, DT" lands before this patchset, this will start
>>> breaking randconfig builds.  It isn't clear to me how this dependency
>>> should be handled.
>>>
>> Hmm? If pm8921 lands before this what build breakage is there? The
>> pm8xxx_read/write APIs are still exposed.
> Well, with the pm8921 patchset in place, the keypad driver becomes
> selectable, which, when built leads to the error below.  But AFAICT,
> this isn't even addressed in this patchset?!
>
> drivers/input/keyboard/pmic8xxx-keypad.c:24:35: fatal error: linux/mfd/pm8xxx/gpio.h: No such file or directory
>  #include <linux/mfd/pm8xxx/gpio.h>
>                                    ^
>
> So, I'm confused...maybe the pm8921 cleanup patchset should be marking
> the keypad driver BROKEN?
>

Ah, yes probably. I have a patch locally that rips out the gpio stuff
because this driver has been uncompilable since it was introduced. I may
as well send that along with this series so that people can actually
compile this driver. Or like you say, send it along with the removal of
the BROKEN in pm8921 Kconfig.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
