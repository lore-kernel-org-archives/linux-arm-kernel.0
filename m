From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jun 2010 22:10:05 +0100
Subject: [GIT PULL] Some Cavium CNS3xxx updates for 2.6.36
In-Reply-To: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
References: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
Message-ID: <20100601211005.GA9111@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 01, 2010 at 08:54:09PM +0400, Anton Vorontsov wrote:
> Hello Russell,
> 
> As Linus' merge window is now officially closed, I believe
> we can start requesting pulls for -next?

Yup.

> For convenience I'm posting the patches again + defconfig update,
> and if everything looks reasonable, linux-cns3xxx's master branch
> is ready for you to pull.

Only concern I have is this:

+#include "../../../drivers/mmc/host/sdhci.h"

but short of moving the header file, I don't see any other way.  It
seems a little strange for the sdhci-pltfm.h file to call functions
which take a sdhci_host struct, but not provide a definition for it.

Will pull soon.
