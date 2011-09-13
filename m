From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 13 Sep 2011 11:05:23 +0530
Subject: [PATCH 16/25] OMAP4: PM: Program CPU1 to hit OFF when off-lined
In-Reply-To: <87mxe9ea7c.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-17-git-send-email-santosh.shilimkar@ti.com>
	<87mxe9ea7c.fsf@ti.com>
Message-ID: <4E6EEB9B.1070305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 September 2011 02:42 AM, Kevin Hilman wrote:
> Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
>
>> Program non-boot CPUs to hit lowest supported power state
>> when it is off-lined using cpu hotplug framework.
>>
>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>
> [...]
>
>> @@ -39,15 +43,15 @@ void platform_cpu_die(unsigned int cpu)
>>   	 * we're ready for shutdown now, so do it
>>   	 */
>>   	if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
>> -		printk(KERN_CRIT "Secure clear status failed\n");
>> +		pr_err("Secure clear status failed\n");
>
> nit: pr_crit() exists if you want to keep the same level.  Or did you
> lower the level on purpose?
>
I lowered it on purpose since I didn't find it crtical.

Regards
Santosh
