From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Sep 2014 11:24:39 +0100
Subject: [PATCH v2] ARM/arm64: KVM: fix use of WnR bit in
 kvm_is_write_fault()
In-Reply-To: <20140911031236.GL2784@lvm>
References: <1410258429-17090-1-git-send-email-ard.biesheuvel@linaro.org>
 <540EDE63.6060904@arm.com> <20140911031236.GL2784@lvm>
Message-ID: <54117867.2010705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/14 04:12, Christoffer Dall wrote:
> On Tue, Sep 09, 2014 at 12:02:59PM +0100, Marc Zyngier wrote:
>> [resending, as ARM email server seems to be in some mood]
>>
>> On 09/09/14 11:27, Ard Biesheuvel wrote:
>>> The ISS encoding for an exception from a Data Abort has a WnR
>>> bit[6] that indicates whether the Data Abort was caused by a
>>> read or a write instruction. While there are several fields
>>> in the encoding that are only valid if the ISV bit[24] is set,
>>> WnR is not one of them, so we can read it unconditionally.
>>>
>>> Instead of fixing both implementations of kvm_is_write_fault()
>>> in place, reimplement it just once using kvm_vcpu_dabt_iswrite(),
>>> which already does the right thing with respect to the WnR bit.
>>> Also fix up the callers to pass 'vcpu'
>>>
>>> Acked-by: Laszlo Ersek <lersek@redhat.com>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> Because I like that kind of diffstat:
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Christoffer, if you too are happy with that, I'll queue it right away.
>>
> Extremely happy:
> 
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Added to kvmarm/queue.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
