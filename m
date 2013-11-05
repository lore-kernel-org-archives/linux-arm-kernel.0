From: k.debski@samsung.com (Kamil Debski)
Date: Tue, 05 Nov 2013 10:36:59 +0100
Subject: [PATCH RFC 1/4] phy: Add new Exynos5 USB 3.0 PHY driver
In-Reply-To: <CAFp+6iH7vQ-OtMFL4pyr4tFDRchH4oh1Z0753WNgrHiUzj+kzw@mail.gmail.com>
References: <1383205544-32244-1-git-send-email-gautam.vivek@samsung.com>
 <1383205544-32244-2-git-send-email-gautam.vivek@samsung.com>
 <527744B2.4090303@ti.com> <030d01ced946$d6e23490$84a69db0$%debski@samsung.com>
 <52779D28.9000905@ti.com>
 <CAFp+6iH7vQ-OtMFL4pyr4tFDRchH4oh1Z0753WNgrHiUzj+kzw@mail.gmail.com>
Message-ID: <00fe01ceda0a$941957a0$bc4c06e0$%debski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> From: Vivek Gautam [mailto:gautamvivek1987 at gmail.com]
> Sent: Tuesday, November 05, 2013 8:20 AM
> To: Kishon Vijay Abraham I
> Cc: Kamil Debski; Vivek Gautam; Linux USB Mailing List; linux-samsung-
> soc at vger.kernel.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-doc at vger.kernel.org; Greg KH; Kukjin Kim; Sylwester Nawrocki;
> Tomasz Figa; Felipe Balbi; Julius Werner; Jingoo Han
> Subject: Re: [PATCH RFC 1/4] phy: Add new Exynos5 USB 3.0 PHY driver
> 
> Hi Kishon,
> 
> 
> 
> On Mon, Nov 4, 2013 at 6:42 PM, Kishon Vijay Abraham I <kishon@ti.com>
> wrote:
> > Hi,
> >
> >
> > On Monday 04 November 2013 03:45 PM, Kamil Debski wrote:
> >>
> >> Hi Kishon,
> >>
> >>> From: Kishon Vijay Abraham I [mailto:kishon at ti.com]
> >>> Sent: Monday, November 04, 2013 7:55 AM
> >>>
> >>> Hi Vivek,
> >>>
> >>> On Thursday 31 October 2013 01:15 PM, Vivek Gautam wrote:
> >>>>
> >>>> Add a new driver for the USB 3.0 PHY on Exynos5 series of SoCs.
> >>>> The new driver uses the generic PHY framework and will interact
> >>>> with
> >>>> DWC3 controller present on Exynos5 series of SoCs.
> >>>
> >>>
> >>> In Exynos, you have a single IP that supports both USB3 and USB2
> PHY
> >>> right? I think that needs to be mentioned here.
> >>
> >>
> >> As far as I know the IP is different.
> >
> >
> > Ok. Sometime back Vivek was mentioning about a single IP for both
> USB3
> > and USB2. Thought it should be this driver. Anyway thanks for the
> clarification.
> 
> Right Kishon, I had mentioned that Exynos5's dwc3 controller have a
> single IP for USB2 and USB3 phy.
> From what i see, on exynos5 systems the dwc3 controller uses a combo of
> usb 2 (utmi+) and usb 3 (pipe 3) phy (with base address starting
> 0x12100000).
> 
> Kamil, Tomasz,
> 
> Please correct me if i am wrong.

I have the Exynos 5250 documentation and I found two phy register ranges:
1) USB 2.0 PHY having the base address of 0x1213 0000
	Chapter 33. USB 2.0 Host Controller
	Subchapter 33.5.2 Phy Control Register p. 1696
	First register's description is
	"USB2.0 phy control register"
2) USB 3.0 PHY (I guess) with the base address 0x1210 0000
	Chapter 35. USB 3.0 DRD Controller
	Subchapter 35.4.6 PHY Control Register p. 1872

Jingoo, could you comment on the above? You may know more than we do :)

In addition, I have a question to you Vivek - does your USB 3.0
PHY support both host and device?

[snip]

Best wishes,
Kamil Debski
