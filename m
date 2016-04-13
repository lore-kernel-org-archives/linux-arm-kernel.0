From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 11:10:02 -0700
Subject: [GIT PULL] Qualcomm Driver Updates for v4.7
In-Reply-To: <1459540776-7056-1-git-send-email-andy.gross@linaro.org>
References: <1459540776-7056-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20160413181002.GH19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 02:59:36PM -0500, Andy Gross wrote:
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.7

Are you sure? Last branch was all drivers/soc contents, which _I_ merged
into next/drivers. This is all arch/arm contents, which _I_ would merge
into next/soc. :)

> for you to fetch changes up to d24a7dab5b8fa6717d7a3917a634b561dcee312f:
> 
>   ARM: qcom: Drop ARCH_MSM* configs (2016-03-31 17:37:31 -0500)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v4.7
> 
> * Drop ARCH_MSM* configs and fixup clocksource support
> 
> ----------------------------------------------------------------
> Stephen Boyd (2):
>       ARM: qcom: Make an option for qcom 'a-family' platforms
>       ARM: qcom: Drop ARCH_MSM* configs

THis does:

-config ARCH_MSM8974
-       bool "Enable support for MSM8974"
-       select HAVE_ARM_ARCH_TIMER


... and I don't see the HAVE_ARCH_ARM_TIMER added anywhere. So it looks
like you might need to pick it for ARCH_QCOM_A_FAMILY now?


-Olof
