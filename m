From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 1 Sep 2016 15:39:47 +0100
Subject: [PATCH 3/5] arm64: KVM: vgic-v2: Add the GICV emulation
 infrastructure
In-Reply-To: <57C83B14.6020501@arm.com>
References: <1471610295-1456-1-git-send-email-marc.zyngier@arm.com>
 <1471610295-1456-4-git-send-email-marc.zyngier@arm.com>
 <20160901124629.GF10162@cbox> <57C83B14.6020501@arm.com>
Message-ID: <CAFEAcA-wRsex26zxK88d68Ec7u71focN3vrydZ+tHSa3AEEM4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 September 2016 at 15:28, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 01/09/16 13:46, Christoffer Dall wrote:
>> On Fri, Aug 19, 2016 at 01:38:13PM +0100, Marc Zyngier wrote:
>>> +                    __skip_instr(vcpu);
>>
>> does this interact in any amusing way with single-step guest debugging?
>
> Ouch. Good point. Actually, nothing that uses kvm_skip_instr() works for
> singlestep/watchpoint either (trapped sysreg, WFx, spurious traps,
> MMIO). I guess that's something we need to fix overall.

I vaguely remember having conversations about this way way back.
All the "advance one insn" stuff (including how the singlestep
state machine gets advanced) is probably on the wrong side of
"return to userspace".

thanks
-- PMM
