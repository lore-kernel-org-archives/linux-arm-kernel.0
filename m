From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 12:07:05 +0200
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <53D766A2.1070004@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <53D67703.7090306@arm.com> <53D766A2.1070004@linaro.org>
Message-ID: <5204108.U2T4GFhQeP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 July 2014 10:17:22 Graeme Gregory wrote:
> On 28/07/2014 17:14, Andre Przywara wrote:
> >
> > On 28/07/14 16:23, Arnd Bergmann wrote:
> >> On Monday 28 July 2014 15:20:06 Andre Przywara wrote:
> >>> On 28/07/14 11:46, Arnd Bergmann wrote:
> >>>> On Monday 28 July 2014 10:23:57 Graeme Gregory wrote:
> >>>>> The PL011 UART is the use-case I keep hitting, that IP block has a
> >>>>> variable input clock on pretty much everything I have seen in the wild.
> >>>> Ok, I see. What does ACPI-5.1 say about pl011?
> >>>>
> >>>> Interestingly, the subset of pl011 that is specified by SBSA does not
> >>>> contain the IBRD/FBRD registers, effectively making it a fixed-rated
> >>>> UART (I guess that would be a ART, without the U then), and you
> >>>> consequently don't even need to know the clock rate.
> >>> The idea of this was probably to let the baudrate set by some firmware
> >>> code to the "right" value and the spec just didn't want to expose the
> >>> details for the generic UART:
> >>> "This specification does not cover registers needed to configure the
> >>> UART as these are considered hardware-specific and will be set up by
> >>> hardware-specific software."
> >>> To me that reads like the SBSA UART is just for debugging, and you are
> >>> expected just to access the data register.
> >> Right, makes sense. It also avoids the case where Linux for some reason
> >> ends up using a different line rate than the firmware, which can
> >> cause a lot of unnecessary pain.
> I must be suffering snow blindness reading specs, I totally missed that 
> the pl011 subset does not allow baud setting. This means that my current 
> test hardware "Juno" does not actually need any clocks defined in DSDT 
> at this stage (given that this new driver is created).
> 
> I may then return to my original opinion of not defining clocks in the 
> DSDT at all.

Ok, that certainly simplifies it a lot, thanks!

	Arnd
