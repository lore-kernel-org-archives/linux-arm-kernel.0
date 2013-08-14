From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Wed, 14 Aug 2013 10:17:34 +0100
Subject: [PATCH v3 0/6] ARM/ARM64 architected timer updates
In-Reply-To: <520B490A.4090109@linaro.org>
References: <1374492082-13686-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376414984-14182-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <520B490A.4090109@linaro.org>
Message-ID: <520B4B2E.1040700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/13 10:08, Daniel Lezcano wrote:
> On 08/13/2013 07:29 PM, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> This patch series adds support to configure the rate and enable the
>> event stream for architected timer. The event streams can be used to
>> impose a timeout on a WFE, to safeguard against any programming error
>> in case an expected event is not generated or even to implement
>> wfe-based timeouts for userspace locking implementations.
>>
>> Since the timer control register is reset to zero on warm boot, CPU
>> PM notifier is added to re-initialize it.
> 
> It does not apply to my tree.
> 
> Against which tree is this patchset ? Who is supposed to take it ?
> 
As I had mentioned in previous version, because of the conflict, I had
to rebase it on 3.11-rc4

>> Changes v2->v3:
>> 1. Moved ARM and ARM64 changes into separate patches
>> 2. Added native hwcaps definations(ARM/ARM64) and compat-specific
>>    definitions(ARM64) to the users for the event stream feature. 
> 
> Ok, we have the choice:
>  1. split the patchset into arch/arm changes and drivers/clocksource
>  2. I ack the patchset and Olof/Kevin take it
>  3. Olof/Kevin ack the patchset and I take it in my tree.
> 
> This is really becoming fuzzy.
>
I am not sure if we need to split it. It would get too messy because of
dependencies. Once we have ACKs from all the corresponding maintainers,
it can go through one of the tree.

> If you want a maintainer to take a patchset you have to send an email
> --to him and --cc mailing list and others concerned by the patchset.
> 
Ok understood.

Regards,
Sudeep
