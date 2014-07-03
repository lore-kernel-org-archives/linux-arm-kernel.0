From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Jul 2014 15:08:34 +0200
Subject: [PATCH 12/16] cpuidle: mvebu: Rename the driver from armada-370-xp
 to mvebu-v7
In-Reply-To: <20140630152806.12d018cf@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-13-git-send-email-gregory.clement@free-electrons.com>
 <20140630152806.12d018cf@free-electrons.com>
Message-ID: <53B555D2.8050609@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,


> On Fri, 27 Jun 2014 15:22:53 +0200, Gregory CLEMENT wrote:
>> Actually this driver will be able to manage the cpuidle for more SoCs
>> that Armada 370 ad XP. It will support Armada 38x and potentially
>> Armada 375. This patch change the names accordingly to this behavior.
> 
> I think the last sentence should rather be something like: "This patch
> renames the driver as well as the functions and variables used in the
> driver".
> 
> I would also specifically mention the renaming of the driver that
> requires changing the pmsu.c file. It is worth mentioning that this
> rename, touching both drivers/cpuidle and arch/arm/mach-mvebu, may
> require some special handling in terms of patch merging (the patch
> mainly touches drivers/cpuidle so it should theoretically go through
> the cpuidle maintainer, but since the pmsu.c file is touched a lot by
> other patches, there will probably be lots of conflicts if this patch
> goes through the cpuidle tree). Surely something to mention as a
> comment in the patch, maybe to get the Acked-by of the cpuidle people
> and merge things through the mvebu and arm-soc trees.

I mentioned it in the cover letter but not with all the details.

> 
>> -config ARM_ARMADA_370_XP_CPUIDLE
>> -	bool "CPU Idle Driver for Armada 370/XP family processors"
>> +config ARM_MVEBU_V7_CPUIDLE
>> +	bool "CPU Idle Driver for mvebu v7 family processors"
> 
> Actually, what worries me a bit of that Dove is a ARMv7 processor of
> the mvebu family, but which is not using this cpuidle driver. Do you
> expect Dove to be able to use this driver in the future?

Dove is also capable to go in deep idle mode as the other. The driver is
now very generic all the SoC related code are not in the driver, so it
would be possible. An argument against it, is that Armada 370, 38x and XP
all use the PMSU manage the deep idle mode, wheres Dove use an other set
of register.

> 
>>  	depends on ARCH_MVEBU
>>  	help
>> -	  Select this to enable cpuidle on Armada 370/XP processors.
>> +	  Select this to enable cpuidle on Armada 370, 385 and XP processors.
> 
> 385 -> 38x, because 380 and 385 are both capable of using this driver.

OK
> 
>> diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidle/cpuidle-armada-370-xp.c
>> deleted file mode 100644
>> index a5fba0287bfb..000000000000
>> --- a/drivers/cpuidle/cpuidle-armada-370-xp.c
>> +++ /dev/null
> 
> You haven't enabled rename detection in git? Or git isn't detecting the
> rename because of the number of changes in the file?

I am not aware of this kind of configuration, internally for git I think it is
the same thing, it is only the way he exposed this to the user that can be changed.
However, it is true that I didn't use the -M flag with format-patch.

I will use it next time, because there also some change in the driver itself, it was
mostly something like s/armada_370_xp/mvebu_v7/


Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
