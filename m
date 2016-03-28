From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Mar 2016 23:21:57 +0200
Subject: [PATCH 2/2] pci: host: new driver for Marvell Armada 7K/8K PCIe
 controller
In-Reply-To: <1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <3196859.0zi20qjiKR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 27 March 2016 11:30:58 Thomas Petazzoni wrote:
> +       /* Wait until the link becomes active again */
> +       while (timeout) {
> +               if (armada8k_pcie_link_up(pp))
> +                       break;
> +               udelay(1);
> +               timeout--;
> +       }
> 

Why the busy-loop here?

Maybe just do a single msleep(1) here to wait for the link to
come up instead?

	Arnd
