From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 5 Mar 2018 10:28:42 -0500
Subject: [PATCH 03/37] iommu/sva: Manage process address spaces
In-Reply-To: <20180212183352.22730-4-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
Message-ID: <27a044ee-0ed7-0470-0fef-289d0d5cf5e8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> +static void io_mm_free(struct io_mm *io_mm)
> +{
> +	struct mm_struct *mm;
> +	void (*release)(struct io_mm *);
> +
> +	release = io_mm->release;
> +	mm = io_mm->mm;
> +
> +	release(io_mm);

Is there any reason why you can't call iommu->release()
here directly? Why do you need the release local variable?

> +	mmdrop(mm);
> +}
> +


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
