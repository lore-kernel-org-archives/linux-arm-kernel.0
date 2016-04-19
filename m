From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 19 Apr 2016 18:31:14 +0100
Subject: [PATCH 0/4] ARM: cpuidle: use const and __initconst for
 cpuidle_ops
In-Reply-To: <56F52063.6020002@linaro.org>
References: <1458657763-2561-1-git-send-email-jszhang@marvell.com>
 <56F52063.6020002@linaro.org>
Message-ID: <20160419173113.GB2939@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, Mar 25, 2016 at 12:26:27PM +0100, Daniel Lezcano wrote:
> On 03/22/2016 03:42 PM, Jisheng Zhang wrote:
> >These trivial patches are similar as Masahiro posted in[1]. The main
> >purpose is let cpuidle_ops structure be constified and replace
> >"__initdata" with "__initconst".
> >
> >[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/365826.html
> >
> >Jisheng Zhang (4):
> >   ARM: cpuidle: add const qualifier to cpuidle_ops member in structures
> >   ARM: cpuidle: constify return value of arm_cpuidle_get_ops()
> >   soc: qcom: spm: use const and __initconst for qcom_cpuidle_ops
> >   drivers: firmware: psci: use const and __initconst for
> >     psci_cpuidle_ops
> >
> >  arch/arm/include/asm/cpuidle.h | 2 +-
> >  arch/arm/kernel/cpuidle.c      | 6 +++---
> >  drivers/firmware/psci.c        | 2 +-
> >  drivers/soc/qcom/spm.c         | 2 +-
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> Sounds reasonable.

Are you taking them ? I could send the last one but it would
make more sense for them to be part of the same series, I will
check they do not conflict with patches queued for PSCI.

Thanks,
Lorenzo
