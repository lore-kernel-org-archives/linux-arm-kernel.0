From: jagarwal@nvidia.com (Jay Agarwal)
Date: Tue, 11 Jun 2013 10:13:38 +0530
Subject: [PATCH V3 2/4] ARM: tegra: pcie: Add tegra3 support
In-Reply-To: <20130610195028.GB25859@mithrandir>
References: <1370372252-4332-1-git-send-email-jagarwal@nvidia.com>
 <1370372252-4332-2-git-send-email-jagarwal@nvidia.com>
 <51AE3D3B.6080102@wwwdotorg.org> <20130610195028.GB25859@mithrandir>
Message-ID: <C79B248886DD134989C8FF6B096A91AB91B616BEED@BGMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> * PGP Signed by an unknown key
> 
> On Tue, Jun 04, 2013 at 01:17:15PM -0600, Stephen Warren wrote:
> > On 06/04/2013 12:57 PM, Jay Agarwal wrote:
> [...]
> > >  struct tegra_pcie_port {
> > > @@ -384,7 +408,7 @@ static int tegra_pcie_read_conf(struct pci_bus
> *bus, unsigned int devfn,
> > >  		struct tegra_pcie_port *port;
> > >
> > >  		list_for_each_entry(port, &pcie->ports, list) {
> > > -			if (port->index + 1 == slot) {
> > > +			if (port->index == slot) {
> >
> > This and the equivalent change in tegra_pcie_write_conf() seem like a
> > bug-fix unrelated to the addition of Tegra30 support. Hence, they
> > should be a separate patch.
> 
> What exactly is this change supposed to fix? The description doesn't provide
> any details about why this is required. Furthermore this was done on
> purpose to model the Tegra PCIe controller according to what typical Linux
> systems provide.

I have mentioned it in description as -> "Corrected logic in read/write config space to display right device number on bus 0"

> Device 0:00.0 is usually the root complex, and device 0:01.0, 0:02.0 etc are
> the root ports. The change proposed above makes 0:00.0 the first root port,
> therefore breaking what systems usually expect.
> 
I was seeing root port 2 in cardhu being enumerated as pci_bus 0000:03, which I thought should be pci_bus 0000:02, so made this change.

> Thierry
> 
> * Unknown Key
> * 0x7F3EB3A1
