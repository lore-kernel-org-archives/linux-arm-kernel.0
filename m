From: govindraj.ti@gmail.com (Govindraj)
Date: Thu, 23 Sep 2010 16:45:20 +0530
Subject: [PATCH 10/13 v2] OMAP3: serial: Fix uart4 handling for 3630
In-Reply-To: <87d3s5a5k7.fsf@deeprootsystems.com>
References: <37596.172.24.137.131.1285168469.squirrel@dbdmail.itg.ti.com>
	<87d3s5a5k7.fsf@deeprootsystems.com>
Message-ID: <AANLkTikYO5=3PE9YbkFteJ63hsR4n1zE80voNz23P+6X@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 1:56 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> This patch makes the following:
>> ?- Adds missing wakeup padding register handling.
>> ?- Fixes a hardcode to use PER module ONLY on UART3.
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> ?arch/arm/mach-omap2/serial.c | ? ?8 ++++++--
>> ?1 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>> index 72b5c98..c1404af 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -57,7 +57,7 @@
>> ? * disabled via sysfs. This also causes that any deeper omap sleep states are
>> ? * blocked.
>> ? */
>> -#define DEFAULT_TIMEOUT 0
>> +#define DEFAULT_TIMEOUT 5
>
> Oops
>
> Please leave this at zero.

Yes my mistake.
Will correct this.

>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>



-- 
---
Regards,
Govindraj.R
