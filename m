From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 8 Apr 2014 12:07:17 +0300
Subject: [PATCH] ARM: dts: keystone: add cell's information to i2c nodes
In-Reply-To: <5342E575.60308@ti.com>
References: <1396884272-8307-1-git-send-email-grygorii.strashko@ti.com>
 <5342E575.60308@ti.com>
Message-ID: <5343BC45.5090205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2014 08:50 PM, Santosh Shilimkar wrote:
> On Monday 07 April 2014 11:24 AM, Grygorii Strashko wrote:
>> I2C nodes should always have #address-cells and #size-cells defined.
>> Hence, ensure that all i2cX nodes have #address-cells and #size-cells
>> properties defined.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
> Right. BTW, have you seen some issue without this patch ?
> Just curious what prompted you to create this patch and whether
> it needs to be sent as fix during rc's.

I think, it can wait for next. Without this patch warnings will
be produced in case of adding child node to the bus in DT:
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc/i2c at 2530800/pca at 20
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc/i2c at 2530800/pca at 20

I'll updated patch description and resend.

Regards,
-grygorii
