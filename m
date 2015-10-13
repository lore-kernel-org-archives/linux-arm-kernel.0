From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 13 Oct 2015 10:58:26 -0700
Subject: [PATCH 7/8] PCI: iproc: Add outbound mapping support
In-Reply-To: <1442363962-29805-8-git-send-email-rjui@broadcom.com>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
 <1442363962-29805-8-git-send-email-rjui@broadcom.com>
Message-ID: <CAMAWPa_Hsuv+skzt3S6e9X_kWY=2JXAScbVEVOVTGmn81_bcFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 5:39 PM, Ray Jui <rjui@broadcom.com> wrote:
> Certain iProc SoCs require the PCIe outbound mapping to be configured in
> SW. This patch adds support for those chips
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>

kernelci.org bot found a new build failure in linux-next[1] and it was
bisected down to this patch, which landed in linux-next in the form of
90e4032eeaf2 PCI: iproc: Add outbound mapping support.

The build fails on arm[1] with multi_v7_defconfig and CONFIG_ARM_LPAE=y with:

drivers/built-in.o: In function `iproc_pcie_setup':
:(.text+0x6d874): undefined reference to `__aeabi_uldivmod'

Kevin

[1] http://storage.kernelci.org/next/next-20151013/arm-multi_v7_defconfig+CONFIG_ARM_LPAE=y/build.log
