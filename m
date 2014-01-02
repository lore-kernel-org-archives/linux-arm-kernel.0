From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 2 Jan 2014 14:37:07 -0500
Subject: [BUG] More select madness - keystone
In-Reply-To: <52C5BB4A.6010802@ti.com>
References: <20140102172625.GC7383@n2100.arm.linux.org.uk>
 <52C5BB4A.6010802@ti.com>
Message-ID: <52C5BFE3.6050408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 January 2014 02:17 PM, Santosh Shilimkar wrote:
> On Thursday 02 January 2014 12:26 PM, Russell King - ARM Linux wrote:
>> warning: (ARCH_KEYSTONE && SPI_DAVINCI) selects TI_EDMA which has unmet direct dependencies (DMADEVICES && (ARCH_DAVINCI || ARCH_OMAP || ARCH_KEYSTONE))
>>
>> This results in the EDMA engine code not being built.  Yet another
>> example of why improper use of the "select" statement is bad news
>> and leads to broken configurations.
>>
> Thanks for reporting Russell. Will have a look.
> 
Just to be clear for records, the select was introduced before
KEYSTONE support was enabled. As per git blame, it came via commit
b5f1433059 {spi: davici - make davinci select edma}.

Regards,
Santosh
