From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 17 Nov 2015 16:36:24 +0000
Subject: [Xen-devel] [PATCH 06/13] Xen: ARM: Add support for mapping amba
 device mmio
In-Reply-To: <1447754231-7772-7-git-send-email-shannon.zhao@linaro.org>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
 <1447754231-7772-7-git-send-email-shannon.zhao@linaro.org>
Message-ID: <564B5788.2070008@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/15 09:57, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add a bus_notifier for AMBA bus device in order to map the device
> mmio regions when DOM0 booting with ACPI.
[...]
> +static int xen_map_amba_device_mmio(struct amba_device *adev)
> +{
> +	int rc = 0;
> +	struct resource *r = &adev->res;
> +
> +	if (resource_type(r) == IORESOURCE_MEM)
> +	{

Haven't I seen something like this before...?

This is (almost) identical to the code added for platform devices.  This
needs to be generic.

David
