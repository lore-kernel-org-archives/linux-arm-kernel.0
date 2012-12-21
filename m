From: rtivy@ti.com (Tivy, Robert)
Date: Fri, 21 Dec 2012 22:09:13 +0000
Subject: [PATCH v4 0/9] ARM: davinci: remoteproc support
In-Reply-To: <1355967254-16726-1-git-send-email-rtivy@ti.com>
References: <1355967254-16726-1-git-send-email-rtivy@ti.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C14311FCECD@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have uploaded the commits corresponding to this patch set to a public repo on GitHub, forked from Linus' v3.7-rc2 tag on his "linux" repo.  These commits are on a branch named "davinci-remoteproc", here is the URL: https://github.com/RTivy/linux/tree/davinci-remoteproc

This should make for an easier review of the changes.

Regards,

- Rob

> -----Original Message-----
> From: Tivy, Robert
> Sent: Wednesday, December 19, 2012 5:34 PM
> To: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
> kernel at lists.infradead.org; Nori, Sekhar; ohad at wizery.com;
> rob at landley.net; linux-doc at vger.kernel.org; Ring, Chris; Grosen, Mark
> Cc: Tivy, Robert
> Subject: [PATCH v4 0/9] ARM: davinci: remoteproc support
> 
> This patch series adds remoteproc support for OMAP-L138, along with
> needed
> supporting mach-davinci infrastructure.
> 
> Some notes for reviewers...
> 
> DOCUMENTATION maintainers: patch 6/9 in this series contains a change
> to
> kernel-parameters.txt that adds a description for a new kernel command-
> line
> parameter, along with the code that defines the new kernel command-line
> parameter.  You are, of course, free to look at the whole series, but
> only
> patch 6/9 is of particular interest.
> 
> Robert Tivy (9):
>   ARM: davinci: da850 board: change pr_warning() to pr_warn()
>   ARM: davinci: devices-da8xx.c: change pr_warning() to pr_warn()
>   ARM: davinci: psc.c: change pr_warning() to pr_warn()
>   ARM: davinci: da850: added pll0_sysclk1 for DSP usage
>   New reset assert/deassert functionality/API provided for Davinci DSP
>   Remoteproc platform device creation data/code for DA8xx devices
>   Added .reserve function and rproc platform registration
>   Added dsp clock definition, keyed to "davinci-rproc.0"
>   Remoteproc driver support for OMAP-L138 DSP
> 
>  Documentation/kernel-parameters.txt            |    7 +
>  arch/arm/mach-davinci/board-da850-evm.c        |  110 ++++-----
>  arch/arm/mach-davinci/board-omapl138-hawk.c    |   38 +--
>  arch/arm/mach-davinci/clock.c                  |   31 +++
>  arch/arm/mach-davinci/clock.h                  |    3 +
>  arch/arm/mach-davinci/da850.c                  |   18 ++
>  arch/arm/mach-davinci/devices-da8xx.c          |   93 +++++++-
>  arch/arm/mach-davinci/include/mach/clock.h     |    3 +
>  arch/arm/mach-davinci/include/mach/da8xx.h     |    6 +
>  arch/arm/mach-davinci/include/mach/psc.h       |    3 +
>  arch/arm/mach-davinci/psc.c                    |   32 ++-
>  drivers/remoteproc/Kconfig                     |   20 ++
>  drivers/remoteproc/Makefile                    |    1 +
>  drivers/remoteproc/davinci_remoteproc.c        |  303
> ++++++++++++++++++++++++
>  include/linux/platform_data/da8xx-remoteproc.h |   33 +++
>  15 files changed, 617 insertions(+), 84 deletions(-)
>  create mode 100644 drivers/remoteproc/davinci_remoteproc.c
>  create mode 100644 include/linux/platform_data/da8xx-remoteproc.h
> 
> --
> 1.7.9.4
