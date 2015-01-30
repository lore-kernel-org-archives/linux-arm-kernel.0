From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 30 Jan 2015 10:44:45 +0000
Subject: ask for help about swiotlb buffer is full
In-Reply-To: <54CB5AA4.7050705@huawei.com>
References: <54CB5820.9020102@huawei.com> <54CB5AA4.7050705@huawei.com>
Message-ID: <54CB609D.60905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kefeng,

On 30/01/15 10:19, Kefeng Wang wrote:
> +cc linux-arm-kernel at lists.infradead.org
>
> On 2015-01-30 18:08, Kefeng Wang wrote:
>> Hi all,
>>
>>    There is an AHCI compliant SATA controller in our arm64 soc, and it only supports 32bit DMA(used coherent dma_ops).
>> It works well in v3.16. Recently, we update kernel from linux v3.16 to linux v3.19-rc4(use defconfig in arm64),
>> but we get errors when test sata driver, as follows.
>>
>> ------------------------------------------------------------------------------
>> ahci b1002800.sata: swiotlb buffer is full (sz: 65536 bytes)
>> DMA: Out of SW-IOMMU space for 65536 bytes at device b1002800.sata
>> ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
>> ata6.00: failed command: WRITE DMA EXT
>> ata6.00: cmd 35/00:0f:05:0d:00/00:38:00:00:00/e0 tag 7 dma 7347712 out
>>           res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x40 (internal error)
>> ata6.00: status: { DRDY }
>> ata6.00: configured for UDMA/133
>> ata6: EH complete
>> -------------------------------------------------------------------------------
>>
>> It's difficult for us to git bisect, could anyone give us some advise, and idea?
>>

If it's not just a case of trying to map bigger buffers than SWIOTLB can 
bounce, you might be hitting the problem that this patch fixes:

http://thread.gmane.org/gmane.linux.kernel/1853766


Robin.
