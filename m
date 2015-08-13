From: jeremy.linton@arm.com (Jeremy Linton)
Date: Thu, 13 Aug 2015 09:24:23 -0500
Subject: [PATCH 1/2] Add a matching set of device_ functions for
 determining mac/phy
In-Reply-To: <55CC8613.1040709@arm.com>
References: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
 <1439417187-21411-2-git-send-email-jeremy.linton@arm.com>
 <55CC8613.1040709@arm.com>
Message-ID: <55CCA897.5080108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Robin,

On 08/13/2015 06:57 AM, Robin Murphy wrote:
>> +static void *device_get_mac_addr(struct device *dev,
>> +				 const char *name, char *addr,
>> +				 int alen)
>> +{
>> +	int ret = device_property_read_u8_array(dev, name, addr, alen);
>> +
>> +	if (ret == 0 && is_valid_ether_addr(addr))
>> +		return addr;
>> +	return NULL;
>> +}
>
> Not sure I understand the logic here - "return the same thing we were
> given if we updated it, or null if we didn't". It's only indicating
> success/failure (the caller can perfectly well cast its own buffer to a
> void * if it needs to), so why wouldn't you just return a normal int
> error code?


	No particular reason, other than initially I was trying to keep the 
function as similar as possible to the one in of_net. AKA copy paste 
job. I can convert the return types, but I was trying for a simple 
function rename. That way the users of the of version could be converted 
with relative ease, and the drivers which invented their own version of 
these functions could be changed to use this instead. Of course, that 
plan took a blow, when I added the addr/alen parameters.

	Same thing applies for the other function.


	
