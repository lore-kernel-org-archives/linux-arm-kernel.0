From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Nov 2015 16:51:38 +0100
Subject: [PATCH v10] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <1448636523-20503-1-git-send-email-bharatku@xilinx.com>
References: <1448636523-20503-1-git-send-email-bharatku@xilinx.com>
Message-ID: <2717087.4cxEA98ZJk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 November 2015 20:32:03 Bharat Kumar Gogada wrote:
> +       do {
> +               err = nwl_pcie_link_up(pcie, PHY_RDY_LINKUP);
> +               if (err != 1) {
> +                       check_link_up++;
> +                       if (check_link_up > LINKUP_ITER_CHECK)
> +                               return -ENODEV;
> +                       mdelay(1000);
> +               }
> +       } while (!err);

mdelay(1000) is not something anyone should do. Why can't you call
a sleeping function here?

	Arnd
