From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Tue, 5 Nov 2013 12:42:03 +0530
Subject: [PATCH RFC 1/4] phy: Add new Exynos5 USB 3.0 PHY driver
In-Reply-To: <CAFp+6iG5SAe5h0-RRsBuAhtWO_NBW6G=7jQeObd4Y2BQGaRHyA@mail.gmail.com>
References: <1383205544-32244-1-git-send-email-gautam.vivek@samsung.com>
 <1383205544-32244-2-git-send-email-gautam.vivek@samsung.com>
 <527744B2.4090303@ti.com> <1539581.zprt32081v@amdc1227>
 <CAFp+6iG5SAe5h0-RRsBuAhtWO_NBW6G=7jQeObd4Y2BQGaRHyA@mail.gmail.com>
Message-ID: <CAFp+6iF443AR1SKPxozdGn2Y-Dm+pSwh5Xx9FFvNqGyRz9k7xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 11:06 AM, Vivek Gautam <gautamvivek1987@gmail.com> wrote:
> Hi Tomasz,

Sorry my mail client had some problem, so forwarding this again.

>
> On Nov 4, 2013 5:59 PM, "Tomasz Figa" <t.figa@samsung.com> wrote:
>>
>> Hi Kishon,
>>
>> On Monday 04 of November 2013 12:24:42 Kishon Vijay Abraham I wrote:
>> > Hi Vivek,
>> >
>> > On Thursday 31 October 2013 01:15 PM, Vivek Gautam wrote:
>> > > Add a new driver for the USB 3.0 PHY on Exynos5 series of SoCs.
>> > > The new driver uses the generic PHY framework and will interact
>> > > with DWC3 controller present on Exynos5 series of SoCs.
>> >
>> > In Exynos, you have a single IP that supports both USB3 and USB2 PHY
>> > right? I think that needs to be mentioned here.
>>
>> Nope. There are two separate, different IPs.
>
> AFAICS the dwc3 controller (aka usb 3.0 drd controller, as mentioned in
> exynos5 UM) uses a combo of usb 2 (utmi+) and usb 3 (pipe 3) phy (with base
> address starting 0x12100000), thereby giving the driver only freedom to
> control them as one. The entire set of registers with base 0x12100000 for
> exynos5250 and later 0x12500000 for exynos5420 are being programmed by this
> driver. That's the reason i structured the driver this way, and thereby it
> makes the dwc3 controller to just use only single phy.
> Please correct me if i am wrong.
>
>>
>> > Do you have separate registers that should be used for
>> > initializing/powerin_on/powering_off etc.. for usb2 phy and usb3 phy? If
>> > so, then you should model this driver as a single driver that supports
>> > two PHYs similar to what Sylwester has done before?
>>
>> Sylwester's MIPI PHY uses such model because it has a single register
>> that controls both PHYs.
>>
>> Best regards,
>> Tomasz
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
