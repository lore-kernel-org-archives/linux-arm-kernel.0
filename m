From: noralf@tronnes.org (=?windows-1252?Q?Noralf_Tr=F8nnes?=)
Date: Thu, 28 May 2015 23:39:08 +0200
Subject: [PATCH 2/3 v4] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <5567886F.5080108@wwwdotorg.org>
References: <20150528114500.GP11677@x1>
 <1432837987-22861-1-git-send-email-eric@anholt.net>
 <5567886F.5080108@wwwdotorg.org>
Message-ID: <55678AFC.6020404@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 28.05.2015 23:28, skrev Stephen Warren:
> On 05/28/2015 12:33 PM, Eric Anholt wrote:
>> This gives us a function for making mailbox property channel requests
>> of the firmware, which is most notable in that it will let us get and
>> set clock rates.
...
>> +int rpi_firmware_property_list(struct device_node *of_node,
>> +			       void *data, size_t tag_size)
>> +{
>> +	struct platform_device *pdev = of_find_device_by_node(of_node);
> I would expect the of_node -> pdev mapping to happen at client device
> probe time. Simplest for this driver would be if the
> client-probe-time-mapping function returned the "struct rpi_firmware"
> and the client passed that to this function.

What if the firmware driver/device is removed or reloaded?
In that case the client has an invalid pointer. It wouldn't know about 
the change.
