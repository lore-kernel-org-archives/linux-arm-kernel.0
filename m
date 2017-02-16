From: maxim.kuvyrkov@linaro.org (Maxim Kuvyrkov)
Date: Thu, 16 Feb 2017 16:23:20 +0300
Subject: [PATCH v7 00/20] ILP32 for ARM64
In-Reply-To: <CA+=Sn1=jBjg=JgM3aKitF--ZE7yg=su0yLo8Aybm1srORjXyMg@mail.gmail.com>
References: <1483961397-8599-1-git-send-email-ynorov@caviumnetworks.com>
 <CA+=Sn1=jBjg=JgM3aKitF--ZE7yg=su0yLo8Aybm1srORjXyMg@mail.gmail.com>
Message-ID: <E7C233D2-D747-4A4C-B49D-51C205364D7C@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Feb 12, 2017, at 4:07 PM, Andrew Pinski <apinski@cavium.com> wrote:
> 
> On Mon, Jan 9, 2017 at 3:29 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
>> This series enables aarch64 with ilp32 mode.
>> 
...
> 
> For folks concerned about performance, here is what we get for SPEC
> CPU 2006 on ThunderX 2 CN99xx.
> Positive means ILP32 is faster than LP64.  This core does not have
> AARCH32 so I can't compare that.
> Also my LP64 scores don't change with and without the patches.
> 
> Options:
> -Ofast -flto=32 -mcpu=native -fno-aggressive-loop-optimizations
> -funroll-loops -fprefetch-loop-arrays
> GCC 7.0.1 r245361 with ilp32 multi-arch patch applied.
> 4.10rc2 Plus ILP32 patches
> 
> SPEC CPU 2006 INT ILP32/LP64
> 400.perlbench           5.23%
> 401.bzip2                  7.83%
> 403.gcc                     6.22%
> 429.mcf                     14.25%
> 445.gobmk                 -1.33%
> 456.hmmer                 -0.61%
> 458.sjeng                    0.00%
> 462.libquantum            -7.38%
> 464.h264ref                 10.86%
> 471.omnetpp               13.53%
> 473.astar                      1.38%
> 483.xalancbmk             3.73%
> Score                            4.29%
> 
> Rate (32):
> 400.perlbench           6.10%
> 401.bzip2                  7.10%
> 403.gcc                     6.71%
> 429.mcf                     57.29%
> 445.gobmk                -0.87%
> 456.hmmer                -0.19%
> 458.sjeng                  0.22%
> 462.libquantum         0.00%
> 464.h264ref              11.19%
> 471.omnetpp            11.80%
> 473.astar                  -0.29%
> 483.xalancbmk         8.87%
> Score                       8.12%

These are good numbers and show that ILP32 has performance advantage over LP64.

SPEC CPU2006 is a user-land benchmark and spends almost no time in the kernel (by design).  Similar results for a kernel-focused benchmark would be highly interesting too, and kernel reviewers have asked for these a couple of times.  Do you plan to run kernel benchmarks on the hardware you have?

Thanks,

--
Maxim Kuvyrkov
www.linaro.org
