From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Jan 2014 15:26:42 -0800
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <201401192128.54413.arnd@arndb.de>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1401171157340.28907@knanqh.ubzr>
 <CAOesGMjVpTEku+UJntewi3FXoeEPe9rJP4BBmbSesfFMtY9hnA@mail.gmail.com>
 <201401192128.54413.arnd@arndb.de>
Message-ID: <20140119232642.GA4775@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 09:28:53PM +0100, Arnd Bergmann wrote:
> On Sunday 19 January 2014, Olof Johansson wrote:
> > The "multi-slot" concept I was talking about was one host controller
> > for several physical slots. Seems like at91 implements and uses this
> > but nobody else. However, it seems that they allocate one mmc host per
> > slot, so the same model still works.
> > 
> 
> IIRC dw-mci also has multiple slots, and it's a common host controller
> in a number of SoCs. I don't know how many of them actually support
> multiple slots rather than a simplified single-slot version of
> that controller.

Right, that's the main one i had in mind -- the binding, and the driver, allow
for multiple slots but we've been searching high and low for an actual SoC that
implements that, and none seem to do it. So the additional overhead is just
wasted, and there's been talk of bringing the binding more in line with
a single-slot driver instead. It makes a lot of sense to do.


-Olof
