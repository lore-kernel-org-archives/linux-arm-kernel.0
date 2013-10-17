From: anup@brainfault.org (Anup Patel)
Date: Thu, 17 Oct 2013 16:43:59 +0530
Subject: [RFC PATCH 2/5] ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and
 SYSTEM_RESET to user space
In-Reply-To: <525FA1D3.8060001@arm.com>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
 <1381942954-22388-3-git-send-email-anup.patel@linaro.org>
 <525FA1D3.8060001@arm.com>
Message-ID: <CAAhSdy2yNJrP88rjJcHSRoBKQNK26i+BtYXmo_EAm3ac3256ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 2:07 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 16/10/13 18:02, Anup Patel wrote:
>> The PSCI SYSTEM_OFF and SYSTEM_RESET functions are VM or Guest level
>> functions hence cannot be emulated by the in-kernel PSCI emulation code.
>
> Why can't we implement system-wide functionality in the kernel? I fail
> to see the issue here.
>
>> To tackle this, we forward PSCI SYSTEM_OFF and SYSTEM_RESET function
>> calls from Guest to user space (i.e. QEMU or KVMTOOL) via KVM run
>> structure with KVM_EXIT_PSCI exit reason.
>
> I'm really not keen on this approach. Having part of the PSCI
> implementation offloaded to userspace means we don't have a complete
> implementation in KVM anymore, and we end-up duplicating functionality
> all over the place.
>
> Also, OFF and RESET are not PSCI specific concepts, and could be
> implemented in various ways. I'm more inclined to return a
> *standardized* exit code that the various platforms can interpret.

Please refer to the documentation of SYSTEM_OFF and SYSTEM_RESET
functions in the PSCI specifications.
(More preciesly section 5.10 and 5.11 of
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0022b/index.html)

--
Anup

>
>         M.
> --
> Jazz is not dead. It just smells funny...
>
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
