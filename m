From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 4 Apr 2011 17:08:12 +0300
Subject: [PATCH] arm: plat-mxc: Add missing lockdep annotation
In-Reply-To: <alpine.LFD.2.00.1104041416290.19945@localhost6.localdomain6>
References: <alpine.LFD.2.00.1104041416290.19945@localhost6.localdomain6>
Message-ID: <20110404140812.GD1481@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Mon, Apr 04, 2011 at 02:29:58PM +0200, Thomas Gleixner wrote:
> The irq_set_wake() function of the gpio irq_chip calls
> enable/disable_irq_wake() on the demultiplex interrupt. That leads to
> a lockdep warning "INFO: possible recursive locking detected" because
> irq_set_type() is called under irq_desc->lock and the *_irq_wake()
> calls take irq_desc->lock of the demux interrupt.
> 
> Tell lockdep that the gpio irqs are in a different lock class.

Does the PL061 driver (drivers/gpio/pl061.c) need the same treatment?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
