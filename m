From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Dec 2014 12:31:38 +0100
Subject: [PATCH 2/4] PCI: iproc: Add Broadcom iProc PCIe driver
In-Reply-To: <1418169871-19232-3-git-send-email-rjui@broadcom.com>
References: <1418169871-19232-3-git-send-email-rjui@broadcom.com>
Message-ID: <9707535.Y78sV0TgX4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 December 2014 16:04:29 Ray Jui wrote:
> Add initial version of the Broadcom iProc PCIe driver. This driver
> has been tested on NSP and Cygnus and is expected to work on all iProc
> family of SoCs that deploys the same PCIe host controller
> 
> The driver also supports MSI
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

The driver looks suspiciously like the one that Hauke already submitted a
while ago for bcm53xx. Please come up with a merged driver that works for
both.

Are you sure that iProc isn't based on the BCMA bus infrastructure after
all? Even the physical address of your PCI host falls into the address
range that is used for the internal BCMA bus on the other chips!

	Arnd
