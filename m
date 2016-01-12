From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Jan 2016 17:59:58 +0000
Subject: [PATCH v3 1/2] PCI: generic: Refactor code to enable reuse by
 other drivers.
In-Reply-To: <1452297553-19911-2-git-send-email-ddaney.cavm@gmail.com>
References: <1452297553-19911-1-git-send-email-ddaney.cavm@gmail.com>
 <1452297553-19911-2-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160112175958.GA22186@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 03:59:12PM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> No change in functionality.
> 
> Move structure definitions into a separate header file.  Move common
> code to new file with Kconfig machinery to build it.  Split probe
> function in to two parts:
> 
>    - a small driver specific probe function (gen_pci_probe)
> 
>    - a common probe that can be used by other drivers
>      (pci_host_common_probe)
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/pci/host/Kconfig            |   4 +
>  drivers/pci/host/Makefile           |   1 +
>  drivers/pci/host/pci-host-common.c  | 194 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pci-host-common.h  |  56 +++++++++++
>  drivers/pci/host/pci-host-generic.c | 190 +----------------------------------
>  6 files changed, 260 insertions(+), 186 deletions(-)
>  create mode 100644 drivers/pci/host/pci-host-common.c
>  create mode 100644 drivers/pci/host/pci-host-common.h

Looks fine to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
