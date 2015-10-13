From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Oct 2015 19:48:29 +0100
Subject: [PATCH v4] iommu/arm-smmu: Add support for MSI on SMMUv3
In-Reply-To: <1444757550-24702-1-git-send-email-marc.zyngier@arm.com>
References: <1444757550-24702-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151013184829.GH24353@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> @@ -36,5 +36,25 @@ the PCIe specification.
>                        NOTE: this only applies to the SMMU itself, not
>                        masters connected upstream of the SMMU.
>  
> +- msi-parent	    : phandles (and potential Device IDs) of MSI controllers


For correct terminology, I'd prefer to replace this line with:

- msi-parent: a list of phandle + msi-specifier pairs for MSI controllers

An msi-specifier may be zero cells, per
Documentation/devicetree/bindings/interrupt-controller/msi.txt, much
like other *-specifiers.

> +		      the SMMU can send MSIs to (instead of wired interrupts).
> +		      See devicetree/bindings.interrupt-controller/msi.txt
> +		      for a description of the msi-parent property.

The rest of this is fine, modulo the '.' which should be a '/'. in the
path.

With those changes:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
