From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 8 Nov 2017 10:49:28 -0600
Subject: [PATCH V2 2/3] dmaengine: qcom_hidma: add support for the new
 revision
In-Reply-To: <1510158582-5343-2-git-send-email-okaya@codeaurora.org>
References: <1510158582-5343-1-git-send-email-okaya@codeaurora.org>
 <1510158582-5343-2-git-send-email-okaya@codeaurora.org>
Message-ID: <e673a03d-1707-fe4a-7f5d-df1466981893@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2017 10:29 AM, Sinan Kaya wrote:
> +#define HIDMA_MAX_DEV_MATCH 10
> +
> +struct hidma_cap {
> +	const struct of_device_id of[HIDMA_MAX_DEV_MATCH];
> +	const struct acpi_device_id acpi[HIDMA_MAX_DEV_MATCH];
> +};

This seems wrong.  You're defining an array of size 10, but it only has 
three elements.  And the third element is a sentinel, which is typically 
used to avoid specifying the size of the array.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
