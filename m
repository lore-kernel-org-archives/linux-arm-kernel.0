From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 Jan 2015 20:16:11 +0100
Subject: [PATCHv2 0/7] arm64/kvm: common ESR_ELx definitions and decoding
In-Reply-To: <20150115151202.GC2329@e104818-lin.cambridge.arm.com>
References: <1421081120-7694-1-git-send-email-mark.rutland@arm.com>
 <20150112194440.GB26222@cbox> <20150115124251.GE16217@leverpostej>
 <CAMJs5B-Ybrf7GQ+u70Z8bDCh7uHTwwCQa6Q3dh2BoL5qaUtOUA@mail.gmail.com>
 <20150115151202.GC2329@e104818-lin.cambridge.arm.com>
Message-ID: <CAMJs5B-Kp1Qs4RcySHUKBD=nb04vjfcxm=Sa5m1GECwFEU8W=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 4:12 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Jan 15, 2015 at 01:08:00PM +0000, Christoffer Dall wrote:
>> On Thu, Jan 15, 2015 at 1:42 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Mon, Jan 12, 2015 at 07:44:40PM +0000, Christoffer Dall wrote:
>> >> On Mon, Jan 12, 2015 at 04:45:13PM +0000, Mark Rutland wrote:
>> >> > Currently we have two sets of macros used for ESR_ELx handling, one used
>> >> > by core arm64 code and the other used by KVM. These differ slightly in
>> >> > naming convention and style of definition.
>> >> >
>> >> > This patch series introduces and migrates all users to a common set of
>> >> > macros for ESR_ELx handling, preventing further drift.
>> >> >
>> >> > Additionally this series adds exception class decoding when reporting
>> >> > exceptions, saving deveopers from having to perform tedious mental
>> >> > arithmetic to figure out what the likely cause of an unexpected
>> >> > exception was.
>> >> >
>> >> > Since v1 [1]:
>> >> > * Reorder patches to maintain KVM bisectability.
>> >> > * Fix bad definitions (ESR_ELx_SAS and ESR_ELx_FSC_PERM).
>> >> > * Introcuce ESR_ELx_SAS_SHIFT and undo bad rework of
>> >> >   kvm_vcpu_dabt_get_as.
>> >> > * Make "Unallocated EC" comments consistent in ESR_ELx_EC_* definition
>> >> >   list.
>> >> >
>> >> For the series:
>> >>
>> >> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>> >>
>> >> I also tested this with KVM on APM XGene and Juno with UEFI+Linux as a
>> >> guest.
>> >
>> > Thanks, Christoffer. It's much appreciated.
>> >
>> > Catalin, Christoffer, do you have a preferred path for merging this?
>> > Should this go through the arm64 or KVM tree as a whole?
>>
>> Would make sense to merge it as whole.
>
> Indeed.
>
>> I don't care which path, let's
>> just minimize conflicts. For big things, I have GICv3, dirty page
>> logging, and Marc's fixes, but they shouldn't touch much of the same
>> code (maybe the same files, but I don't think the same lines), so it's
>> up to you Catalin?
>
> I don't have a strong preference but since Christoffer doesn't have one
> either, I'll merge them via the arm64 tree (there are 4 arm64 patches vs
> 3 kvm ones ;)).
>
great, thanks!
