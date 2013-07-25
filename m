From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 25 Jul 2013 17:26:48 -0300
Subject: Enabling USBH1 on mx53qsb
In-Reply-To: <8738r2wxcx.fsf@lebrac.rtp-net.org>
References: <CAOMZO5CAdxzn-3Xc2DZDYEXwsEznRrcqPbCbTDc5ieBkQkA8=g@mail.gmail.com>
 <8738r2wxcx.fsf@lebrac.rtp-net.org>
Message-ID: <CAOMZO5CYNAKPFL1LgNGzwyZe9aCP9NHEXJFx+ymiqQf=QVx9YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Thu, Jul 25, 2013 at 11:03 AM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:

> Given that the same gpio controls vbus for both ports, my current guess
> is something on port configuration side (I guess the board would freeze
> hard if a clock is not enabled).

I agree.

Did a quick test: in U-boot I read the value of USB_UH1_PORTSC1, which
is 0xdc000000 right after reset.

If I only change the PTS field to 00 (write 1c000000), which
configures UTMI mode, then USBH1 can work in Linux.

So we have a bug in the chipidea driver not writing to USBH1 PORTSC
register even if I pass the "phy_type" via dt.
