From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Apr 2017 12:33:35 +0100
Subject: [PATCH v7 resend 00/20] ILP32 for ARM64
In-Reply-To: <20170410194740.GA28503@yury-N73SV>
References: <1488395968-14313-1-git-send-email-ynorov@caviumnetworks.com>
 <20170410194740.GA28503@yury-N73SV>
Message-ID: <20170411113334.GA27857@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 11:47:40PM +0400, Yury Norov wrote:
> According to latest plans figured out on Linaro Connect, ILP32 should
> be taken in 4.12 merge window.

Sorry, I wasn't present at Linaro Connect, so definitely not involved in
such decision.

BTW, it would be nice to have Arnd's ack on patch 2 (32-bit ABI:
introduce ARCH_32BIT_OFF_T config option).

> The window will be opened in less than a month, so I'd like to remind
> it to you, and ask if you have any questions/requests related to
> ILP32. Is it still realistic idea to take patches in 4.12? 

4.12 is not realistic and I wouldn't commit to a specific kernel
version. Given the intrusiveness, such patches should sit in -next for
at least 3-4 weeks (i.e. merged in the arch tree around -rc3).

Anyway, I don't think the plan has changed since last time I stated it:

https://lkml.org/lkml/2016/12/5/333

I haven't got the chance to test these patches yet, run benchmarks (step
4). Also, the latest benchmarks I've seen were mostly for user space
while I'm more concerned with the user-kernel interface
(https://marc.info/?l=linux-arm-kernel&m=148690490713310&w=2). Is there
an up to date pre-built toolchain and a filesystem for ILP32?

On the glibc testing side, have the regressions been identified/fixed?

-- 
Catalin
