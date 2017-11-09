From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 9 Nov 2017 08:31:44 -0800
Subject: [PATCH 00/15] Add support for clang LTO
In-Reply-To: <20171109105439.GA27630@linaro.org>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103175156.f44o7kuxgzym3pbt@lakrids.cambridge.arm.com>
 <20171103180913.whp2tdjjvs32f4lz@lakrids.cambridge.arm.com>
 <CAKwvOd=5CCMAA9n7=ocPO5UYmCmkNs8GLYrxXVZVZEeYCyisyA@mail.gmail.com>
 <20171103192634.u25go4tu7lgzl6ja@lakrids.cambridge.arm.com>
 <20171103195647.GA137924@samitolvanen.mtv.corp.google.com>
 <20171104021303.bexhsxpg5tjerhu7@salmiak>
 <20171109105439.GA27630@linaro.org>
Message-ID: <20171109163144.GA10540@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 07:54:40PM +0900, AKASHI Takahiro wrote:
> Add -fno-jump-tables to ccflags-y of arch/arm64/kvm/hyp/Makefile.
> Without this option, clang generates a branch instruction (br x11)
> to an absolute (EL1) virtual address.

Yes, the behavior changed in LLVM r308050, which is part of the 5.0
release, but not in the latest Android clang prebuilts. Before this
change, no branches were generated in __init_stage2_translation.

Using -mllvm -jump-threading-threshold=0 also appears to solve this
problem.

Sami
