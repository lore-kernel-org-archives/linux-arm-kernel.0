From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Jan 2015 11:59:15 +0000
Subject: ask for help about swiotlb buffer is full
In-Reply-To: <54CB5AA4.7050705@huawei.com>
References: <54CB5820.9020102@huawei.com>
 <54CB5AA4.7050705@huawei.com>
Message-ID: <20150130115915.GB27542@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 10:19:16AM +0000, Kefeng Wang wrote:
> On 2015-01-30 18:08, Kefeng Wang wrote:
> >   There is an AHCI compliant SATA controller in our arm64 soc, and
> >   it only supports 32bit DMA(used coherent dma_ops). It works well
> >   in v3.16. Recently, we update kernel from linux v3.16 to linux
> >   v3.19-rc4(use defconfig in arm64), but we get errors when test
> >   sata driver, as follows.
> > 
> > ------------------------------------------------------------------------------
> > ahci b1002800.sata: swiotlb buffer is full (sz: 65536 bytes)
> > DMA: Out of SW-IOMMU space for 65536 bytes at device b1002800.sata

Do you use a 64KB page kernel configuration?

What does your kernel log say about "software IO TLB [mem ...]"?

-- 
Catalin
