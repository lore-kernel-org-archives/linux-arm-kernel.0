From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 14 Aug 2015 10:55:53 -0500
Subject: [PATCH 1/2] Add a matching set of device_ functions for
 determining mac/phy
In-Reply-To: <55CBC524.4070101@gmail.com>
References: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
 <1439417187-21411-2-git-send-email-jeremy.linton@arm.com>
 <55CBC524.4070101@gmail.com>
Message-ID: <55CE0F89.2040200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2015 05:13 PM, Florian Fainelli wrote:
> On 12/08/15 15:06, Jeremy Linton wrote:
>> +
>> +static void *device_get_mac_addr(struct device *dev,
>> +				 const char *name, char *addr,
>> +				 int alen)
>> +{
>> +	int ret = device_property_read_u8_array(dev, name, addr, alen);
>> +
>> +	if (ret == 0 && is_valid_ether_addr(addr))
>> +		return addr;
>> +	return NULL;
>
> The DT counterpart has an additional check on the properly length to be
> ETH_ALEN, you might want to have such check here for consistency and
> correctness.

I will add it back,

Thanks,
