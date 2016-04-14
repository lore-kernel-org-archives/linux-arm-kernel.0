From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 14 Apr 2016 13:13:08 +0000
Subject: [PATCH v2] PCI: designware: move remaining rc setup code to
 dw_pcie_setup_rc()
In-Reply-To: <CAHM4w1kKmbkWoeMzKXgu+wMW+O2e5=wFe=WrKn_HLcFv4s_Qcg@mail.gmail.com>
References: <1458128433-3020-1-git-send-email-jszhang@marvell.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED40E52@lhreml503-mbs>
 <20160407103734.55e72da7@xhacker>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED43F95@lhreml503-mbs>
 <20160407163443.291fbd49@xhacker>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED44208@lhreml503-mbs>
 <20160407140551.GA2648@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED45C38@lhreml503-mbs>
 <20160408160145.GA10565@localhost>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED4B88D@lhreml503-mbs>
 <00a901d19548$90bffc20$b23ff460$@com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED4F10E@lhreml503-mbs>
 <000001d19644$356355a0$a02a00e0$@com>
 <CAHM4w1kKmbkWoeMzKXgu+wMW+O2e5=wFe=WrKn_HLcFv4s_Qcg@mail.gmail.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ED51AD0@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush 

thanks for you reply 

> -----Original Message-----
> From: Pratyush Anand [mailto:pratyush.anand at gmail.com]
> Sent: 14 April 2016 14:08
> To: Jingoo Han; Gabriele Paoloni
> Cc: Bjorn Helgaas; Jisheng Zhang; Bjorn Helgaas; linux-
> pci at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2] PCI: designware: move remaining rc setup code
> to dw_pcie_setup_rc()
> 
> Hi Gabriele,
> 
> On Thu, Apr 14, 2016 at 5:22 PM, Jingoo Han <jingoohan1@gmail.com>
> wrote:
> > On Wednesday, April 13, 2016 4:58 PM, Gabriele Paoloni wrote:
> >>
> >> Hi Jingoo
> >>
> >> On 13 April 2016 06:52, Jingoo Han wrote:
> >> > On Tuesday, April 12, 2016 6:44 PM, Gabriele Paoloni wrote:
> 
> [...]
> 
> >> > > So I will update the driver to call dw_pcie_setup_rc() from
> >> > > .host_init and ask the BIOS team to update the firmware for next
> >> > > releases (the driver will be backward compatible anyway).
> >> > >
> >> > > Also during my investigation I have noticed that in
> >> > dw_pcie_setup_rc()
> >> > > http://lxr.free-electrons.com/source/drivers/pci/host/pcie-
> >> > designware.c#L762
> >> > >
> >> > > we use pp->mem_base rather than pp->mem_bus_addr to setup
> >> > > memory base and memory limit in the Type1 header...I think this
> >> > > is wrong right?
> 
> Yes. RC's "memory base" and "memory limit" should be governed by PCI
> addresses and not CPU addresses. So, it should use pp->mem_bus_addr.
> 
> >> > > Also I do not see why this code is needed at all since we
> overwrite
> >> > > this register when we call pci_bus_assign_resources(bus) that
> >> > > will end up in calling pci_setup_bridge() and then
> >> > > pci_setup_bridge_mmio()...?
> >>
> >> Do you have any comment on this issue above?
> 
> Probably thats why things are working.
> Thanks for finding it. I think, /* setup memory base, memory limit */
> hunk can be removed from dw_pcie_setup_rc.

Great, I'll send out a patch to remove this

Thanks

Gab

> 
> ~Pratyush
