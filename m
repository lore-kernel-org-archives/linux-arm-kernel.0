From: gg@slimlogic.co.uk (Graeme Gregory)
Date: Thu, 13 Aug 2015 10:44:59 +0100
Subject: [PATCH 0/3] Enable EHCI-platform driver for use with ACPI
In-Reply-To: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <20150813094459.GD5468@xora-haswell.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 04:51:27PM -0500, Jeremy Linton wrote:
> This patch set enables the USB on the ARM Juno development platform
> when using an ACPI kernel. This patch is in two primary parts. First
> It tweaks the code in acpi_check_dma() to support the recently added
> CCA attribute which describes a device which is not cache coherent.
> 
> It then adds an error message if the device cannot be configured with
> the current DMA settings, finally it adds the ACPI PNP id to the
> acpi_match_table entry.
> 

Patch 1 I am unsure of (I just don't know enough about DMA), but for the other
two it looks fine to me.

Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>

> Jeremy Linton (3):
>   Honor ACPI _CCA attribute setting
>   Display a DMA error message
>   Add ACPI bindings for the EHCI platform driver.
> 
>  drivers/usb/host/ehci-platform.c | 13 ++++++++++++-
>  include/acpi/acpi_bus.h          |  5 +++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> -- 
> 2.4.3
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
