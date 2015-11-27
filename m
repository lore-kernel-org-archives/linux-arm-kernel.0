From: tony@atomide.com (Tony Lindgren)
Date: Fri, 27 Nov 2015 06:51:32 -0800
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <20151127083833.GA430@pali>
References: <20150713131902.GH26485@atomide.com> <20151123144545.GD24147@pali>
 <20151125181644.GI2517@atomide.com> <17134653.86P3dFyQKK@wuerfel>
 <20151125210310.GT2517@atomide.com> <56568849.5080103@gmail.com>
 <20151126090739.GD14190@pali> <20151126203930.GW2517@atomide.com>
 <20151127083833.GA430@pali>
Message-ID: <20151127145131.GX2517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [151127 00:39]:
> On Thursday 26 November 2015 12:39:30 Tony Lindgren wrote:
> > Just to explore options.. How about make a minimal device driver that
> > just loads the atags blob from /lib/firmware and then shows it in
> > /proc/atags? Of course some checking on the atags should be done by
> > the driver..
> 
> And who can dynamically create that blob file in /lib/firmware? If
> kernel does not export those atags (somehow) from bootloader, then
> userspace is not able to create that blob... cyclic problem.
> 
> So no, problem is that bootloader provides via custom atags dynamic
> information like: boot reason (how was device started, by rtc alarm? by
> reboot? by usb charger? by power button?), boot mode (should be enter
> into firmware update mode?, is this normal boot mode?), ... and those
> information are needed for some proprietary software (e.g. firmware
> upgrade/flash) but also by any other open source applications (based on
> usb charger we enter different runlevel -- for just only charging
> device).

OK if the ATAGs are not static then naturally we can't create the blobs
then.

Regards,

Tony
