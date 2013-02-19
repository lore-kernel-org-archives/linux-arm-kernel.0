From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Feb 2013 15:56:49 -0700
Subject: [RFC PATCH 2/9] hwmon: (lm90) split set&show temp as common codes
In-Reply-To: <1361187031-3679-3-git-send-email-wni@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-3-git-send-email-wni@nvidia.com>
Message-ID: <51240331.7080604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2013 04:30 AM, Wei Ni wrote:
> Split set&show temp codes as common functions, so we can use it directly when
> implement linux thermal framework.

> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c

> -static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
> -			  char *buf)
> +static void _show_temp8(struct device *dev, int index, int *temp)

This function now seems to be "get" not "show". If you rename it to e.g.
"get_temp8", then you won't need to use an _ in the function name. If
that name causes conflicts with later patches, perhaps "read_temp8".

> -static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
> -			 const char *buf, size_t count)
> +static void _set_temp8(struct device *dev, int index, long val)

Similarly, perhaps "write_temp8"?

Similar comments for the rest of the patch.
