From: jcm@jonmasters.org (Jon Masters)
Date: Wed, 17 Jan 2018 13:34:45 -0500
Subject: [PATCH v2] arm64: Branch predictor hardening for Cavium ThunderX2
In-Reply-To: <20180116234554.GA38392@jc-sabre>
References: <20180108164651.GQ25869@arm.com>
 <1515502022-7376-1-git-send-email-jnair@caviumnetworks.com>
 <e9a192da-f603-6523-6d2e-858eb9c7d1b2@jonmasters.org>
 <20180116234554.GA38392@jc-sabre>
Message-ID: <4c91a5a3-be77-72d4-b8f7-2dcef7214b3a@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2018 06:45 PM, Jayachandran C wrote:
> On Tue, Jan 16, 2018 at 04:52:53PM -0500, Jon Masters wrote:
>> On 01/09/2018 07:47 AM, Jayachandran C wrote:
>>
>>> Use PSCI based mitigation for speculative execution attacks targeting
>>> the branch predictor. The approach is similar to the one used for
>>> Cortex-A CPUs, but in case of ThunderX2 we add another SMC call to
>>> test if the firmware supports the capability.
>>>
>>> If the secure firmware has been updated with the mitigation code to
>>> invalidate the branch target buffer, we use the PSCI version call to
>>> invoke it.
>>
>> What's the status of this patch currently? Previously you had suggested
>> to hold while the SMC got standardized, but then you seemed happy with
>> pulling in. What's the latest?
> 
> My understanding is that the SMC standardization is being worked on
> but will take more time, and the KPTI current patchset will go to
> mainline before that.
> 
> Given that, I would expect arm64 maintainers to pick up this patch for
> ThunderX2, but I have not seen any comments so far.
> 
> Will/Marc, please let me know if you are planning to pick this patch
> into the KPTI tree.

We've pulled in mitigations for QCOM Falkor into our internal
development branch (for future releases, this isn't about existing
stuff), but we can't pull in mitigations for other vendors until they're
upstream, and this patch isn't in any tree we track yet.

Therefore, I encourage all of the vendors to get this upstream. Until
that's true, it will be difficult to continue to carry out of tree bits.

Jon.
