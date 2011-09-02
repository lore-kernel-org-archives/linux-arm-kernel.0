From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 2 Sep 2011 17:35:05 +0200
Subject: [RFC PATCH 3/3] OMAP: omap_device: Add a method to build an
	omap_device from a DT node
In-Reply-To: <87pqjj4yrs.fsf@ti.com>
References: <1314037343-19783-1-git-send-email-b-cousson@ti.com>
	<1314037343-19783-4-git-send-email-b-cousson@ti.com>
	<87pqjj4yrs.fsf@ti.com>
Message-ID: <4E60F7A9.8000903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2011 1:40 AM, Hilman, Kevin wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> Add a notifier called during device_add phase. If a of_node is present,
>> retrieve the hwmod entry in order to populate propely the omap_device
>> structure.
>> For the moment the resource from the device-tree are overloaded.
>> DT does not support named resource yet, and thus, most driver
>> will not work without that information.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>
> Nice, minor comment below...

[...]

>> +	case BUS_NOTIFY_DEL_DEVICE:
>> +		dev_dbg(&pdev->dev, "del_device\n");
>
> Need a delete/cleanup here.
>
> Looks like all all it needs to do is call omap_device_delete()?

Indeed, I was too lazy to add it.

Thanks,
Benoit
