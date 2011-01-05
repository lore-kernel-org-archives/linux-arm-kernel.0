From: jgarzik@pobox.com (Jeff Garzik)
Date: Wed, 05 Jan 2011 13:15:24 -0500
Subject: [PATCH v2 0/3] add CNS3xxx AHCI support
In-Reply-To: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
Message-ID: <4D24B53C.4020009@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2011 12:43 AM, mkl0301 at gmail.com wrote:
> From: Mac Lin<mkl0301@gmail.com>
>
> v2:
>   - Switch ahci_platform to module device table matching to add SoC specific support
>
> v1: http://www.spinics.net/lists/arm-kernel/msg106236.html
>   - Add CNS3xxx SoC specific AHCI support
>
> This patchset is based on linux-2.6.37-rc2
>
> Mac Lin (3):
>        ahci_platform: rename to ahci_pltfm, but keep the original module name
>        ahci_pltfm: switch to module device table matching
>        ahci_platform: add support for CNS3xxx SoC devices
>
>   arch/arm/mach-cns3xxx/devices.c |    2 +-
>   drivers/ata/Kconfig             |   11 ++
>   drivers/ata/Makefile            |    5 +-
>   drivers/ata/ahci_cns3xxx.c      |   62 +++++++++++
>   drivers/ata/ahci_platform.c     |  197 ------------------------------------
>   drivers/ata/ahci_pltfm.c        |  212 +++++++++++++++++++++++++++++++++++++++
>   drivers/ata/ahci_pltfm.h        |   19 ++++
>   7 files changed, 309 insertions(+), 199 deletions(-)
>   create mode 100644 drivers/ata/ahci_cns3xxx.c
>   delete mode 100644 drivers/ata/ahci_platform.c
>   create mode 100644 drivers/ata/ahci_pltfm.c
>   create mode 100644 drivers/ata/ahci_pltfm.h

It is overkill to rename the entirety of ahci_platform just for one 
override function.

This sort of thing I would have expected to be added directly to 
ahci_platform.c.

	Jeff
