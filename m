From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 2 Mar 2018 12:29:07 +0000
Subject: [PATCH 11/14] drm/msm: Add support for iommu-sva PASIDs
In-Reply-To: <20180221225924.30737-12-jcrouse@codeaurora.org>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
 <20180221225924.30737-12-jcrouse@codeaurora.org>
Message-ID: <a0ab61d6-1894-c3ba-4955-ca6d4f74a4d7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/18 22:59, Jordan Crouse wrote:
[...]> +static int install_pasid_cb(int pasid, u64 ttbr, u32 asid, void *data)
> +{
> +	struct pasid_entry *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->pasid = pasid;
> +	entry->ttbr = ttbr;
> +	entry->asid = asid;
> +
> +	/* FIXME: Assume that we'll never have a pasid conflict? */

I think a conflict would be a bug on the IOMMU side. Users should not have
to check this. Then again, I have a few WARNs on the SMMUv3 context table
code that uncovered nasty bugs during development.

Thanks,
Jean
