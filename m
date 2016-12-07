From: jk@ozlabs.org (Jeremy Kerr)
Date: Thu, 8 Dec 2016 10:27:46 +1100
Subject: [PATCH 05/16] drivers/fsi: Add fake master driver
In-Reply-To: <20161207120905.GD7054@leverpostej>
References: <1481069677-53660-1-git-send-email-christopher.lee.bostic@gmail.com>
 <1481069677-53660-6-git-send-email-christopher.lee.bostic@gmail.com>
 <20161207120905.GD7054@leverpostej>
Message-ID: <d5443f56-501e-53d4-ae09-a356573c4096@ozlabs.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark & Chris,

> On Tue, Dec 06, 2016 at 06:14:26PM -0600, Chris Bostic wrote:
>> From: Jeremy Kerr <jk@ozlabs.org>
>>
>> For debugging, add a fake master driver, that only supports reads,
>> returning a fixed set of data.
> 
>> +config FSI_MASTER_FAKE
>> +	tristate "Fake FSI master"
>> +	depends on FSI
>> +	---help---
>> +	This option enables a fake FSI master driver for debugging.
>> +endif
> 
>> +static const struct of_device_id fsi_master_fake_match[] = {
>> +	{ .compatible = "ibm,fsi-master-fake" },
>> +	{ },
>> +};
> 
> NAK.
> 
> DT should be treated as an ABI, and should describe the HW explicitly.
> This makes no sense. This is also missing a binding document.
> 
> Have your module take a module parameter allowing you to bind it to
> arbitrary devices, or do something like what PCI does where you can
> bind/unbind arbitrary drivers to devices using sysfs.

This driver is purely for testing the FSI engine scan code; we could
probably just drop this patch since I suspect that it's no longer useful
(now that we have an actual master driver).

If we do want to keep it though, I'd say we remove the device tree
dependency; all this is doing at the moment is triggering the ->probe,
and there are better ways to do that.

Cheers,


Jeremy
