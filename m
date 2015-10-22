From: w-kwok2@ti.com (Kwok, WingMan)
Date: Thu, 22 Oct 2015 14:22:24 +0000
Subject: [PATCH v3 1/2] phy: keystone: serdes driver for gbe 10gbe and pcie
In-Reply-To: <CAL_JsqKSteJnz53YuBbgR1K9GWQDddkaqFo1aVxd8RsDam5jSw@mail.gmail.com>
References: <1445432201-16007-1-git-send-email-w-kwok2@ti.com>
 <1445432201-16007-2-git-send-email-w-kwok2@ti.com>
 <CAL_JsqKSteJnz53YuBbgR1K9GWQDddkaqFo1aVxd8RsDam5jSw@mail.gmail.com>
Message-ID: <230CBA6E4B6B6B418E8730AC28E6FC7E0422A2A6@DFLE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Rob Herring [mailto:robh+dt at kernel.org]
> Sent: Wednesday, October 21, 2015 6:55 PM
> To: Kwok, WingMan
> Cc: Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala; KISHON VIJAY ABRAHAM;
> Quadros, Roger; Karicheri, Muralidharan; Bjorn Helgaas; Santosh Shilimkar;
> Russell King - ARM Linux; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-pci at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v3 1/2] phy: keystone: serdes driver for gbe 10gbe and
> pcie
> 
> On Wed, Oct 21, 2015 at 7:56 AM, WingMan Kwok <w-kwok2@ti.com> wrote:
> > On TI's Keystone platforms, several peripherals such as the
> > gbe ethernet switch, 10gbe ethernet switch and PCIe controller
> > require the use of a SerDes for converting SoC parallel data into
> > serialized data that can be output over a high-speed electrical
> > interface, and also converting high-speed serial input data
> > into parallel data that can be processed by the SoC.  The
> > SerDeses used by those peripherals, though they may be different,
> > are largely similar in functionality and setup.
> >
> > This patch provides a SerDes phy driver implementation that can be
> > used by the above mentioned peripheral drivers to configure their
> > respective SerDeses.
> >
> > Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> > ---
> >  Documentation/devicetree/bindings/phy/ti-phy.txt |  239 +++
> 
> For the binding:
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> 
> One other comment:
> 
> > +       if (of_device_is_compatible(np, "ti,keystone-serdes-gbe")) {
> > +               sc->phy_type = KSERDES_PHY_SGMII;
> > +       } else if (of_device_is_compatible(np, "ti,keystone-serdes-xgbe"))
> {
> > +               sc->phy_type = KSERDES_PHY_XGE;
> > +       } else if (of_device_is_compatible(np, "ti,keystone-serdes-pcie"))
> {
> > +               sc->phy_type = KSERDES_PHY_PCIE;
> > +       } else {
> > +               dev_err(dev, "unknown phy type\n");
> > +               return -EINVAL;
> > +       }
> 
> Use the match data to set the type:
> 

will do.

> > +static const struct of_device_id kserdes_of_match[] = {
> > +       { .compatible = "ti,keystone-serdes-gbe" },
> > +       { .compatible = "ti,keystone-serdes-pcie" },
> > +       { .compatible = "ti,keystone-serdes-xgbe" },
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(of, kserdes_of_match);
> 
> Rob

Thanks,
WingMan
