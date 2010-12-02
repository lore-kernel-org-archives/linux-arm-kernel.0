From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Thu, 2 Dec 2010 19:53:30 +0530
Subject: [PATCH v7] OMAP2+: PM: omap device: API's for handling
	mstandby mode
In-Reply-To: <1291298392-28729-1-git-send-email-manjugk@ti.com>
References: <1291298392-28729-1-git-send-email-manjugk@ti.com>
Message-ID: <20101202142329.GA21529@GLPP-machine>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* G, Manjunath Kondaiah <manjugk@ti.com> [2010-12-02 19:29:52 +0530]:

> Certain errata in OMAP2+ processors will require forcing
> master standby to "no standby" mode before completing on going
> operation. Without this, the results will be unpredictable.
> 
> Since current implementation of PM run time framework does not support
> changing sysconfig settings during middle of the on going operation,
> these API's will support the same. One API will force the device's
> sysconfig mstandby mode settings to "no standby" and other API will
> release "no standby" mode and sets it to "smart standby" or "no
> standby? depending on HWMOD_SWSUP_MSTANDBY value.
> 
> The hwmod API "omap_hwmod_set_master_standbymode" will use
> no_stdby_cnt(introduced in omap_hwmod structure) for controlling
> access to sysconfig register settings in case of overlapping
> request/release API's are called. It also disables interrupts during
> syconfig register access.
> 
> These API's should be used by device drivers only incase of
> erratum applicable to their modules if there is no other methods
> to resolve.
> 
> These API's are required for multiple DMA errata which require
> putting DMA controller in no mstandby mode before stopping dma.
> 
> The applicable errata:
> 1. Erratum ID: i557(Applicable for omap36xx all ES versions)
> The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared
> through config port while in Standby.
> 
> 2. Erratum ID: i541
> sDMA FIFO draining does not finish. Applicable to all omap2+ except
> omap4.
> 
> 3. Erratum ID:i88
> The sDMA to be put in no mstandby mode before disabling the channel
> after completing the data transfer operation.
> Applicable only for OMAP3430 ES1.0
> 
> Also fixes typo HWMOD_SWSUP_MSTDBY to HWMOD_SWSUP_MSTANDBY in
> omap_hwmod.h
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: linux-arm-kernel at lists.infradead.org

Pls ignore this patch. I have resent this patch as:
[PATCH v7 RESEND] OMAP2+: PM: omap device: API's for handling mstandby
mode

Sorry for noise.

-Manjunath

[...]
