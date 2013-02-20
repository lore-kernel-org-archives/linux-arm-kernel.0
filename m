From: wni@nvidia.com (Wei Ni)
Date: Wed, 20 Feb 2013 20:31:37 +0800
Subject: [RFC PATCH 2/9] hwmon: (lm90) split set&show temp as common codes
In-Reply-To: <51240331.7080604@wwwdotorg.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-3-git-send-email-wni@nvidia.com>
 <51240331.7080604@wwwdotorg.org>
Message-ID: <5124C229.4030002@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2013 06:56 AM, Stephen Warren wrote:
> On 02/18/2013 04:30 AM, Wei Ni wrote:
>> Split set&show temp codes as common functions, so we can use it directly when
>> implement linux thermal framework.
> 
>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> 
>> -static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
>> -			  char *buf)
>> +static void _show_temp8(struct device *dev, int index, int *temp)
> 
> This function now seems to be "get" not "show". If you rename it to e.g.
> "get_temp8", then you won't need to use an _ in the function name. If
> that name causes conflicts with later patches, perhaps "read_temp8".

Yes, it looks "read_" is better.
I will change it.

> 
>> -static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
>> -			 const char *buf, size_t count)
>> +static void _set_temp8(struct device *dev, int index, long val)
> 
> Similarly, perhaps "write_temp8"?
> 
> Similar comments for the rest of the patch.
> 
