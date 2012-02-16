From: robherring2@gmail.com (Rob Herring)
Date: Thu, 16 Feb 2012 11:50:10 -0600
Subject: [GIT PULL] imx irq_domain migration
In-Reply-To: <20120216154941.GB11758@r65073-Latitude-D630>
References: <20120216154941.GB11758@r65073-Latitude-D630>
Message-ID: <4F3D41D2.5090203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On 02/16/2012 09:49 AM, Shawn Guo wrote:
> Hi Rob,
> 
> Please pull imx irq_domain support below. It's based on Grant's
> irqdomain/next today with your generic-chip series applied on top
> of it.

You're asking me to pull changes on top of a branch that I don't even
have as you've rebased my changes. While it would work I don't think
this is the right flow. Plus there is not really any reason for iMX
changes to go thru me.

Either Grant needs to stabilize his branch so you and I can send him
pull requests or he can pull in our changes and rebase them as he
rebases. I already asked him to do just that with my 1 patch others are
dependent on.

Rob

> Regards,
> Shawn
> 
> The following changes since commit 53d7d9ee4c6611b13d9e7c77c02d5e9deed95da5:
> 
>   gpio: pl061: enable interrupts with DT style binding (2012-02-16 07:07:16 -0800)
> 
> are available in the git repository at:
>   http://git.linaro.org/git/people/shawnguo/linux-2.6.git imx/irqdomain
> 
> Shawn Guo (6):
>       ARM: imx5: adopt generic_chip irq_domain support for tzic
>       ARM: imx: eliminate macro IMX_GPIO_TO_IRQ()
>       ARM: imx: eliminate macro IOMUX_TO_IRQ()
>       ARM: imx: eliminate macro IRQ_GPIOx()
>       gpio/mxc: adopt irq_domain for gpio interrupt support
>       ARM: imx: remove macro MXC_GPIO_IRQ_START
> 
>  arch/arm/boot/dts/imx51.dtsi                 |    6 +++
>  arch/arm/boot/dts/imx53.dtsi                 |    6 +++
>  arch/arm/mach-imx/clock-mx51-mx53.c          |   47 +++++++++++++++++++--
>  arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    3 +-
>  arch/arm/mach-imx/eukrea_mbimx51-baseboard.c |    3 +-
>  arch/arm/mach-imx/imx51-dt.c                 |   30 ++++++-------
>  arch/arm/mach-imx/imx53-dt.c                 |   30 ++++++-------
>  arch/arm/mach-imx/mach-apf9328.c             |    6 ++-
>  arch/arm/mach-imx/mach-armadillo5x0.c        |   12 ++++--
>  arch/arm/mach-imx/mach-cpuimx27.c            |   12 ++++--
>  arch/arm/mach-imx/mach-cpuimx35.c            |    3 +-
>  arch/arm/mach-imx/mach-cpuimx51.c            |   12 ++++--
>  arch/arm/mach-imx/mach-cpuimx51sd.c          |    6 ++-
>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c  |    8 ++--
>  arch/arm/mach-imx/mach-imx6q.c               |   14 ------
>  arch/arm/mach-imx/mach-kzm_arm11_01.c        |   20 +++++++--
>  arch/arm/mach-imx/mach-mx21ads.c             |    5 +-
>  arch/arm/mach-imx/mach-mx27_3ds.c            |    3 +-
>  arch/arm/mach-imx/mach-mx27ads.c             |   12 +++---
>  arch/arm/mach-imx/mach-mx31_3ds.c            |   13 +++---
>  arch/arm/mach-imx/mach-mx31ads.c             |   14 ++++--
>  arch/arm/mach-imx/mach-mx31lilly.c           |   10 +++-
>  arch/arm/mach-imx/mach-mx31lite.c            |   10 +++-
>  arch/arm/mach-imx/mach-mx31moboard.c         |    4 +-
>  arch/arm/mach-imx/mach-mx53_ard.c            |    5 +-
>  arch/arm/mach-imx/mach-mxt_td60.c            |    6 +-
>  arch/arm/mach-imx/mach-pca100.c              |    4 +-
>  arch/arm/mach-imx/mach-pcm037.c              |   18 +++++---
>  arch/arm/mach-imx/mach-pcm038.c              |    4 +-
>  arch/arm/mach-imx/mach-qong.c                |    9 ++--
>  arch/arm/mach-imx/mach-scb9328.c             |    6 ++-
>  arch/arm/mach-imx/mach-vpr200.c              |    3 +-
>  arch/arm/mach-imx/mm-imx5.c                  |    6 +-
>  arch/arm/mach-imx/mx31lilly-db.c             |    5 +-
>  arch/arm/mach-imx/mx31lite-db.c              |    5 +-
>  arch/arm/mach-imx/mx51_efika.c               |    3 +-
>  arch/arm/mach-imx/pcm970-baseboard.c         |   13 +++---
>  arch/arm/plat-mxc/include/mach/common.h      |    3 +-
>  arch/arm/plat-mxc/include/mach/hardware.h    |    2 -
>  arch/arm/plat-mxc/include/mach/iomux-mx3.h   |    3 -
>  arch/arm/plat-mxc/include/mach/iomux-v1.h    |   12 +++---
>  arch/arm/plat-mxc/include/mach/irqs.h        |    2 -
>  arch/arm/plat-mxc/tzic.c                     |   32 +++++++-------
>  drivers/gpio/gpio-mxc.c                      |   59 ++++++++++---------------
>  44 files changed, 279 insertions(+), 210 deletions(-)
