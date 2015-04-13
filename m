From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Apr 2015 17:47:06 +0200
Subject: [PATCH v2 1/1] ata: ahci_xgene: Add AHCI Support for second
 generation of APM X-Gene SoC
In-Reply-To: <1428917560-9142-2-git-send-email-stripathi@apm.com>
References: <1428917560-9142-1-git-send-email-stripathi@apm.com>
 <1428917560-9142-2-git-send-email-stripathi@apm.com>
Message-ID: <13858039.DrYB9oMvMT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 April 2015 15:02:40 Suman Tripathi wrote:
> This patch enables full AHCI feature support for APM X-Gene SoC SATA host host
> controller. The following errata's are removed:
> 
> 1. 2a0bdff6b95 ("ahci-xgene: fix the dma state machine lockup for the
>                  IDENTIFY DEVICE PIO mode command")
> 2. 09c32aaa368 ("ahci_xgene: Fix the dma state machine lockup for the
>                  ATA_CMD_SMART PIO mode command")
> 3. 1540035da71 ("ahci_xgene: Implement the xgene_ahci_poll_reg_val to
>                  support PMP")
> 4. a3a84bc7c88 ("ahci_xgene: Implement the workaround to support PMP
>                  enumeration and discovery")
> 5. 1102407bb71 ("ahci_xgene: Fix the DMA state machine lockup for the
>                  ATA_CMD_PACKET PIO mode command")
> 6. 72f79f9e35b ("ahci_xgene: Removing NCQ support from the APM X-Gene SoC
>                  AHCI SATA Host Controller driver")
> 
> In addition, enable PMP support for APM X-Gene SoC and enable FBS support
> for second generation APM X-Gene SoC.
> 

Is this now close enough to AHCI that you can just use the normal AHCI
driver, or are there still too many remaining errata?

	Arnd
