From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 10 Jun 2013 21:50:29 +0200
Subject: [PATCH V3 2/4] ARM: tegra: pcie: Add tegra3 support
In-Reply-To: <51AE3D3B.6080102@wwwdotorg.org>
References: <1370372252-4332-1-git-send-email-jagarwal@nvidia.com>
 <1370372252-4332-2-git-send-email-jagarwal@nvidia.com>
 <51AE3D3B.6080102@wwwdotorg.org>
Message-ID: <20130610195028.GB25859@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 01:17:15PM -0600, Stephen Warren wrote:
> On 06/04/2013 12:57 PM, Jay Agarwal wrote:
[...]
> >  struct tegra_pcie_port {
> > @@ -384,7 +408,7 @@ static int tegra_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
> >  		struct tegra_pcie_port *port;
> >  
> >  		list_for_each_entry(port, &pcie->ports, list) {
> > -			if (port->index + 1 == slot) {
> > +			if (port->index == slot) {
> 
> This and the equivalent change in tegra_pcie_write_conf() seem like a
> bug-fix unrelated to the addition of Tegra30 support. Hence, they should
> be a separate patch.

What exactly is this change supposed to fix? The description doesn't
provide any details about why this is required. Furthermore this was
done on purpose to model the Tegra PCIe controller according to what
typical Linux systems provide.

Device 0:00.0 is usually the root complex, and device 0:01.0, 0:02.0
etc are the root ports. The change proposed above makes 0:00.0 the
first root port, therefore breaking what systems usually expect.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130610/1cbe8463/attachment.sig>
