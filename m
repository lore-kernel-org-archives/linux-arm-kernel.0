From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 10 Sep 2015 15:29:18 +0100
Subject: [PATCH] arm64: Add support for hardware updates of the access
 and dirty pte bits
In-Reply-To: <55F17F2E.7080808@arm.com>
References: <1436545468-1549-1-git-send-email-catalin.marinas@arm.com>
 <55F06A87.3000204@citrix.com> <55F17F2E.7080808@arm.com>
Message-ID: <55F193BE.90608@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/15 14:01, Marc Zyngier wrote:
> Hi Julien,
> 
> On 09/09/15 18:21, Julien Grall wrote:
>> Hi Catalin,
>>
>> I've tried to boot the latest linus/master (a794b4f) which include this
>> patch as DOM0 on xgene. This is failing late in the boot with
>> a BUG (see trace below).
>>
>> The bisector pointed me to this patch. When I disable
>> CONFIG_ARM64_HW_AFDBM, I'm able to boot the kernel and use it
>> without any issue.
>>
>> Although, I'm not sure to understand how this patch could
>> possibly break the filesystem subsystem.
>>
>> Do you have any insight for debugging this problem?
> 
> I've just given it a good shake on the Mustang we have here, and I'm not
> experiencing anything like this. Any chance you could print out the
> ID_AA64MMFR1_EL1 register value, just in case?

The value of ID_AA64MMFR1_EL1 is 0000000000000000

I'm using Debian Jessie for the userspace with an LVM partition for the
home. U-boot is used to boot the kernel.

Regards,

-- 
Julien Grall
