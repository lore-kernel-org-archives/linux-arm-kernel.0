From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Wed, 02 Jul 2014 10:12:21 +0800
Subject: [PATCH 2/3] mtd: hisilicon: add a new nand controller driver
 for hisilicon hip04 Soc
In-Reply-To: <C3050A4DBA34F345975765E43127F10F2C15561F@SZXEMA512-MBX.china.huawei.com>
References: <1404115409-20200-1-git-send-email-wangzhou.bry@gmail.com>
 <1404115409-20200-3-git-send-email-wangzhou.bry@gmail.com>
 <6920327.DpBe6vKVPa@wuerfel>
 <C3050A4DBA34F345975765E43127F10F2C15561F@SZXEMA512-MBX.china.huawei.com>
Message-ID: <53B36A85.2010104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?06?30? 17:59, Caizhiyong wrote:
>> -----Original Message-----
>> From: Arnd Bergmann [mailto:arnd at arndb.de]
>> Sent: Monday, June 30, 2014 5:01 PM
>> To: linux-arm-kernel at lists.infradead.org
>> Cc: Zhou Wang; Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar
>> Gala; Russell King; David Woodhouse; Brian Norris; Grant Likely; Ezequiel
>> Garcia; Pekon Gupta; Artem Bityutskiy; Alexander Shiyan; Ivan Khoronzhuk;
>> Jussi Kivilinna; Joern Engel; Randy Dunlap; devicetree at vger.kernel.org;
>> linux-mtd at lists.infradead.org; linux-doc at vger.kernel.org;
>> linux-kernel at vger.kernel.org; Caizhiyong; Wangzhou (B)
>> Subject: Re: [PATCH 2/3] mtd: hisilicon: add a new nand controller driver for
>> hisilicon hip04 Soc
>>
>>
>>> +	struct device		*dev;
>>> +	void __iomem		*iobase;
>>> +	struct completion       cmd_complete;
>>> +	unsigned int		offset;
>>> +	unsigned int		command;
>>> +	int			chipselect;
>>> +	unsigned int		addr_cycle;
>>> +	unsigned int		addr_value[2];
>>> +	unsigned int		cache_addr_value[2];
>>> +	char			*buffer;
>>> +	dma_addr_t		dma_buffer;
>>> +	dma_addr_t		dma_oob;
>>> +	int			version;
>>> +	unsigned int            ecc_bits;
>>> +	unsigned int            irq_status; /* interrupt status */
>>> +
>>> +	int (*send_cmd_pageprog)(struct hinfc_host *host);
>>> +	int (*send_cmd_status)(struct hinfc_host *host);
>>> +	int (*send_cmd_readstart)(struct hinfc_host *host);
>>> +	int (*send_cmd_erase)(struct hinfc_host *host);
>>> +	int (*send_cmd_readid)(struct hinfc_host *host);
>>> +	int (*send_cmd_reset)(struct hinfc_host *host, int chipselect);
>>> +};
>>
>> Why do you need function pointers here? The current version of the
>> driver you posted always assigns these to the same functions, so
>> it would be more efficient to just call those directly.
>>
>
> I agree with you.
> This feature was originally designed to support a variety version of NAND controllers.
> But in fact, this feature is not used now.
>
I will move them out the host, thanks for your opinion!
