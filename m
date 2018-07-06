From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 06 Jul 2018 11:11:39 +0100
Subject: [RFC PATCH 00/16] KVM: arm64: Initial support for SVE guests
In-Reply-To: <CAFEAcA8NQFvHzgCvCQBmq7us4PvqSFK2Le=pMiz5dE4D3WGXdQ@mail.gmail.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <87h8lc93jc.fsf@linaro.org>
 <20180706090534.GD26019@e103592.cambridge.arm.com>
 <87d0w090vv.fsf@linaro.org>
 <CAFEAcA8NQFvHzgCvCQBmq7us4PvqSFK2Le=pMiz5dE4D3WGXdQ@mail.gmail.com>
Message-ID: <87601s8yhw.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Peter Maydell <peter.maydell@linaro.org> writes:

> On 6 July 2018 at 10:20, Alex Benn?e <alex.bennee@linaro.org> wrote:
>> For the most part in QEMU with KVM we just treat the list of registers
>> we get from the OS as an opaque blob of things we save to memory and
>> pass back.
>
> This is specifically not the case for the SVE registers -- we
> will need extra code to handle them. (The current code only
> allows for the possibility of 64-bit registers, so if we'd
> allowed the kernel to hand it the larger SVE registers it would
> just have fallen over. This is why QEMU needs to specifically
> enable SVE via the VCPU_INIT call.)

Ahh right. So currently both the KVM_GET_REG_LIST and the core registers
use KVM_GET/SET_ONE_REG which certainly won't do the trick. So I guess
we need another IOCTL (or to enhance the current one) and a KVM
capability bit as well?

>
> thanks
> -- PMM


--
Alex Benn?e
