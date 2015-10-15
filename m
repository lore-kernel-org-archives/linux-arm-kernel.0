From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 16:16:57 +0200
Subject: [PATCH v3 05/12] doc/bindings: Update Layerscape PCIe devicetree
 binding to be more flexible
In-Reply-To: <1444891672-32117-6-git-send-email-bhupesh.sharma@freescale.com>
References: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
 <1444891672-32117-6-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <5383901.aC2HYopUNW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 12:17:45 Bhupesh Sharma wrote:
> 
> +Note that since this controller derives its clocks from the Reset
> +Configuration Word (RCW) which is used to describe the PLL settings at
> +the time of chip-reset, the 'clocks' and 'clock-names' properties from
> +'designware-pcie.txt' are optional for this controller.

If this is an option for the dw-pcie block, should this description be
added to the generic binding instead?

> +Also as per the available Reference Manuals, there is no specific 'version'
> +register available in the Freescale PCIe controller register set,
> +which can allow determining the underlying Designware PCIe controller version
> +information.
> +
>  Required properties:
> -- compatible: should contain the platform identifier such as "fsl,ls1021a-pcie"
> +- compatible: should contain the platform identifier such as "fsl,<soc-name>-pcie",
> +  "snps,dw-pcie".

You should document all the strings that will be needed here, otherwise a
driver write does not know what to look for.

If two chips have a 100% identical PCIe implementation, just use the string
of the older chip for both.

	Arnd
