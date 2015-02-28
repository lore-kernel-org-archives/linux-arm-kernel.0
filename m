From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 28 Feb 2015 10:55:51 +0100
Subject: [PATCHv2 05/15] ARM: mvebu: add stdout-path to all armada-*.dts
In-Reply-To: <CAL_Jsq+tP6wBcDti7x-B6ar8esE=65Ymg_CKANeOKSe=yYhNnw@mail.gmail.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1424451874-25375-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <54EB4E9B.6010001@free-electrons.com>
 <CAL_JsqJZJMkH953hq0_sOvEEu9o4pXxs0sdP5=7c2EXXNSyA9A@mail.gmail.com>
 <20150227174851.390d9f58@free-electrons.com>
 <CAL_Jsq+tP6wBcDti7x-B6ar8esE=65Ymg_CKANeOKSe=yYhNnw@mail.gmail.com>
Message-ID: <20150228105551.7b6532f8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob Herring,

On Fri, 27 Feb 2015 11:42:43 -0600, Rob Herring wrote:

> > Unfortunately, this doesn't seem to work at all:
> 
> This must have all been tested on QEMU (or Fast Models?) which ignores
> baud rate.


Ok.

> >    So it gets the right port name, the right idx, just the options are
> >    null. It shouldn't be an issue since the serial port is already
> >    initialized by the bootloader.
> 
> I think the default baudrate is 9600, not what the bootloader set.

That might explain the issue then.

> You need the full path here though. But garbage should not crash things.

Indeed, I was surprised that a different DT string was crashing the
kernel.


> > It is worth mentioning that this also happens with
> >
> >      stdout-path = "uart0:115200n8";
> >
> > which was explicitly suggested by Mark in his e-mail. uart0 is an alias
> > to the proper DT node, since stdout-path = &uart0; works almost fine.
> 
> Mark forgot the '&'. So does 'stdout-path = "&uart0:115200n8";' work?

I don't have the board at hand right now, will try this on Tuesday when
coming back to the office. Thanks for the suggestion!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
