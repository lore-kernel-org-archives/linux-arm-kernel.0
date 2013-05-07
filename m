From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 7 May 2013 15:48:49 +0300
Subject: [PATCH] ARM: tegra: disable LP2 cpuidle state if PCIe is enabled
In-Reply-To: <1367872744-25002-1-git-send-email-swarren@wwwdotorg.org>
References: <1367872744-25002-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130507124849.GM7949@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 06, 2013 at 10:39:04PM +0200, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
> they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
> this, simply disable LP2 if the PCI driver and DT node are both enabled.
> 

Wouldn't it make more sense to disable LP2 when we actually detect a PCIe
device?

Cheers,

Peter.
