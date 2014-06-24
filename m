From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 24 Jun 2014 08:19:16 -0400
Subject: [PATCH 0/2] Introduce ARM GICv2m MSI(-X) support
In-Reply-To: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <20140624121916.GJ10202@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 07:32:58PM -0500, suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> This patch set introduces support for MSI(-X) in GICv2m specification,
> which is implemented in some variation of GIC400.
> 
> This depends on and has been tested with the V7 of "Add support for PCI in AArch64"
> (https://lkml.org/lkml/2014/3/14/320).
> 
> Suravee Suthikulpanit (2):
>   arm/gic: Add binding probe for GIC400
>   arm/gic: Add supports for GICv2m MSI(-X)
> 
>  Documentation/devicetree/bindings/arm/gic.txt |  18 +-
>  drivers/irqchip/Kconfig                       |   6 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/gic-msi-v2m.c                 | 249 ++++++++++++++++++++++++++
>  drivers/irqchip/gic-msi-v2m.h                 |  20 +++
>  drivers/irqchip/irq-gic.c                     |  23 ++-
>  6 files changed, 313 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/irqchip/gic-msi-v2m.c
>  create mode 100644 drivers/irqchip/gic-msi-v2m.h

Please don't forget to run get_maintainers.pl before you send.  I almost
missed this series. :)

thx,

Jason.
