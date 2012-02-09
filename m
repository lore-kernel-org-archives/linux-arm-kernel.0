From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 09 Feb 2012 14:00:19 +0100
Subject: [PATCH][V2] ux500 : decouple/recouple gic from the PRCMU
In-Reply-To: <4F33B9B4.2090503@stericsson.com>
References: <1328782040-7786-1-git-send-email-daniel.lezcano@linaro.org>
 <4F33A555.9040504@stericsson.com> <4F33AD37.4060604@linaro.org>
 <4F33B9B4.2090503@stericsson.com>
Message-ID: <4F33C363.1080308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2012 01:19 PM, Rickard Andersson wrote:
> On 02/09/2012 12:25 PM, Daniel Lezcano wrote:
>> On 02/09/2012 11:52 AM, Rickard Andersson wrote:
>>> Hi Daniel!
>>>
>>> Please see my embedded comments.
>>>
>>> Also should we not keep the functions in pm.c file? I think Linus W
>>> advised us not to move stuff around at this stage.
>> The pm.c file does not exists for mach-ux500. May be I misunderstood
>> Linus but I thought he was saying to that we should "not move stuff
>> around" by letting this code in the db8500-prcmu.c file for the moment
>> and let Mattias do its cleanups.
> On our internal tree we have mach-ux500/pm/pm.c and this file contains
> the decouple-gic functions as well as other power management related
> help functions. By moving the code to drivers/mfd/db8500-prcmu.c I think
> we are moving code around. Especially since it not clear how
> db8500-prcmu.c will be handled in the future, db8500-prcmu.c should most
> likely be split into several parts where one part only handles the
> communication with the PRCMU firmware.

Rickard,

the reference is the mainstream code. Today there is no pm.c file and 
everything is located in db8500-prcmu.c. Except if I misunderstood, if 
Linus, who is the maintainer of the ux500 SoC, prefers to have this 
portion of code in this file until Mattias does its cleanups, that does 
not really matter if it is in pm.c or db8500-prcmu.c for the moment.

That does not mean this code won't be moved to pm.c in the future.

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
