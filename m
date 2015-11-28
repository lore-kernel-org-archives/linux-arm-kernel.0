From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Sat, 28 Nov 2015 09:59:19 +0000
Subject: [PATCH v10] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <2717087.4cxEA98ZJk@wuerfel>
References: <1448636523-20503-1-git-send-email-bharatku@xilinx.com>
 <2717087.4cxEA98ZJk@wuerfel>
Message-ID: <8520D5D51A55D047800579B09414719825866D71@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v10] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
> PCIe Host Controller
> 
> On Friday 27 November 2015 20:32:03 Bharat Kumar Gogada wrote:
> > +       do {
> > +               err = nwl_pcie_link_up(pcie, PHY_RDY_LINKUP);
> > +               if (err != 1) {
> > +                       check_link_up++;
> > +                       if (check_link_up > LINKUP_ITER_CHECK)
> > +                               return -ENODEV;
> > +                       mdelay(1000);
> > +               }
> > +       } while (!err);
> 
> mdelay(1000) is not something anyone should do. Why can't you call a
> sleeping function here?
> 
Agreed will use sleep function, will address it in next patch.

Regards,
Bharat
