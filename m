From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 May 2015 17:44:49 +0200
Subject: [V2 PATCH 2/5] arm64 : Introduce support for ACPI _CCA object
In-Reply-To: <1430838729-21572-3-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1430838729-21572-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1430838729-21572-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <5126612.k0u2CL2zi5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 May 2015 10:12:06 Suravee Suthikulpanit wrote:
> +struct dma_map_ops dummy_dma_ops = {
> +       .alloc                  = __dummy_alloc,
> +       .free                   = __dummy_free,
> +       .mmap                   = __dummy_mmap,
> +       .map_page               = __dummy_map_page,
> +       .unmap_page             = __dummy_unmap_page,
> +       .map_sg                 = __dummy_map_sg,
> +       .unmap_sg               = __dummy_unmap_sg,
> +       .sync_single_for_cpu    = __dummy_sync_single_for_cpu,
> +       .sync_single_for_device = __dummy_sync_single_for_device,
> +       .sync_sg_for_cpu        = __dummy_sync_sg_for_cpu,
> +       .sync_sg_for_device     = __dummy_sync_sg_for_device,
> +       .mapping_error          = __dummy_mapping_error,
> +       .dma_supported          = __dummy_dma_supported,
> +};
> +EXPORT_SYMBOL(dummy_dma_ops);
> +
> 

This will clearly work, but I think it's easier to just leave
the dma_mask pointer as NULL when creating the platform device,
which should let the normal dma ops fail all the callbacks.

	Arnd
