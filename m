From: vigneshr@ti.com (Vignesh R)
Date: Wed, 16 Sep 2015 15:37:11 +0530
Subject: [PATCH 3/5] mtd: devices: m25p80: add support for mmap read
 request
In-Reply-To: <20150914182704.GD12027@sirena.org.uk>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-4-git-send-email-vigneshr@ti.com>
 <20150914182704.GD12027@sirena.org.uk>
Message-ID: <55F93F4F.1010704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/14/2015 11:57 PM, Mark Brown wrote:
> On Fri, Sep 04, 2015 at 02:00:00PM +0530, Vignesh R wrote:
> 
>> +	if (spi->master->spi_mtd_mmap_read) {
>> +		return  spi->master->spi_mtd_mmap_read(spi, from, len,
>> +						       retlen, buf,
>> +						       nor->read_opcode,
>> +						       nor->addr_width,
>> +						       dummy);
>> +	}
> 
> We should be calling some API provided by the SPI core here, not peering
> directly into the ops struture.
> 

Ok..
-- 
Regards
Vignesh
