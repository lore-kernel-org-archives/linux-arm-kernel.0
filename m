From: james.morse@arm.com (James Morse)
Date: Fri, 8 Jun 2018 18:44:10 +0100
Subject: [PATCH v4 3/3] arm64: Introduce command line parameter to disable
 CNP
In-Reply-To: <b4771d84-2403-3bd4-9566-4d9b1403d112@arm.com>
References: <1526638022-4137-1-git-send-email-vladimir.murzin@arm.com>
 <1526638022-4137-4-git-send-email-vladimir.murzin@arm.com>
 <20180523171721.ppazcyf576koimhl@armageddon.cambridge.arm.com>
 <b4771d84-2403-3bd4-9566-4d9b1403d112@arm.com>
Message-ID: <a8b90226-b416-4c9d-8352-e40505da478b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir, Catalin,

On 24/05/18 09:20, Vladimir Murzin wrote:
> On 23/05/18 18:17, Catalin Marinas wrote:
>> On Fri, May 18, 2018 at 11:07:02AM +0100, Vladimir Murzin wrote:
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 11fc28e..8f59d47 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -2636,6 +2636,10 @@

>>> +	nocnp		[ARM64]
>>> +			Disable CNP (Common not Private translations)
>>> +			even if it is supported by processor.

>> Do we actually have a use-case for this command line option? I'm not
>> considering hardware errata as these are handled separately in the
>> kernel.

> Well, I cannot count all cases, yet we might see CnP support advertised
> by CPU via ID register (where CPU meant to be part of bL) but not really
> doing optimisations in hardware.
> 
> Probably, some userspace (benchmarks) might not benefit of CnP; otoh maybe
> better way for such case would be user-space asking kernel to {dis,en}able
> CnP...
> 
> I have no strong opinion on patch, so I'm fine to drop it and come back
> when/if we get results from real hardware.

We may want to disable CNP without rebuilding the kernel, which would also have
the affect of code-layout changes...


Thanks,

James
