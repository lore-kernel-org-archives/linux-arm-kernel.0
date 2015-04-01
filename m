From: tj@kernel.org (Tejun Heo)
Date: Wed, 1 Apr 2015 12:13:36 -0400
Subject: [PATCH v1] ata: ahci_xgene: Add AHCI Support for second
 generation of APM X-Gene SoC
In-Reply-To: <1427899682-10912-2-git-send-email-stripathi@apm.com>
References: <1427899682-10912-1-git-send-email-stripathi@apm.com>
 <1427899682-10912-2-git-send-email-stripathi@apm.com>
Message-ID: <20150401161336.GS9974@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 08:18:02PM +0530, Suman Tripathi wrote:
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
> In addition, enable PMP support for second generation APM X-Gene SoC.
> 
> Signed-off-by : Suman Tripathi <stripathi@apm.com>

Applied to libata/for-4.1 w/ minor edit.

> +	if (xgene_ahci_version1()) {
> +		/*
> +		 * Override the callbacks due to
> +		 * XGENE1 ERRATA's.
> +		 */

The column limit is 80 (more like 75), not 40.  I collapsed the above
into one line.

Thanks.

-- 
tejun
