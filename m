From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 27 Sep 2011 11:48:07 +0300
Subject: [PATCH 3/4] iommu/exynos: Add iommu driver for Exynos4 Platforms
In-Reply-To: <CAHQjnOPdsf-QB3st94WRSH325j8WPOLLe4rqv0WN1qK1KYWtmA@mail.gmail.com>
References: <15669786.49881316849426265.JavaMail.weblogic@epml24>
	<CAK=WgbYnGjPKs6_nmFRGfMnbh_7wDR-0QcptAGaqDKVOo-x3cg@mail.gmail.com>
	<CAHQjnOOtVHUS3KmBz7LdO88fLQyLA6f-w3ye9nAH0Bx+zh38XA@mail.gmail.com>
	<CAK=Wgbazwz9PRJSpZjopwxJ-PO88FtajmbXL=pVKDHOr1t61fQ@mail.gmail.com>
	<CAHQjnON7dksupFeAYLuYXX2PhgjX-GXEGJiy0dRTmpoBjbURVg@mail.gmail.com>
	<CAK=WgbaOwe8Q19tpZMeHdvyCj8fcV194zA-oSD20tF7j7_MvpQ@mail.gmail.com>
	<CAHQjnOM_KTiqzYnePScMHQ3bg5X1wqa4zu6=1A1z7UWeDxVZvQ@mail.gmail.com>
	<CAK=WgbYzZKTRRf6hk=L5ZvXmFAUpq66Ud3F7xh2-8j6zSvAq9g@mail.gmail.com>
	<CAHQjnOPdsf-QB3st94WRSH325j8WPOLLe4rqv0WN1qK1KYWtmA@mail.gmail.com>
Message-ID: <CAK=Wgbbf2XbDrp6q5G3_7og+0wsmFmqpCsx_nDYTyRTa0-YBmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 3:56 AM, KyongHo Cho <pullip.cho@samsung.com> wrote:
> I wanted the IOMMU driver to provide default fault handler to its users
> that does not provide fault handler for debugging purpose.
> If a user want to handle MMU fault, IOMMU driver welcomes to overwrite
> the existing 'default' fault handler.

Ok, this one patch below should allow you to do that.
report_iommu_fault() will now reliably tell you if a fault handler
failed or not, or if one isn't even installed.

This way your IOMMU driver doesn't need to define a fault handler of
its own, and instead, can do everything directly in
exynos_sysmmu_irq() where all the required information is now
available.

Thanks,
Ohad.
