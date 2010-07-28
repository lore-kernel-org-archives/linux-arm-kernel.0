From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Wed, 28 Jul 2010 10:53:17 +0200
Subject: [PATCHv2 2/4] mm: cma: Contiguous Memory Allocator added
In-Reply-To: <20100727120841.GC11468@n2100.arm.linux.org.uk>
References: <cover.1280151963.git.m.nazarewicz@samsung.com>
	<743102607e2c5fb20e3c0676fadbcb93d501a78e.1280151963.git.m.nazarewicz@samsung.com>
	<dc4bdf3e0b02c0ac4770927f72b6cbc3f0b486a2.1280151963.git.m.nazarewicz@samsung.com>
	<20100727120841.GC11468@n2100.arm.linux.org.uk>
Message-ID: <op.vgjpm3it7p4s8u@pikus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static inline dma_addr_t __must_check
>> +cma_alloc(const struct device *dev, const char *kind,
>> +	  size_t size, dma_addr_t alignment)
>> +{
>> +	return dev ? -EINVAL : __cma_alloc(dev, kind, size, alignment);

On Tue, 27 Jul 2010 14:08:41 +0200, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> So I can't use this to allocate memory for anything but a NULL device?

>> +static inline int
>> +cma_info(struct cma_info *info, const struct device *dev, const char *kind)
>> +{
>> +	return dev ? -EINVAL : __cma_info(info, dev, kind);

> This won't return information for anything but a NULL device?

Obviously a bug.  Thanks for spotting that.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
