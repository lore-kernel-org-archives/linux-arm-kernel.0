From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jan 2014 10:31:59 +0800
Subject: DT include files
In-Reply-To: <CACRpkdYPrso7KSfWPhZC6chA4z=+YSjKb_SCLx4B-aMmYZYb4A@mail.gmail.com>
References: <20140103023211.GA25079@S2101-09.ap.freescale.net>
 <201401111415.29395.arnd@arndb.de>
 <20140112032516.GA23525@S2101-09.ap.freescale.net>
 <201401122121.20084.arnd@arndb.de>
 <CACRpkdYPrso7KSfWPhZC6chA4z=+YSjKb_SCLx4B-aMmYZYb4A@mail.gmail.com>
Message-ID: <20140113023157.GC23525@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 12:16:10AM +0100, Linus Walleij wrote:
> > I'm also surprised that you have to know multiple constants
> > (mux register, input register, config register offsets) to select a
> > particular pin. I would have expected that you could have one constant
> > from which the driver is able to compute the other ones.
> 
> I might have merged this but I was younger then :-/
> 
> Now I don't like the looks of this. I think the DT typically shall not
> store register offsets and bitfield information. I think doing
> so is taking away the responsibility of the driver knowing the
> hardware and moving too close to Open Firmware.

We only have data in device tree, and drivers, at least imx pinctrl
driver, still need to know hardware for how to apply these data into
hardware.

As I just replied to Arnd, all the motivation of having these data in
device tree is to release kernel from being bloated by those huge mount
of data due to the complexity and flexibility of IMX pin controller.

Shawn
