From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sat, 31 Jan 2015 12:00:06 +0800
Subject: ask for help about swiotlb buffer is full
In-Reply-To: <20150130115915.GB27542@e104818-lin.cambridge.arm.com>
References: <54CB5820.9020102@huawei.com> <54CB5AA4.7050705@huawei.com>
 <20150130115915.GB27542@e104818-lin.cambridge.arm.com>
Message-ID: <54CC5346.5070402@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-01-30 19:59, Catalin Marinas wrote:
> On Fri, Jan 30, 2015 at 10:19:16AM +0000, Kefeng Wang wrote:
>> On 2015-01-30 18:08, Kefeng Wang wrote:
>>>   There is an AHCI compliant SATA controller in our arm64 soc, and
>>>   it only supports 32bit DMA(used coherent dma_ops). It works well
>>>   in v3.16. Recently, we update kernel from linux v3.16 to linux
>>>   v3.19-rc4(use defconfig in arm64), but we get errors when test
>>>   sata driver, as follows.
>>>
>>> ------------------------------------------------------------------------------
>>> ahci b1002800.sata: swiotlb buffer is full (sz: 65536 bytes)
>>> DMA: Out of SW-IOMMU space for 65536 bytes at device b1002800.sata
> 
> Do you use a 64KB page kernel configuration?
> 
> What does your kernel log say about "software IO TLB [mem ...]"?
> 

4kb page,  use Make ARCH=arm64 defconfig in v3.19 to generate config.

[    0.678293] software IO TLB [mem 0x7e800000-0x7ec00000] (4MB) mapped at [ffffffc07e800000-ffffffc07ebfffff]
[    0.686991] DMA: preallocated 256 KiB pool for atomic allocations
