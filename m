From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 28 Feb 2017 19:32:09 +0100 (CET)
Subject: usb/net/hso: WARNING: ungligned urb->setup_dma
In-Reply-To: <20170228180700.3fxpimfysnhm6uis@tarshish>
References: <20170228082810.syn656o2zzms7urf@tarshish>
 <20170228120134.4f65yihw7x22hfwd@tarshish>
 <36230d64-4ba0-7515-1131-ecf3ab9f352c@i2se.com>
 <20170228180700.3fxpimfysnhm6uis@tarshish>
Message-ID: <1515966850.16584.1488306729844@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

> Baruch Siach <baruch@tkos.co.il> hat am 28. Februar 2017 um 19:07 geschrieben:
> 
> 
> Hi Stefan,
> 
> On Tue, Feb 28, 2017 at 05:21:18PM +0100, Stefan Wahren wrote:
> > Am 28.02.2017 um 13:01 schrieb Baruch Siach:
> > > On Tue, Feb 28, 2017 at 10:28:10AM +0200, Baruch Siach wrote:
> > > > I'm hitting this warning consistently on my Raspberry Pi 3 running 
> > > > kernel
> > > > v4.10.1 with some unrelated device tree changes, and a debug print (below).
> > > > The device identifies as "GlobeTrotter HSDPA Modem", VID: 0af0, PID: 6971.
> > > > The warning triggers consistently on first write access to /dev/ttyHS0 that
> > > > ModemManager attempts. The first line in the log is my debug print.
> > > I tested the same hardware successfully on an i.MX6 CuBox-i (ARM32) using the
> > > same kernel version (4.10.1), and on an x86_64 PC (4.9). So this seems to be
> > > platform specific. I don't have any other ARM64 machine at the moment, though.
> > 
> > those platforms usually doesn't use the dwc2 USB host controller. So it
> > should be tested with another dwc2 platform.
> 
> The code that initializes setup_dma is not under drivers/usb/dwc2/. Though the 
> problem looks like memory corruption, so its cause might be anywhere.

only a suspicion, but could you please try this patch [1]?

[1] - https://patchwork.kernel.org/patch/9166771/
