From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 4 Jul 2010 08:14:09 +0300
Subject: Removing Spin Locks in ARM MXC GPIOs
In-Reply-To: <OF8F24F18F.F4C191D8-ON88257754.006829B2-88257754.006857CC@rockwellcollins.com>
References: <OF8F24F18F.F4C191D8-ON88257754.006829B2-88257754.006857CC@rockwellcollins.com>
Message-ID: <20100704051409.GA19559@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi rpkamiak,

On Fri, Jul 02, 2010 at 11:59:42AM -0700, rpkamiak at rockwellcollins.com wrote:
> Should the GPIO functions in gpio.c (i.e. mxc_gpio_set) perform a spin_lock 
> prior to performing a read modify write operation on GPIO registers ?  They 
> were removed somewhere between 2.6.22(imx31pdk-rel5) and 
> 2.6.31(imx35pdk-rel8). 

Mainline kernel version 2.6.22 doesn't include generic GPIO support for the 
i.MX platform. Nor does 2.6.22 support i.MX31. What you see is probably code 
from Freescale which has never been pushed for mainline inclusion, although, 
according to arch/arm/plat-mxc/gpio.c, it served as a basis for the current 
implementation.

According to git, i.MX GPIO support was introduced in version 2.6.27 (commit 
07bd1a6cc7cbb3f373fbe49b204c6cde5e9155fc).

Spinlock seems to be necessary in _set_gpio_irqenable, _set_gpio_direction and 
mxc_gpio_set. If I have time I'll post an RFC patch later today.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
