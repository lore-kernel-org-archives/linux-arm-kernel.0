From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 25 Jan 2017 15:35:34 +0000
Subject: [PATCH 0/8] serial: st-asc: Allow handling of RTS line
In-Reply-To: <20170125100722.GB17954@kroah.com>
References: <20170124134310.27512-1-lee.jones@linaro.org>
 <20170125100722.GB17954@kroah.com>
Message-ID: <20170125153534.GB19242@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Jan 2017, Greg KH wrote:

> On Tue, Jan 24, 2017 at 01:43:02PM +0000, Lee Jones wrote:
> > When hardware flow-control is disabled, manual toggling of the UART's
> > reset line (RTS) using userland applications (e.g. stty) is not
> > possible, since the ASC IP does not provide this functionality in the
> > same was as some other IPs do.  Thus, we have to do this manually.
> > 
> > This set ensures the correct Pinctrl groups are configured and
> > obtained for both manual toggling of the RTS line and for the IP to
> > take over the lines when HW flow-control is requested by the user.
> > 
> > Lee Jones (8):
> >   serial: st-asc: Ignore the parity error bit if 8-bit mode is enabled
> >   serial: st-asc: Provide RTS functionality
> >   serial: st-asc: Read in all Pinctrl states
> >   serial: st-asc: (De)Register GPIOD and swap Pinctrl profiles
> >   ARM: dts: STiH410-b2260: Identify the UART RTS line
> >   ARM: dts: STiH407-pinctrl: Add Pinctrl group for HW flow-control
> >   ARM: dts: STiH407-family: Use new Pinctrl groups
> >   ARM: dts: STiH407-family: Enable HW flow-control
> > 
> >  arch/arm/boot/dts/stih407-family.dtsi  |  7 +--
> >  arch/arm/boot/dts/stih407-pinctrl.dtsi | 12 ++++-
> >  arch/arm/boot/dts/stih410-b2260.dts    |  1 +
> >  drivers/tty/serial/st-asc.c            | 98 +++++++++++++++++++++++++++++++---
> >  4 files changed, 105 insertions(+), 13 deletions(-)
> > 
> 
> I'll ignore this series due to the kbuild problems :(

It's strange.

These didn't happen locally ... and aiaiai was also happy.

Nevertheless, I will fix-up and resend.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
