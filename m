From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 14 Oct 2014 08:21:49 -0700
Subject: [RFC PATCH] arm/arm64: KVM: Fix BE accesses to GICv2 EISR and
 ELRSR regs
In-Reply-To: <86k343geyx.fsf@arm.com>
References: <1411913066-3787-1-git-send-email-christoffer.dall@linaro.org>
 <86k343geyx.fsf@arm.com>
Message-ID: <CAA3XUr3Xv7nKnc-aBmwC+GKwcJA4FFUdcF=vpYJmWVzZqp+8Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 October 2014 02:47, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Sun, Sep 28 2014 at 03:04:26 PM, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> The EIRSR and ELRSR registers are 32-bit registers on GICv2, and we
>> store these as an array of two such registers on the vgic vcpu struct.
>> However, we access them as a single 64-bit value or as a bitmap pointer
>> in the generic vgic code, which breaks BE support.
>>
>> Instead, store them as u64 values on the vgic structure and do the
>> word-swapping in the assembly code, which already handles the byte order
>> for BE systems.
>>
>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>
> (still going through my email backlog, hence the delay).
>
> This looks like a valuable fix. Haven't had a chance to try it (no BE
> setup at hand) but maybe Victor can help reproducing this?.

I'll give it a spin.

Thanks,
Victor

> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>
>         M.
> --
> Jazz is not dead. It just smells funny.
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
