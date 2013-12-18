From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Dec 2013 17:13:52 +0100
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <52B1B0E0.6030104@codeaurora.org>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131217122519.GI32118@arm.com>
 <CAKv+Gu824T1vx=O9taLaDSB-HE3OLSpwnpWMn4z+x8YdmLuM+A@mail.gmail.com>
 <20131218100321.GC4360@n2100.arm.linux.org.uk>
 <CAKv+Gu87zHkxKKyH0-jEcBKcdbWTahN2bgWRDpPog5bds_ukYg@mail.gmail.com>
 <20131218105541.GE4360@n2100.arm.linux.org.uk>
 <CAKv+Gu_M56pXD8N6rANkYWLxXk=iLe3qpwt7zoBo_h6YuBgHTA@mail.gmail.com>
 <20131218112713.GA28112@arm.com>
 <20131218114211.GF4360@n2100.arm.linux.org.uk>
 <20131218120306.GC28112@arm.com> <52B1B0E0.6030104@codeaurora.org>
Message-ID: <CAKv+Gu_zCQkF2hYf_kWiD8mt_S3Due=Wz1SOqw_hBibSkgWtOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 December 2013 15:27, Christopher Covington <cov@codeaurora.org> wrote:
>
> I do not think that Russell is the source of the confusion. Ard wrote, "The
> idea is that a binary built for ARM will have access to the extended
> instructions which ARM64 offers to ARM32 binaries running in 32 bit
> compatibility mode (such as AES, SHAx etc)." I think s/ARM64/ARMv8/ is
> necessary to make the statement correct, and hopefully less confusing.
>

My apologies for adding to the confusion (or creating it in the first place).

However, the bottom line is that, as the 32 bit and 64 bit kernels are
both able to support userland processes running in the execution state
that has retroactively been dubbed 'AArch32', they should both honor
the same contract with AArch32 userland on how to discover CPU
capabilities at runtime. I do understand Russell's reservations about
allocating 6 of the remaining 10 hwcaps bits, and I am open to
suggestions on a better approach. But it is essential that this be
sorted between ARM and arm64 so that AArch32 userland does not need to
be aware of the flavor of kernel it is running under. (Tricks like
trapping SIGILL to infer hwcaps are suboptimal and likely to create
problems going forward). Also, the suggestion that those hwcaps bits
are essentially 'wasted' for ARM32 does not make sense considering
that 32-bit only ARMv8-R CPUs (which may or may not support some or
all of the Crypto Extensions) will need to be supported by the ARM32
kernel as well.

Regards,
Ard.
