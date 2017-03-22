From: briannorris@chromium.org (Brian Norris)
Date: Wed, 22 Mar 2017 10:57:40 -0700
Subject: [PATCH v3 2/4] arm64: dts: rockchip: add Gru/Kevin DTS
In-Reply-To: <2390473.XAgkTqANPY@phil>
References: <20170320235344.126298-1-briannorris@chromium.org>
 <20170320235344.126298-3-briannorris@chromium.org>
 <2390473.XAgkTqANPY@phil>
Message-ID: <20170322175739.GB98450@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 12:59:37PM +0100, Heiko Stuebner wrote:
> Am Montag, 20. M?rz 2017, 16:53:42 CET schrieb Brian Norris:
> > Kevin is part of a family of boards called Gru. As best as possible, the
> > properties shared by the Gru family are placed in rk3399-gru.dtsi, while
> > Kevin-specific bits are in rk3399-gru-kevin.dts. This does not add full
> > support for the base Gru board.
> > 
> > Working and tested (to some extent):
> >  * EC support -- including keyboard, battery, PWM, and probably more
> >  * UART / console
> >  * Thermal
> >  * Touchscreen
> >  * Touchpad
> >  * Digitizer (regulator still WIP)
> >  * PCIe / Wifi
> >  * Bluetooth / Webcam
> >  * SD card
> >  * eMMC
> >  * USB2 on TypeC
> >    - This works much of the time, but USB3 devices may or may not detect
> >      properly. Waiting on proper extcon support for USB3 over TypeC.
> >    - Depends on XHCI/DWC3 fixes for ARM64 that still haven't landed
> >  * Backlight
> > 
> > Not working:
> >  * CPUFreq -- relies on special OVP support for our PWM regulator
> >    circuits
> >  * EC / extcon support -- and with it, USB3/TypeC/DP
> >  * DRM -- won't even build on ARM64, so all display, eDP, etc. is not
> >    enabled
> > 
> > Not tested:
> >  * Audio
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> applied for 4.12 with Enric's Tested-tag after some reordering of nodes/
> properties.

I realize I didn't catch 100% of the comments you wanted dropped. Thanks
for cleaning it.

Brian
