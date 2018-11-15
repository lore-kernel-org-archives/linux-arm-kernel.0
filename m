From: agraf@suse.de (Alexander Graf)
Date: Thu, 15 Nov 2018 17:49:31 +0100
Subject: [PATCH v2] arm64: Make kpti command line options x86 compatible
In-Reply-To: <20181115154738.GB2062@brain-police>
References: <20181113152906.55802-1-agraf@suse.de>
 <20181115154738.GB2062@brain-police>
Message-ID: <215607E6-DF71-436C-92FA-AC4716777CA9@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Am 15.11.2018 um 16:47 schrieb Will Deacon <will.deacon@arm.com>:
> 
>> On Tue, Nov 13, 2018 at 04:29:06PM +0100, Alexander Graf wrote:
>> I've already stumbled over 2 cases where people got confused about how to
>> disable kpti on AArch64. In both cases, they used existing x86_64 options
>> and just applied that to an AArch64 system, expecting it to work.
>> 
>> I think it makes a lot of sense to have compatible kernel command line
>> parameters whenever we can have them be compatible.
>> 
>> So this patch adds the pti= and no_pti kernel command line options, mapping
>> them into the existing kpti= command line framework. It preserves the old
>> syntax to maintain compatibility with older command lines.
>> 
>> While at it, the patch also marks the respective options as dual-arch.
>> 
>> Reported-by: Richard Brown <rbrown@suse.de>
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> 
>> ---
>> 
>> v1 -> v2:
>> 
>>  - Actually make it compile. Sorry for the sloppy v1.
>> ---
>> Documentation/admin-guide/kernel-parameters.txt |  6 +++---
>> arch/arm64/kernel/cpufeature.c                  | 20 +++++++++++++++++++-
>> 2 files changed, 22 insertions(+), 4 deletions(-)
> 
> This patch doesn't help though, right, because kpti= has already been
> included with backports etc so the ship has sailed?

Not necessarily. We can always mark this as stable and have distros pull it in. Consistency is definitely useful for everyone.

> Yeah, it's not ideal,
> but we went over this before:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/598395.html

Ah, I mist havd missed that. But if you already have 2 people sending very similar patches, there is probably something to it :).

> 
> The thing we really need is the sysfs interface hooking up so you can easily
> check the state of the mitigation. Still waiting for a follow-up on that ;)
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-September/603412.html

That one is very much needed as well, yes.

Alex

> 
> Will
