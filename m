From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 20 Dec 2011 15:58:43 -0800
Subject: [RFC PATCH v3 1/5] dt: add of_get_child_count helper function
In-Reply-To: <1324402840-32451-2-git-send-email-b29396@freescale.com>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-2-git-send-email-b29396@freescale.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF176BE92EE2@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dong Aisheng wrote at Tuesday, December 20, 2011 10:41 AM:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Currently most code to get child count in kernel are almost same,
> add a helper to implement this function for dt to use.

> diff --git a/include/linux/of.h b/include/linux/of.h

> +static inline int of_get_child_count(const struct device_node *np)
> +{
> +	return -ENOSYS;
> +}

Wouldn't it be better to return 0 here? -ENOSYS would be fine if the
function returned an error code, but it's really returning a count, and
other "dummy" functions that return data return 0/NULL already. This
would also allow you to just use the value directly in all cases rather
than having to check for a < 0 error case.

-- 
nvpublic
