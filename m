From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 8 Jan 2014 09:42:25 +0530
Subject: [BUG] More select madness - keystone
In-Reply-To: <52C5BFE3.6050408@ti.com>
References: <20140102172625.GC7383@n2100.arm.linux.org.uk>
 <52C5BB4A.6010802@ti.com> <52C5BFE3.6050408@ti.com>
Message-ID: <52CCD029.6090404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 January 2014 01:07 AM, Santosh Shilimkar wrote:
> On Thursday 02 January 2014 02:17 PM, Santosh Shilimkar wrote:
>> On Thursday 02 January 2014 12:26 PM, Russell King - ARM Linux wrote:
>>> warning: (ARCH_KEYSTONE && SPI_DAVINCI) selects TI_EDMA which has unmet direct dependencies (DMADEVICES && (ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE))
>>>
>>> This results in the EDMA engine code not being built.  Yet another
>>> example of why improper use of the "select" statement is bad news
>>> and leads to broken configurations.
>>>
>> Thanks for reporting Russell. Will have a look.
>>
> Just to be clear for records, the select was introduced before
> KEYSTONE support was enabled. As per git blame, it came via commit
> b5f1433059 {spi: davici - make davinci select edma}.

I don't quite recall why this was needed and the commit description does
not help. Anyway, this is not needed - at least with current code. I
verified that the DaVinci SPI driver builds correctly with TI_EDMA
switched off. I can send a revert.

BTW, it looks like arch/arm/mach-keystone/Kconfig has a select for
TI_EDMA as well and that needs to be removed too.

Thanks,
Sekhar
