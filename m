From: p.paneri@samsung.com (Praveen Paneri)
Date: Wed, 22 Jun 2011 13:43:54 +0530
Subject: [RFC][PATCH 0/5] USB: DWC OTG: Add dwc_otg driver for S5P6440
	samsung SoC.
In-Reply-To: <004301cc3011$d92e28c0$8b8a7a40$%szyprowski@samsung.com>
References: <0LN400GHXZI488M0@mailout1.samsung.com>
	<BANLkTi=P-kwd-sd2-91mNUkSbVs==bxrqw@mail.gmail.com>
	<004301cc3011$d92e28c0$8b8a7a40$%szyprowski@samsung.com>
Message-ID: <BANLkTi=UenDcD4=vC+37mL7r8CHCguySZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Jun 21, 2011 at 6:20 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> On Tuesday, June 21, 2011 2:36 PM Praveen Paneri wrote:
>
>> On Tue, Jun 21, 2011 at 4:21 PM, PRAVEEN PANERI <p.paneri@samsung.com>
>> wrote:
>> Hi,
>> >
>> > Hello,
>> >
>> > On Tuesday, June 21, 2011 9:04 AM p.paneri at samsung.com wrote:
>> >
>> > > From: Praveen Paneri
>> > >
>> > > These patches modify DWC OTG driver for ARM and add it for ARM based
>> SoCs.
>> > > Currently it has been tested for Samsung's S5P6440. The development is
>> > > still
>> > > under process so these are not the best set of patches. They are just
>> for
>> > > review
>> > > and not for merge. Intent of these patches is to show required
>> > > modifications
>> > > to make dwc_otg patches work on ARM.
>> >
>> > What are the differences between DWC OTG hardware and OTG hardware found
>> > in s3c64xx/s5pc100/s5pv210 and Exynos4 SoCs series? I've did a brief look
>> > at register definitions and most of them looks same. Can this driver be
>> > merged with s3c-hsotg.c driver?
>> Yes they are same because they all use the same OTG IP. This driver
>> provides
>> functionalities of both host and gadget while s3c-hsotg.c is only a
>> gadget driver.
>
> I'm perfectly aware that s3c-hsotg is just for UDC functionality. I
> just wanted to ask if this driver can replace s3c-hsotg.c driver
> completely?
Yes it can, given we are ready for required modification in this for all the
gadgets(if required) to work as expected.
>
>> If you think this can be merged in s3c-hsotg to make that work in
>> smiler fashion
>> then go ahead but will that work on platforms other than ARM?
>
> You can always create so called variants of the driver that exports
> different functionality depending on the platform data the driver has
> been bound to. Usually it is used to distinguish different models of
> the hardware that has a lot in common. For example please refer to
> driver/media/video/s5p-fimc/fimc-core.c and fimc_driver_ids array in
> the bottom of the code.
That is why this exercise is done. We do not want to create different varients
and want to make it work across SoCs. That is the challenge. I have it
working for
S5P64X0 and may be it can work for others too with minimal changes only in the
platform side code and not in the driver. I am yet to try this with
other boards.
>
>> >
>> > > Following features are tested for basic functions on SMDK6440
>> > > board after modifications:
>> > > OTG HOST: HID and mass-storage
>> > > OTG DEVICE: mass-storage and adb
>> >
>> > Does it mean that HID or mass-storage (both host or gadget drivers) needs
>> > modifications to get them working with this DWC OTG driver?
>>
>> Why would we need any other driver if DWC OTG driver is working both
>> as host and gadget?
>
> You got me wrong. I wanted to ask if one needs to tweak in mass storage
> driver to get it working with DWC OTG driver? I'm asking because I've
> already seen a lot of scary code on some public Android trees, where mass
> storage was hacked to workaround bugs (or flaws) in the OTG driver.
Okay, No changes required in mass storage driver. Just the changes shown
in the patch.
>
> Have you tried your DWC OTG driver with some more demanding gadget
> drivers? One of such is g_multi which exports 3 usb functions (RNDIS,
> ACM serial and Mass Storage) in a composite device.
No,Only with adb and mass storage. But I am planning to do that off-course.

paneri
>
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
