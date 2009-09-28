From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 28 Sep 2009 21:18:52 +0200
Subject: [PATCH] Make MMCI driver compile without gpiolib
In-Reply-To: <63386a3d0909281200m1da30d22h4ea4fb72278941de@mail.gmail.com>
References: <1251276988-27882-1-git-send-email-linus.walleij@stericsson.com>
	<20090927153108.GA20093@n2100.arm.linux.org.uk>
	<63386a3d0909281200m1da30d22h4ea4fb72278941de@mail.gmail.com>
Message-ID: <20090928191852.GA20433@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Sep 28, 2009 at 09:00:01PM +0200, Linus Walleij wrote:
> Hm thinking back at this:
> 
> 2009/9/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > The real problem is that U300 doesn't implement gpio_is_valid() -
> > which is part of the GPIO API and not specific to GPIOLIB.
> 
> None of the GPIO drivers in drivers/gpio implement gpio_is_valid()
> though they all select GPIOLIB which in turn selects GENERIC_GPIO.
> 
> With one of them being the PL061 this means that the not so
> unlikely combination of PL061+PL180 will fail to compile (even
> though I'm not aware of such a platform for the time being).

Shouldn't gpio_is_valid() be implemented at the platform code? How should the 
generic GPIO driver know the number of valid GPIO lines, or the number of 
PL061 blocks for that matter?

> Is it worth taking a run over drivers/gpio and try to fix this or
> atleast the PL061 driver? I can have a look at it.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
