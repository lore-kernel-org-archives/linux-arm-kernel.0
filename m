From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 8 Mar 2016 10:37:34 -0500
Subject: [PATCH 1/2] vfio, platform: add support for ACPI while detecting
 the reset driver
In-Reply-To: <1457451209-21462-1-git-send-email-okaya@codeaurora.org>
References: <1457451209-21462-1-git-send-email-okaya@codeaurora.org>
Message-ID: <56DEF1BE.8010701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/8/2016 10:33 AM, Sinan Kaya wrote:
> +	int rc = 0;
> +

I should have initialized this to -1. 

> +	vdev->reset = vfio_platform_lookup_reset(vdev->compat, vdev->acpihid,
> +						 &vdev->reset_module);
> +	if (vdev->reset)
> +		return 0;
> +
> +	if (vdev->acpihid)
> +		rc = request_module("vfio-reset:%s", vdev->acpihid);
> +
> +	if (rc && vdev->compat)
> +		rc = request_module("vfio-reset:%s", vdev->compat);
> +


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
