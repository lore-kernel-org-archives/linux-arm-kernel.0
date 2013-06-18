From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 15:07:40 +0200
Subject: [PATCH v11 0/8] ] DMA Engine support for AM33XX
In-Reply-To: <1371537499-12970-1-git-send-email-joelagnel@ti.com>
References: <1371537499-12970-1-git-send-email-joelagnel@ti.com>
Message-ID: <201306181507.40849.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Joel A Fernandes wrote:
> 
> This series is a repost of Matt Porter's EDMA patches for AM33XX EDMA support
> with changes for few pending review comments on v9 series.
> 
> Currently this is required for AM33XX (Beaglebone or EVM) to access MMC
> and be able mount to rootfs and boot till command prompt over MMC.
> Unless there are other pending review comments, I hope this series can
> make it into 3.11 merge window, the dependent series has been posted at [1]
> and completed review.
> 
> Tested EDMA on AM1808 EVM and AM33XX Beaglebone with MMC.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

The binding looks good now.

My usual comment about the fact that we shouldn't use a filter function in
.xlate() applies here, but that is more about the missing interface of
the dmaengine layer than the particular driver.

	Arnd
