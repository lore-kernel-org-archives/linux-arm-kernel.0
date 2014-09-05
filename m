From: Minghuan.Lian@freescale.com (Minghuan.Lian at freescale.com)
Date: Fri, 5 Sep 2014 06:43:44 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDIvMl0gUENJOiBMYXllcnNjYXBlOiBBZGQgTGF5ZXJz?=
 =?gb2312?Q?cape_PCIe_driver?=
In-Reply-To: <4843064.4PPheKAzXq@wuerfel>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
 <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>
 <CAOMZO5BtOO42sde_Eco2=p06WQsJn3+1J44k6i+Dg7qxOK8qdw@mail.gmail.com>,
 <4843064.4PPheKAzXq@wuerfel>
Message-ID: <1409928263985.66691@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for your comments.

There are no same parts between Layerscape and imx.
I think we should use a new file to implement Layerscape PCI driver.

Thanks,
Minghuan
________________________________________
???: Arnd Bergmann <arnd@arndb.de>
????: 2014?9?5? 5:12
???: linux-arm-kernel at lists.infradead.org
??: Fabio Estevam; Lian Minghuan-B31939; Wood Scott-B07421; linux-pci at vger.kernel.org; Hu Mingkai-B21284; Zang Roy-R61911
??: Re: [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver

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
