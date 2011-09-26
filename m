From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon, 26 Sep 2011 18:21:32 +0900
Subject: [PATCH 3/4] iommu/exynos: Add iommu driver for Exynos4 Platforms
In-Reply-To: <CAK=Wgbazwz9PRJSpZjopwxJ-PO88FtajmbXL=pVKDHOr1t61fQ@mail.gmail.com>
References: <15669786.49881316849426265.JavaMail.weblogic@epml24>
	<CAK=WgbYnGjPKs6_nmFRGfMnbh_7wDR-0QcptAGaqDKVOo-x3cg@mail.gmail.com>
	<CAHQjnOOtVHUS3KmBz7LdO88fLQyLA6f-w3ye9nAH0Bx+zh38XA@mail.gmail.com>
	<CAK=Wgbazwz9PRJSpZjopwxJ-PO88FtajmbXL=pVKDHOr1t61fQ@mail.gmail.com>
Message-ID: <CAHQjnON7dksupFeAYLuYXX2PhgjX-GXEGJiy0dRTmpoBjbURVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 6:05 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Mon, Sep 26, 2011 at 11:58 AM, KyongHo Cho <pullip.cho@samsung.com> wrote:
>> As you've noticed, it is default behavior for iommu fault.
>
> Then why not add it to the IOMMU core ? it's quite generic and can be
> useful for others, too.
>
Every fault in IOMMU (System MMU) is an error logically
and must not happen in our multimedia device drivers
because, our device drivers always construct page table completely
before address translation in System MMU
and TLB loads translation information automatically when TLB miss.

I am not sure if the default behavior of MMU fault in our IOMMU driver
is also correct for other IOMMU drivers.

BTW,
I think we need more fault type than IOMMU_FAULT_READ and IOMMU_FAULT_WRITE.
We have page fault, access fault(read, write), security fault
and bus error (translated physical address is not available)

> Thanks,
> Ohad.

Thank you.
Cho KyongHo.
