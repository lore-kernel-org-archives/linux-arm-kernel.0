From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 19 Feb 2013 13:48:27 -0800
Subject: [patch 1/2] kcmp: Make it to depend on CONFIG_KCMP
In-Reply-To: <20130219134256.f4cedf44.akpm@linux-foundation.org>
References: <20130219064800.719149796@openvz.org>
 <20130219065210.030802820@openvz.org> <5123444D.6000806@suse.cz>
 <20130219093154.GF20312@moon> <5123BC2B.6000304@zytor.com>
 <20130219182838.GL20312@moon>
 <20130219134256.f4cedf44.akpm@linux-foundation.org>
Message-ID: <5123F32B.3000401@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 01:42 PM, Andrew Morton wrote:
>> Index: linux-2.6.git/kernel/Makefile
>> ===================================================================
>> --- linux-2.6.git.orig/kernel/Makefile
>> +++ linux-2.6.git/kernel/Makefile
>> @@ -25,9 +25,7 @@ endif
>>   obj-y += sched/
>>   obj-y += power/
>>
>> -ifeq ($(CONFIG_CHECKPOINT_RESTORE),y)
>> -obj-$(CONFIG_X86) += kcmp.o
>> -endif
>> +obj-$(CONFIG_KCMP) += kcmp.o
>>   obj-$(CONFIG_FREEZER) += freezer.o
>>   obj-$(CONFIG_PROFILING) += profile.o
>>   obj-$(CONFIG_STACKTRACE) += stacktrace.o
>
> This permits people to select kcmp with CONFIG_CHECKPOINT_RESTORE=n.
> Is there any point in doing that?
>
> What would be wrong with just doing
>
> 	obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
>

The real question is if there are any potential use cases of kcmp() 
outside checkpoint/restore.  It is actually a very general facility.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
