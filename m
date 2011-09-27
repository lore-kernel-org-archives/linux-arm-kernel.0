From: pullip.cho@samsung.com (KyongHo Cho)
Date: Tue, 27 Sep 2011 18:01:00 +0900
Subject: [PATCH 3/4] iommu/exynos: Add iommu driver for Exynos4 Platforms
In-Reply-To: <CAK=Wgbbf2XbDrp6q5G3_7og+0wsmFmqpCsx_nDYTyRTa0-YBmg@mail.gmail.com>
References: <15669786.49881316849426265.JavaMail.weblogic@epml24>
	<CAK=WgbYnGjPKs6_nmFRGfMnbh_7wDR-0QcptAGaqDKVOo-x3cg@mail.gmail.com>
	<CAHQjnOOtVHUS3KmBz7LdO88fLQyLA6f-w3ye9nAH0Bx+zh38XA@mail.gmail.com>
	<CAK=Wgbazwz9PRJSpZjopwxJ-PO88FtajmbXL=pVKDHOr1t61fQ@mail.gmail.com>
	<CAHQjnON7dksupFeAYLuYXX2PhgjX-GXEGJiy0dRTmpoBjbURVg@mail.gmail.com>
	<CAK=WgbaOwe8Q19tpZMeHdvyCj8fcV194zA-oSD20tF7j7_MvpQ@mail.gmail.com>
	<CAHQjnOM_KTiqzYnePScMHQ3bg5X1wqa4zu6=1A1z7UWeDxVZvQ@mail.gmail.com>
	<CAK=WgbYzZKTRRf6hk=L5ZvXmFAUpq66Ud3F7xh2-8j6zSvAq9g@mail.gmail.com>
	<CAHQjnOPdsf-QB3st94WRSH325j8WPOLLe4rqv0WN1qK1KYWtmA@mail.gmail.com>
	<CAK=Wgbbf2XbDrp6q5G3_7og+0wsmFmqpCsx_nDYTyRTa0-YBmg@mail.gmail.com>
Message-ID: <CAHQjnOOGvwo6P1SJXVwzUJDFiUN-QxCxHOWoOMd1+QjubJ2u-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 5:48 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d084e87..2987199 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -98,11 +98,12 @@ extern void iommu_set_fault_handler(struct
> iommu_domain *domain,
> ?* Returns 0 on success and an appropriate error code otherwise (if dynamic
> ?* PTE/TLB loading will one day be supported, implementations will be able
> ?* to tell whether it succeeded or not according to this return value).
> + * If a fault handler isn't installed, -ENOSYS is returned.
> ?*/
> ?static inline int report_iommu_fault(struct iommu_domain *domain,
> ? ? ? ? ? ? ? ?struct device *dev, unsigned long iova, int flags)
> ?{
> - ? ? ? int ret = 0;
> + ? ? ? int ret = -ENOSYS;
>
> ? ? ? ?/*
> ? ? ? ? * if upper layers showed interest and installed a fault handler,
It looks good for me.

I will prepare new patches with the changed API.

Thank you.
Cho KyongHo.
