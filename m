From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 25 Apr 2014 10:57:48 -0600
Subject: [RFC 0/5] PCI: tegra: Overhaul regulator usage
In-Reply-To: <53444C4D.2080800@wwwdotorg.org>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
 <53444C4D.2080800@wwwdotorg.org>
Message-ID: <20140425165748.GA32246@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 01:21:49PM -0600, Stephen Warren wrote:
> On 04/04/2014 08:49 AM, Thierry Reding wrote:
> > The current device tree binding for the regulator setup on Tegra PCIe is
> > not accurate. While it does work for current use-cases, that's likely by
> > accident rather than design. This series replaces the existing set of
> > power-supply properties with a new set that accurately describes the
> > inputs of the IP block (depending on SoC generation).
> > 
> > As a heads-up, this breaks backwards compatibility with prior versions
> > of the device tree bindings, but I don't see a reason why that should
> > keep us from fixing this properly. Not many people are currently using
> > these bindings and those who are are most likely tracking upstream
> > development closely enough not to be impacted by this.
> > 
> > I've aimed to keep the series bisectible, which has the downside of
> > interleaving patches to unrelated trees (ARM and PCI). I'm hoping that
> > perhaps we can find a way to merge this as a whole to keep it possible
> > to bisect across the series. Although again, I guess it wouldn't be all
> > that bad if that wasn't the case, given how little PCIe is actually
> > being used.
> 
> I'd be happy to put this series into a branch in the Tegra tree, given
> suitable acks from Bjorn on the PCI changes.

For 3/5 ("PCI: tegra: Implement accurate power supply scheme"),

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I do have the "PCI: tegra: Use new OF interrupt mapping when possible"
change from Lucas on my pci/host-tegra branch, but it shouldn't conflict
with this.

Bjorn
