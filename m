From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 7 May 2013 15:08:50 +0200
Subject: [PATCH] ARM: tegra: disable LP2 cpuidle state if PCIe is enabled
In-Reply-To: <20130507124849.GM7949@tbergstrom-lnx.Nvidia.com>
References: <1367872744-25002-1-git-send-email-swarren@wwwdotorg.org>
 <20130507124849.GM7949@tbergstrom-lnx.Nvidia.com>
Message-ID: <20130507130850.GA11202@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 03:48:49PM +0300, Peter De Schrijver wrote:
> On Mon, May 06, 2013 at 10:39:04PM +0200, Stephen Warren wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > Tegra20 HW appears to have a bug such that PCIe device interrupts, whether
> > they are legacy IRQs or MSI, are lost when LP2 is enabled. To work around
> > this, simply disable LP2 if the PCI driver and DT node are both enabled.
> > 
> 
> Wouldn't it make more sense to disable LP2 when we actually detect a PCIe
> device?

I'm not sure a patch to do so would be as simple as this one. For one,
the cpuidle framework will already have been initialized when PCIe
enumeration completes. So some way of permanently disabling one state at
runtime would be required and I don't think cpuidle provides an API to
do so. I know the latter isn't really a good reason, but I don't think
adding that kind of API just because Tegra20 seems to have a bug would
be appropriate.

Furthermore, it is quite likely that the PCIe controller will only be
enabled in DT for devices that actually have a PCIe device hooked up.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130507/c982833d/attachment.sig>
