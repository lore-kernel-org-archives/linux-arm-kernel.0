From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 01 Jul 2014 06:39:08 -0700
Subject: [RFC PATCH 2/6] arm64: Support restart through restart notifier
 call chain
In-Reply-To: <20140701072647.GI28647@lukather>
References: <1404155499-21177-1-git-send-email-linux@roeck-us.net>
 <1404155499-21177-3-git-send-email-linux@roeck-us.net>
 <20140701072647.GI28647@lukather>
Message-ID: <53B2B9FC.8000600@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2014 12:26 AM, Maxime Ripard wrote:
> On Mon, Jun 30, 2014 at 12:11:35PM -0700, Guenter Roeck wrote:
>> The kernel core now supports a notifier call chain to restart the system.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   arch/arm64/kernel/process.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index 43b7c34..9dd2abd 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -43,6 +43,7 @@
>>   #include <linux/hw_breakpoint.h>
>>   #include <linux/personality.h>
>>   #include <linux/notifier.h>
>> +#include <linux/watchdog.h>
>
> I don't think you need this include, or shouldn't it be reboot.h
> instead?
>

Yes, that will be removed in the next version of the patch.

Thanks,
Guenter
