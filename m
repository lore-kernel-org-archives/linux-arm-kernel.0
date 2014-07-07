From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 7 Jul 2014 18:23:09 +0300
Subject: [PATCH v2 1/2] gpio: Add driver for Zynq GPIO controller
In-Reply-To: <CACRpkdb1M3-hrSKLKWz21LCJ1sMvsq5E-aqkpmVhy0NwOS5HhA@mail.gmail.com>
References: <1403091577-10232-1-git-send-email-harinik@xilinx.com>
 <5cc8b89b-20ff-4fa9-92dd-bb2f6d3512d8@BY2FFO11FD030.protection.gbl>
 <CACRpkdb1M3-hrSKLKWz21LCJ1sMvsq5E-aqkpmVhy0NwOS5HhA@mail.gmail.com>
Message-ID: <20140707152309.GH4939@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linux,

On Mon, Jul 07, 2014 at 04:51:56PM +0200, Linus Walleij wrote:
> On Wed, Jun 18, 2014 at 5:36 PM, S?ren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> > The first is, how is userspace supposed to find the correct offset for a
> > GPIO pin.
> 
> The sysfs interface to GPIO is *NOT* *GOOD* this is universally
> agreed upon.
> 
> This needs someone to step in and provide a replacement, my preferred
> mechanism would be a /dev/gpiochip0/... hierarchy using char devices.

I really like the ability to control GPIOs from shell, both interactively and 
scripted. I find it useful for quick hardware level debugging, and for boot 
time scripting (mainly in initramfs). Do you intend to preserve this 
capability in the future? Will I need a special utility (or Busybox applet) to 
do this with char device ioctl?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
