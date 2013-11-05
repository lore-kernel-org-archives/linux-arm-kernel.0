From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 05 Nov 2013 10:34:07 +0100
Subject: [PATCH RFC 1/4] phy: Add new Exynos5 USB 3.0 PHY driver
In-Reply-To: <CAFp+6iH7vQ-OtMFL4pyr4tFDRchH4oh1Z0753WNgrHiUzj+kzw@mail.gmail.com>
References: <1383205544-32244-1-git-send-email-gautam.vivek@samsung.com>
 <52779D28.9000905@ti.com>
 <CAFp+6iH7vQ-OtMFL4pyr4tFDRchH4oh1Z0753WNgrHiUzj+kzw@mail.gmail.com>
Message-ID: <230638605.rENrU3ufJZ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 of November 2013 12:50:18 Vivek Gautam wrote:
> Hi Kishon,
> 
> On Mon, Nov 4, 2013 at 6:42 PM, Kishon Vijay Abraham I <kishon@ti.com> 
wrote:
> > Hi,
> > 
> > On Monday 04 November 2013 03:45 PM, Kamil Debski wrote:
> >> Hi Kishon,
> >> 
> >>> From: Kishon Vijay Abraham I [mailto:kishon at ti.com]
> >>> Sent: Monday, November 04, 2013 7:55 AM
> >>> 
> >>> Hi Vivek,
> >>> 
> >>> On Thursday 31 October 2013 01:15 PM, Vivek Gautam wrote:
> >>>> Add a new driver for the USB 3.0 PHY on Exynos5 series of SoCs.
> >>>> The new driver uses the generic PHY framework and will interact
> >>>> with
> >>>> DWC3 controller present on Exynos5 series of SoCs.
> >>> 
> >>> In Exynos, you have a single IP that supports both USB3 and USB2 PHY
> >>> right? I think that needs to be mentioned here.
> >> 
> >> As far as I know the IP is different.
> > 
> > Ok. Sometime back Vivek was mentioning about a single IP for both USB3
> > and USB2. Thought it should be this driver. Anyway thanks for the
> > clarification.
> Right Kishon, I had mentioned that Exynos5's dwc3 controller have a
> single IP for USB2 and USB3 phy.
> From what i see, on exynos5 systems the dwc3 controller uses a combo
> of usb 2 (utmi+) and usb 3 (pipe 3) phy
> (with base address starting 0x12100000).

I meant there is a single PHY used with the USB 3.0 controller (dwc3) and 
it is different from the PHY used with the USB 2.0 controller (s3c-hsotg 
aka dwc2). The USB 3.0 PHY and controller blocks also support USB 2.0 
operation, though. So we were both right. ;)

Best regards,
Tomasz
