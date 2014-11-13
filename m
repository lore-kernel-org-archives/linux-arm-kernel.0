From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 13 Nov 2014 11:20:15 +0100
Subject: [PATCH v2] PCI: designware: Add support 4 ATUs assignment
In-Reply-To: <546481A3.5050700@freescale.com>
References: <1415682444-24911-1-git-send-email-Minghuan.Lian@freescale.com>
 <CA+mB=1+4Dzxhbin6z0PUENvjUz-y8bq-K09FXTnSepFvVfe9HQ@mail.gmail.com>
 <546308DD.40109@freescale.com>
 <CA+mB=1K=Oyzdb2yfBvPRG9DHi-PFjRPtVS_dY9JMOz6dQog8QQ@mail.gmail.com>
 <546331E7.5060003@freescale.com>
 <CA+mB=1KObT9O783SMcvHy8nJGQPnxyKgP332r5bHx-K_D+LhVg@mail.gmail.com>
 <1415809929.2876.5.camel@pengutronix.de> <546481A3.5050700@freescale.com>
Message-ID: <1415874015.2420.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 13.11.2014, 18:02 +0800 schrieb Lian Minghuan-B31939:
> Hi Lucas,
> 
> Please see my comments inline.
> 
> Thanks,
> Minghuan
> 
> On 2014?11?13? 00:32, Lucas Stach wrote:
> > Am Mittwoch, den 12.11.2014, 21:53 +0530 schrieb Srikanth Thokala:
> >> Hi Minghuan,

[...]

> > Using a smaller type complicates the DT for little to no benefit. I
> > think it's ok to use u32 here, which is a common standard for integer
> > values in DT.
> >
> > Though this discussion lead me to the question if we even need to have
> > this property in the DT at all. Isn't this a property that is fixed for
> > a specific silicon implementation of the DW core? In that case we could
> > just infer the number of ATUs from the DT compatible, so this should
> > probably just be added to struct pcie_port and properly initialized by
> > the SoC glue drivers.
> [Minghuan]  As far as I know, exynos implements only 2 ATUs, this is why
> pcie-designware only supports 2 ATU. iMX implements 4 ATUs and LS1021A
> implements 6 ATUs.
> 

Right so we don't need an additional property in the DT at all. The
number of ATUs is fixed for a specific core compatible and can be passed
in by the respective exynos, imx and ls1021 glue drivers.

You may ask the Keystone and Spear maintainers to get the correct number
of ATUs for those implementations.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
