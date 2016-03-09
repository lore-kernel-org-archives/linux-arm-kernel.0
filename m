From: julien.grall@arm.com (Julien Grall)
Date: Wed, 9 Mar 2016 12:35:23 +0700
Subject: [PATCH v3 1/9] clocksource: arm_arch_timer: Gather KVM specific
 information in a structure
In-Reply-To: <20160309032343.GE26583@lvm>
References: <1457436573-6180-1-git-send-email-julien.grall@arm.com>
 <1457436573-6180-2-git-send-email-julien.grall@arm.com>
 <20160309032343.GE26583@lvm>
Message-ID: <56DFB61B.4040707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 09/03/2016 10:23, Christoffer Dall wrote:
> On Tue, Mar 08, 2016 at 11:29:25AM +0000, Julien Grall wrote:
>> -static struct timecounter timecounter;
>> +static struct arch_timer_kvm_info arch_timer_kvm_info;
>> +
>> +struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
>
> borderline bikeshedding question:
>
> does it make sense that the info the arch timer code exports is labeled
> to be kvm-specific?  In other words, could we imagine another subsystem
> using this timer info some time and is there a more generic term that
> would be more appropriate?

I can't see any other usage. I would keep the function name KVM specific 
until someone really need similar information.

Cheers,

-- 
Julien Grall
