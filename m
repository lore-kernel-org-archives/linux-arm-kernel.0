From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Sep 2014 23:12:09 +0200
Subject: [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver
In-Reply-To: <CAOMZO5BtOO42sde_Eco2=p06WQsJn3+1J44k6i+Dg7qxOK8qdw@mail.gmail.com>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
 <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>
 <CAOMZO5BtOO42sde_Eco2=p06WQsJn3+1J44k6i+Dg7qxOK8qdw@mail.gmail.com>
Message-ID: <4843064.4PPheKAzXq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 September 2014 17:21:48 Fabio Estevam wrote:
> On Thu, Sep 4, 2014 at 3:45 PM, Minghuan Lian
> <Minghuan.Lian@freescale.com> wrote:
> > Add support for Freescale Layerscape PCIe controller. This driver
> > re-uses the designware core code.
> 
> It seems that this is the same IP as on mx6, right?
> 
> Is it possible to adapt drivers/pci/host/pci-imx6.c to work on Layerscape?

For all I can tell, the common parts are already shared in pcie-designware.c,
while the new file contains only those parts that are specific to layerscape
and different from imx.

If there are parts in there that are the same between layerscape and imx,
the implementation should also be moved to a shared file.

	Arnd
