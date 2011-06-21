From: p.paneri@samsung.com (Praveen Paneri)
Date: Tue, 21 Jun 2011 18:06:20 +0530
Subject: [RFC][PATCH 0/5] USB: DWC OTG: Add dwc_otg driver for S5P6440
	samsung SoC.
In-Reply-To: <0LN400GHXZI488M0@mailout1.samsung.com>
References: <0LN400GHXZI488M0@mailout1.samsung.com>
Message-ID: <BANLkTi=P-kwd-sd2-91mNUkSbVs==bxrqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 21, 2011 at 4:21 PM, PRAVEEN PANERI <p.paneri@samsung.com> wrote:
Hi,
>
> Hello,
>
> On Tuesday, June 21, 2011 9:04 AM p.paneri at samsung.com wrote:
>
> > From: Praveen Paneri
> >
> > These patches modify DWC OTG driver for ARM and add it for ARM based SoCs.
> > Currently it has been tested for Samsung's S5P6440. The development is
> > still
> > under process so these are not the best set of patches. They are just for
> > review
> > and not for merge. Intent of these patches is to show required
> > modifications
> > to make dwc_otg patches work on ARM.
>
> What are the differences between DWC OTG hardware and OTG hardware found
> in s3c64xx/s5pc100/s5pv210 and Exynos4 SoCs series? I've did a brief look
> at register definitions and most of them looks same. Can this driver be
> merged with s3c-hsotg.c driver?
Yes they are same because they all use the same OTG IP. This driver provides
functionalities of both host and gadget while s3c-hsotg.c is only a
gadget driver.
If you think this can be merged in s3c-hsotg to make that work in
smiler fashion
then go ahead but will that work on platforms other than ARM?
>
> > Following features are tested for basic functions on SMDK6440
> > board after modifications:
> > OTG HOST: HID and mass-storage
> > OTG DEVICE: mass-storage and adb
>
> Does it mean that HID or mass-storage (both host or gadget drivers) needs
> modifications to get them working with this DWC OTG driver?
Why would we need any other driver if DWC OTG driver is working both
as host and gadget?
>
> (snipped)
>
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center

paneri
