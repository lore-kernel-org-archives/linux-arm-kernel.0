From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Jul 2012 11:12:28 +0100
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <4FF17375.3030809@marvell.com>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
 <201206281121.56769.arnd@arndb.de> <4FED196D.6090500@marvell.com>
 <201206291358.28788.arnd@arndb.de> <4FF152D3.9040706@marvell.com>
 <4FF1685A.9070506@marvell.com>
 <20120702100324.GC25093@opensource.wolfsonmicro.com>
 <4FF17375.3030809@marvell.com>
Message-ID: <20120702101228.GD25093@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 06:09:57PM +0800, Qiao Zhou wrote:
> On 07/02/2012 06:03 PM, Mark Brown wrote:

> >What do you mean by pages?  regmap has paging support which just maps
> >everything into a single flat register map from the point of view of
> >callers.

> Mark, let me explain: the 88pm800 chip has three i2c address
> internally, which we called different page instead. it confuses you
> with the register page_read/write operation. there are registers in
> each i2c address domain, and we need to use different i2c client to
> access reg in different domain. such as some common regs are in the
> page of i2c_addr = 0x30, and power related regs are in the page of
> i2c_addr = 0x31, and gpadc related regs are in the page of 0x32.

These aren't what people normally call pages, those are just separate
I2C devices from a Linux point of view.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/7e53ff13/attachment.sig>
