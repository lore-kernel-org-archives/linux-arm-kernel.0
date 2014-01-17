From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 17 Jan 2014 10:39:10 +0100
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <20140116195819.GY15937@n2100.arm.linux.org.uk>
 <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
Message-ID: <20140117093909.GB2348@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 12:00:47PM -0800, Olof Johansson wrote :
> On Thu, Jan 16, 2014 at 11:58 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jan 16, 2014 at 09:15:17AM -0800, Olof Johansson wrote:
> >> We've dealt with it with local code in our tree for Chrome OS, and I
> >> suspect everyone else has too. It's definitely time to solve
> >> generically.
> >
> > As there's no code for any Cubox-i or Hummingboard (they're both purely
> > DT), what this means is that the answer to Wifi/BT support in mainline is
> > that this is "impossible at the moment"...
> >
> > I guess this is becoming a higher priority issue which really needs to be
> > solved somehow. :)
> 
> I'm looking at it right now actually, might as well sort it out while
> people are paying attention. Patches a little later today unless I get
> distrac^Winterrupted. :)
> 

Maybe it is not completely related but I think it needs to be thought
about while you are it:

The TI wilink chips (TiWi, wl12xx, wl18xx) have wifi on SDIO and BT on
UART but they share the same clock. So, the next question would be what
if I just want to enable one or the other (and take that decision at
runtime) ?

Where do I put the pinctrl/clocks/regulators in the DT ? I guess it can
become an issue to enable both WiFi and BT at the same time if both SDIO
and UART are trying to handle the same pinctrl and regulators.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140117/4f42f4b4/attachment.sig>
