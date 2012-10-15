From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Oct 2012 12:30:52 -0600
Subject: [PATCH 5/5] ARM: tegra: select SPARSE_IRQ
In-Reply-To: <1348090279-22631-5-git-send-email-swarren@wwwdotorg.org>
References: <1348090279-22631-1-git-send-email-swarren@wwwdotorg.org>
 <1348090279-22631-5-git-send-email-swarren@wwwdotorg.org>
Message-ID: <507C565C.7000101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2012 03:31 PM, Stephen Warren wrote:
> SPARSE_IRQ is required for single zImage support.
> 
> With this enabled, we can delete <mach/irqs.h>. This requires removing
> one unnecessary include of that file, and hard-coding the PCIe IRQ into
> the PCIe driver. This is a hack that will be dealt with as part of
> converting the PCIe driver into a true DT-supporting driver.

I have applied this series to Tegra's for-3.8/single-zimage branch.

I'm not sure yet if Tegra will actually be able to be part of single
zImage in 3.8, but this branch will certainly host a fair few changes to
get it very close at least.
