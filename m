From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Sep 2015 13:32:10 +0200
Subject: [PATCH v2 04/10] doc/bindings: Update PCIe devicetree binding
 documentation for LS2080A
In-Reply-To: <1441349872-4560-5-git-send-email-bhupesh.sharma@freescale.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-5-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <80094129.LHZFOe1ZPU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 September 2015 12:27:46 Bhupesh Sharma wrote:
> @@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
>  and thus inherits all the common properties defined in designware-pcie.txt.
>  
>  Required properties:
> -- compatible: should contain the platform identifier such as "fsl,ls1021a-pcie"
> +- compatible: should contain the platform identifier such as "fsl,ls1021a-pcie",
> +  "fsl,ls2080a-pcie".
>  - reg: base addresses and lengths of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> 

Are the two PCIe hosts mutually compatible? If they are, you should mandate
one of the strings as the base model for identification, with the additional
model being optional for identification of the specific SoC.

It would also be good to add a string with the specific version number of the
designware PCIe block that is being used there.

	Arnd
