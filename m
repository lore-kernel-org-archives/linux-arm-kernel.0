From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Jun 2016 10:13:01 +0200
Subject: [PATCH 1/3] pci: introduce read_bridge/write_bridge pci ops
In-Reply-To: <20160607002822.GA1391@localhost>
References: <1464784332-3775650-1-git-send-email-arnd@arndb.de>
 <3585926.N1C2xx3GaB@wuerfel> <20160607002822.GA1391@localhost>
Message-ID: <3754686.OCbiLBzILC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 6, 2016 7:28:22 PM CEST Bjorn Helgaas wrote:
> The caller is performing one abstract operation: reading or writing
> config space of a PCI device.  In the caller's context, it makes no
> difference whether it's a type0 or type1 access.
> 
> Moving the test from the host bridge driver to pci_read_config_byte()
> does move a little code from the callee to the caller, and there are
> more callees than callers, so in that sense it does remove code
> overall.  If you consider a single driver by itself, I'm not sure it
> makes much difference.
> 
> The pcie-designware.c patch is a net removal of 17 lines, but that's
> not all from moving the type0/type1 test: restructuring along the same
> lines but keeping the original type0/type1 test removes about 9 lines.
> 
> Anyway, I think I'd rather work first on your RFC patches to make
> pci_host_bridge the primary structure for probing PCI.  I think
> there will be a *lot* of benefit there.

Fair enough. This series started from the review of the Rockchip
driver, and the idea was to make that one simpler, but given that
we already have several dozen drivers doing the same thing, adding
one more isn't going to have a significant impact now.

	Arnd
