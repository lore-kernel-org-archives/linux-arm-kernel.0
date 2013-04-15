From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 15 Apr 2013 16:37:57 +0200
Subject: [RFC patch 2/2] ARM: at91: cpuidle: move the driver to
 drivers/cpuidle directory
In-Reply-To: <20130415142047.GE15139@game.jcrosoft.org>
References: <1366032598-23053-1-git-send-email-daniel.lezcano@linaro.org>
 <1366032598-23053-3-git-send-email-daniel.lezcano@linaro.org>
 <20130415142047.GE15139@game.jcrosoft.org>
Message-ID: <516C10C5.4050107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2013 04:20 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:29 Mon 15 Apr     , Daniel Lezcano wrote:
>> We don't have any dependency with the SoC specific code.
>>
>> Move the driver to the drivers/cpuidle directory.
>>
>> Add Nicolas Ferre as author of the driver, so it will be in copy of the emails.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> please use -M when generating the patch

Oh, right. Thanks for reminding me the option.

[ ... ]

>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/cpuidle.h>
>> +#include <asm/cpuidle.h>
>> +
>> +#define AT91_MAX_STATES	2
>> +
>> +extern void (*at91_standby_ops)(void);
> really don't like can we pass it via the pm?

I agree, it is hackish. Can you elaborate when you say "pass it via the
pm" ?



-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
