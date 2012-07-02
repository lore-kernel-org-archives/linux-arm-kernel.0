From: zhouqiao@marvell.com (Qiao Zhou)
Date: Mon, 02 Jul 2012 18:15:06 +0800
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <20120702101228.GD25093@opensource.wolfsonmicro.com>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
 <201206281121.56769.arnd@arndb.de> <4FED196D.6090500@marvell.com>
 <201206291358.28788.arnd@arndb.de> <4FF152D3.9040706@marvell.com>
 <4FF1685A.9070506@marvell.com>
 <20120702100324.GC25093@opensource.wolfsonmicro.com>
 <4FF17375.3030809@marvell.com>
 <20120702101228.GD25093@opensource.wolfsonmicro.com>
Message-ID: <4FF174AA.3020001@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2012 06:12 PM, Mark Brown wrote:
> On Mon, Jul 02, 2012 at 06:09:57PM +0800, Qiao Zhou wrote:
>> On 07/02/2012 06:03 PM, Mark Brown wrote:
>
>>> What do you mean by pages?  regmap has paging support which just maps
>>> everything into a single flat register map from the point of view of
>>> callers.
>
>> Mark, let me explain: the 88pm800 chip has three i2c address
>> internally, which we called different page instead. it confuses you
>> with the register page_read/write operation. there are registers in
>> each i2c address domain, and we need to use different i2c client to
>> access reg in different domain. such as some common regs are in the
>> page of i2c_addr = 0x30, and power related regs are in the page of
>> i2c_addr = 0x31, and gpadc related regs are in the page of 0x32.
>
> These aren't what people normally call pages, those are just separate
> I2C devices from a Linux point of view.
>
Mark, surely I'll pay attention to the terms used. thanks!
due to there separate I2C devices, does it make sense to export separate 
r/w interface for them? do you have suggestion in such case?

-- 

Best Regards
Qiao
