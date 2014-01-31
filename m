From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 Jan 2014 11:10:18 -0800
Subject: [PATCH 2/4] arm: qcom: Split Qualcomm support into legacy and
 multiplatform
In-Reply-To: <1391107002-21470-3-git-send-email-galak@codeaurora.org>
References: <1391107002-21470-1-git-send-email-galak@codeaurora.org>
 <1391107002-21470-3-git-send-email-galak@codeaurora.org>
Message-ID: <20140131191018.GA32295@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 12:36:40PM -0600, Kumar Gala wrote:
> Introduce a new mach-qcom that will support SoCs that intend to be
> multiplatform compatiable while keeping mach-msm to legacy SoC/board
> support that will not transition over to multiplatform.
> 
> As part of this, we move support for MSM8X60, MSM8960 and MSM8974 over
> to mach-qcom.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
>  MAINTAINERS                                        |  7 +++
>  arch/arm/Kconfig                                   |  7 +--
>  arch/arm/Makefile                                  |  1 +
>  arch/arm/boot/dts/Makefile                         |  6 +--
>  arch/arm/mach-msm/Kconfig                          | 45 +------------------
>  arch/arm/mach-msm/Makefile                         |  7 ---
>  arch/arm/mach-msm/hotplug.c                        | 51 ----------------------
>  arch/arm/mach-qcom/Kconfig                         | 34 +++++++++++++++
>  arch/arm/mach-qcom/Makefile                        |  5 +++
>  .../arm/{mach-msm/board-dt.c => mach-qcom/board.c} |  9 ++--
>  arch/arm/{mach-msm => mach-qcom}/scm-boot.c        |  0
>  arch/arm/{mach-msm => mach-qcom}/scm-boot.h        |  0
>  arch/arm/{mach-msm => mach-qcom}/scm.c             |  0
>  arch/arm/{mach-msm => mach-qcom}/scm.h             |  0
>  arch/arm/{mach-msm/platsmp.c => mach-qcom/smp.c}   | 11 ++++-
>  15 files changed, 70 insertions(+), 113 deletions(-)
>  delete mode 100644 arch/arm/mach-msm/hotplug.c
>  create mode 100644 arch/arm/mach-qcom/Kconfig
>  create mode 100644 arch/arm/mach-qcom/Makefile
>  rename arch/arm/{mach-msm/board-dt.c => mach-qcom/board.c} (71%)
>  rename arch/arm/{mach-msm => mach-qcom}/scm-boot.c (100%)
>  rename arch/arm/{mach-msm => mach-qcom}/scm-boot.h (100%)
>  rename arch/arm/{mach-msm => mach-qcom}/scm.c (100%)
>  rename arch/arm/{mach-msm => mach-qcom}/scm.h (100%)
>  rename arch/arm/{mach-msm/platsmp.c => mach-qcom/smp.c} (97%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a31a6e3..1817078 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1174,6 +1174,13 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  W:	http://www.arm.linux.org.uk/
>  S:	Maintained
>  
> +ARM/QUALCOMM SUPPORT
> +M:	David Brown <davidb@codeaurora.org>
> +M:	Kumar Gala <galak@codeaurora.org>
> +L:	linux-arm-msm at vger.kernel.org
> +S:	Maintained
> +F:	arch/arm/mach-qcom/

Git repo? If you want us to apply patches for us we can do that, but if
you prefer to run a tree and do pull requests then you should have an
URL to it here.


-Olof
