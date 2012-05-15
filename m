From: stigge@antcom.de (Roland Stigge)
Date: Tue, 15 May 2012 17:56:32 +0200
Subject: [PATCH] MTD: LPC32xx MLC NAND driver
In-Reply-To: <4FB27B24.3030604@antcom.de>
References: <1337091832-10138-1-git-send-email-stigge@antcom.de>
 <20120515143428.GC13860@n2100.arm.linux.org.uk> <4FB27B24.3030604@antcom.de>
Message-ID: <4FB27CB0.8000308@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2012 05:49 PM, Roland Stigge wrote:
>>> +
>>> +	sg_init_one(&host->sgl, mem, len);
>>> +
>>> +	res = dma_map_sg(host->dma_chan->device->dev, &host->sgl, 1, dir);
>>
>> Also note that dma transfer directions and dma data directions are
>> different things.  You shouldn't mix the two.

Can I safely use DMA_BIDIRECTIONAL here (practically, it works - just
tested), because the caller asks for read _or_ write? Or do I need to
formally convert enum dma_transfer_direction to enum dma_data_direction?

Thanks in advance,

Roland
