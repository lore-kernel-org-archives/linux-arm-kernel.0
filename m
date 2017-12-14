From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Dec 2017 12:17:19 +0000
Subject: [PATCH v2 11/36] KVM: arm64: Introduce VHE-specific kvm_vcpu_run
In-Reply-To: <20171214121223.GS910@cbox>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
 <20171207170630.592-12-christoffer.dall@linaro.org>
 <863fc9b1-c188-a212-4c72-55cbe1cdbf14@arm.com> <20171214121223.GS910@cbox>
Message-ID: <575926f2-45ef-4f69-bb41-6eaa113aca41@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/12/17 12:12, Christoffer Dall wrote:
> On Mon, Dec 11, 2017 at 09:53:13AM +0000, Marc Zyngier wrote:
>> On 07/12/17 17:06, Christoffer Dall wrote:
>>> So far this is just a copy of the legacy non-VHE switch function, where
>>> we only change the existing calls to has_vhe() in both the original and
>>> new functions.
>>
>> I'm not sure I correctly parse the above. Do you want to say that you
>> use has_vhe() to select the right world switch back-end? Or did you mean
>> to drop some of the has_vhe() calls in the non-VHE case?
>>
> 
> That's a leftover from a previous patch version.  How about the
> following instead?
> 
>   So far this is just a copy of the legacy non-VHE switch function, but we
>   will start reworking these functions in separate directions to work on
>   VHE and non-VHE in the most optimal way in later patches.

This makes more sense.With that change:

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
