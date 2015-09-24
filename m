From: scottwood@freescale.com (Scott Wood)
Date: Thu, 24 Sep 2015 14:30:09 -0500
Subject: [PATCH v3 1/2] fsl: Add binding for RCPM
In-Reply-To: <1443083354-37369-1-git-send-email-dongsheng.wang@freescale.com>
References: <1443083354-37369-1-git-send-email-dongsheng.wang@freescale.com>
Message-ID: <1443123009.32298.29.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-09-24 at 16:29 +0800, Dongsheng Wang wrote:
> +* Freescale RCPM Wakeup Source Device Tree Bindings
> +-------------------------------------------
> +Required rcpm-wakeup property should be added to a device node if the 
> device
> +can be used as a wakeup source.
> +
> +  - rcpm-wakeup: The value of the property consists of cells, the number of
> +     cells defined in "fsl,#rcpm-wakeup-cells". The first cell is a pointer
> +     to the rcpm node, the second cell is the bit mask that should be set
> +     in IPPDEXPCR0, and the third cell is for IPPDEXPCR1, and so on.

The phandle should not be included in the cell count.

-Scott
