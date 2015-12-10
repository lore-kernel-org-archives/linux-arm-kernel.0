From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Dec 2015 09:26:46 +0000
Subject: [PATCH v6 0/4] gicv2m: acpi: Add ACPI support for GICv2m MSI
In-Reply-To: <1449689074-30609-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1449689074-30609-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <56694556.3030809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/15 19:24, Suravee Suthikulpanit wrote:
> This patch series has been forked from the following patch series since
> it no longer depends on the rest of the patches.
> 
>   [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
>   https://lkml.org/lkml/2015/7/29/234
> 
> It has been ported to use the newly introduced device fwnode_handle 
> for ACPI irqdmain introduced by Marc in the following patch series:
> 
>   [PATCH v2 00/17] Divorcing irqdomain and device_node
> 
> The following git branch contains the submitted patches along with
> the pre-requsite patches (mainly for ARM64 PCI support for ACPI).
> 
>   https://github.com/ssuthiku/linux.git	v2m-multiframe-v6
> 
> This has been tested on AMD Seattle (Overdrive) RevB system. 
> 
> NOTE: I have not tested ACPI GICv2m multiframe support since
> I don't have access to such system. Any helps are appreciated.

Suravee,

This is starting to look OK, and you should be able to quickly fix the
last patch. Now, I'm not sure how you want to get that merged.

The first patch touches both ACPI and PCI, so it would at least requires
Acks from Rafael and Bjorn (which is not cc-ed, and you may want to fix
that in your next post, adding linux-pci for a good measure). If they
are both happy with the change, I can pick up the series as a whole.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
