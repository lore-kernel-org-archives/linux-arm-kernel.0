From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 26 Nov 2014 14:58:16 +0000
Subject: [PATCH 2/7] KVM: arm: guest debug, define API headers
In-Reply-To: <20141126143122.GB3245@hawk.usersys.redhat.com>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-3-git-send-email-alex.bennee@linaro.org>
 <20141126143122.GB3245@hawk.usersys.redhat.com>
Message-ID: <87sih6knzr.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Andrew Jones <drjones@redhat.com> writes:

> On Tue, Nov 25, 2014 at 04:10:00PM +0000, Alex Benn?e wrote:
>> This commit defines the API headers for guest debugging. There are two
>> architecture specific debug structures:
<snip>
>> +/* Architecture related debug defines - upper 16 bits of
>> + * kvm_guest_debug->control
>> + */
>> +#define KVM_GUESTDBG_USE_SW_BP_SHIFT	16
>> +#define KVM_GUESTDBG_USE_SW_BP		(1 << KVM_GUESTDBG_USE_SW_BP_SHIFT)
>> +#define KVM_GUESTDBG_USE_HW_BP_SHIFT	17
>> +#define KVM_GUESTDBG_USE_HW_BP		(1 << KVM_GUESTDBG_USE_HW_BP_SHIFT)
>> +
>
> I see this are defined in arch/x86/include/uapi/asm/kvm.h,
> so you needed to reproduce them here, but shouldn't they
> be promoted to include/uapi/linux/kvm.h instead?

Well if we move them to common uapi we either restrict the $ARCH
specific options that don't have SW/HW BKPTS (would be weird but...) or
make them generic in the lower 16 bits (breaks API).

But in principle I have no objection if other don't.

-- 
Alex Benn?e
