From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 6 Jul 2018 10:23:13 +0100
Subject: [RFC PATCH 00/16] KVM: arm64: Initial support for SVE guests
In-Reply-To: <87d0w090vv.fsf@linaro.org>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <87h8lc93jc.fsf@linaro.org> <20180706090534.GD26019@e103592.cambridge.arm.com>
 <87d0w090vv.fsf@linaro.org>
Message-ID: <CAFEAcA8NQFvHzgCvCQBmq7us4PvqSFK2Le=pMiz5dE4D3WGXdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 July 2018 at 10:20, Alex Benn?e <alex.bennee@linaro.org> wrote:
> For the most part in QEMU with KVM we just treat the list of registers
> we get from the OS as an opaque blob of things we save to memory and
> pass back.

This is specifically not the case for the SVE registers -- we
will need extra code to handle them. (The current code only
allows for the possibility of 64-bit registers, so if we'd
allowed the kernel to hand it the larger SVE registers it would
just have fallen over. This is why QEMU needs to specifically
enable SVE via the VCPU_INIT call.)

thanks
-- PMM
