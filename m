From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Dec 2016 14:13:12 +0000
Subject: ILP32 for ARM64 - testing with lmbench
In-Reply-To: <0adfca97-1624-8eac-8149-da447525ad65@huawei.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161028124659.GA24131@yury-N73SV>
 <cdf5cdf2-43af-6d7f-9e0c-72675fb83224@huawei.com>
 <266952F2-53F5-4D5E-83F0-6C8203092F67@linaro.org>
 <120041af-f4e9-5b6f-36dc-7d3535a1f01c@huawei.com>
 <0adfca97-1624-8eac-8149-da447525ad65@huawei.com>
Message-ID: <20161205141312.GC14429@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 06:16:09PM +0800, Zhangjian (Bamvor) wrote:
> Do you have suggestion of next move of upstreaming ILP32?

I mentioned the steps a few time before. I'm pasting them again here:

1. Complete the review of the Linux patches and ABI (no merge yet)
2. Review the corresponding glibc patches (no merge yet)
3. Ask (Linaro, Cavium) for toolchain + filesystem (pre-built and more
   than just busybox) to be able to reproduce the testing in ARM
4. More testing (LTP, trinity, performance regressions etc.)
5. Move the ILP32 PCS out of beta (based on the results from 4)
6. Check the market again to see if anyone still needs ILP32
7. Based on 6, decide whether to merge the kernel and glibc patches

What's not explicitly mentioned in step 4 is glibc testing. Point 5 is
ARM's responsibility (toolchain folk).

> There are already the test results of lmbench and specint. Do you they
> are ok or need more data to prove no regression?

I would need to reproduce the tests myself, see step 3.

> I have also noticed that there are ILP32 failures in glibc testsuite.
> Is it the only blocker for merge ILP32(in technology part)?

It's probably not the only blocker but I have to review the kernel
patches again to make sure. I'd also like to see whether the libc-alpha
community is ok with the glibc counterpart (but don't merge the patches
until the ABI is agreed on both sides).

On performance, I want to make sure there are no regressions on
AArch32/compat and AArch64/LP64.

-- 
Catalin
