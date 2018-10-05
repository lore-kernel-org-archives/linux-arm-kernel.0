From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 5 Oct 2018 21:30:48 +0800
Subject: [GIT PULL 5/5] i.MX defconfig updates for 4.20
In-Reply-To: <CAK8P3a0PgysCBZSr8UqtTU6RGvo4WTzvRwhFfu4jYbCa_UUBnA@mail.gmail.com>
References: <20181001072003.16238-1-shawnguo@kernel.org>
 <20181001072003.16238-5-shawnguo@kernel.org>
 <CAK8P3a1wMGK1TrquSw_g0TdugsET2o3MRKnx+dV96ZgY5yDqgw@mail.gmail.com>
 <CAOMZO5D=6pBmN_qz+wEHuzSDn6_UrB05yFAT6BUrSYzi4hMHuQ@mail.gmail.com>
 <CAK8P3a0PgysCBZSr8UqtTU6RGvo4WTzvRwhFfu4jYbCa_UUBnA@mail.gmail.com>
Message-ID: <20181005133047.GC3587@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 05:38:11PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 3, 2018 at 4:15 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Arnd,
> >
> > On Mon, Oct 1, 2018 at 1:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > > Please add explanations for why we don't set those
> > > any more, and keep them separate from patches that
> > > just move options around.
> >
> > I did as suggested and sent a v2.
> 
> Looks good, thanks for respinning these.

Arnd,

I just updated the pull request with v2 patches from Fabio.  Please pull
again, thanks.

Shawn


The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.20

for you to fetch changes up to 35d3cbe84544da74e39e1cec01374092467e3119:

  ARM: imx_v6_v7_defconfig: Select CONFIG_TMPFS_POSIX_ACL (2018-10-05 21:19:22 +0800)

----------------------------------------------------------------
i.MX defconfig update for 4.20:
 - A series from Fabio to synchronize i.MX defconfig files with
   savedefconfig.
 - Enable CONFIG_TMPFS_POSIX_ACL to fix ACL applying failures seen with
   starting weston from sddm as unprivileged user.
 - Enable MC13783/MC13892 ADC driver by default.
 - Select CONFIG_ARM_CPUIDLE by default to support generic ARM cpuidle
   driver which is useful for i.MX platforms like i.MX7S/D.
 - Built in usbnet drivers to support NFS mount via USB Ethernet dongle
   on SoCs which have no native Ethernet controller, such as i.MX6 SLL
   and i.MX7 ULP.

----------------------------------------------------------------
Anson Huang (1):
      ARM: imx_v6_v7_defconfig: select CONFIG_ARM_CPUIDLE by default

Fabio Estevam (8):
      ARM: imx_v6_v7_defconfig: Select CONFIG_SENSORS_MC13783_ADC
      ARM: imx_v6_v7_defconfig: Re-sync defconfig
      ARM: imx_v6_v7_defconfig: Remove unneeded options
      ARM: mxs_defconfig: Re-sync defconfig
      ARM: mxs_defconfig: Remove unneeded options
      ARM: imx_v4_v5_defconfig: Re-sync defconfig
      ARM: imx_v4_v5_defconfig: Remove unneeded options
      ARM: imx_v6_v7_defconfig: Select CONFIG_TMPFS_POSIX_ACL

Leonard Crestez (1):
      ARM: imx_v6_v7_defconfig: Make usbnet drivers builtin for boot

Robin Gong (1):
      ARM: imx_v6_v7_defconfig: add CONFIG_FW_LOADER_USER_HELPER

 arch/arm/configs/imx_v4_v5_defconfig | 18 +++++++---------
 arch/arm/configs/imx_v6_v7_defconfig | 41 ++++++++++++++++++++----------------
 arch/arm/configs/mxs_defconfig       | 19 +++++++----------
 3 files changed, 39 insertions(+), 39 deletions(-)
