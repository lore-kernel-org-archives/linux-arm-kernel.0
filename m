From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Nov 2016 16:10:23 +0100
Subject: [PATCH v1 03/11] drivers: soc: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <2bac1a34-591b-6557-15bf-40db25c3d129@huawei.com>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
 <2030692.HPgjBCTYG6@wuerfel>
 <2bac1a34-591b-6557-15bf-40db25c3d129@huawei.com>
Message-ID: <1609380.NN50qvVsP7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 8, 2016 1:49:43 PM CET John Garry wrote:
> 
> Hi Arnd,
> 
> Thanks for the reference.
> 
> I think the i2c interface doesn't fully satisfy our requirements as we 
> need more than just a slave bus address when accessing the slave device 
> (which I think is what i2c uses). We also need to pass "offset" and 
> "mod_mask" arguments to the djtag adapter to access specific registers 
> in the slave device.

Ok. Are those values constant per device, or maybe a range? We may want to
include those in the reg property as well then.

	Arnd
