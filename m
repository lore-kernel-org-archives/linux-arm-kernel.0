From: b32955@freescale.com (Huang Shijie)
Date: Fri, 29 Nov 2013 19:05:18 +0800
Subject: [PATCH 00/23] mtd: st_spi_fsm: Add new device
In-Reply-To: <20131128092904.GZ3296@lee--X1>
References: <1385137380-28968-1-git-send-email-lee.jones@linaro.org>
 <20131127040723.GZ9468@ld-irv-0074.broadcom.com>
 <20131127115226.GC3296@lee--X1> <5296B9C5.3060704@freescale.com>
 <20131128092904.GZ3296@lee--X1>
Message-ID: <529874EE.402@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jones & Augus:

thanks for your explanations.
> Most controllers just take an OPCODE and pass it on to the controller
> and have done with it. The issue that you're attempting to rectify is
> that the m25p80 expects every controller to be an SPI controller
> registered to the SPI framework, but as we both know that's not always
> practical as the SPI framework doesn't allow all configuration
> information to be passed back to the controller driver. Our issue is
> not the same. We are required to send entire 'message sequences', to
> the controller rather than just opcodes. The JEDEC message sequence
> can be seen below. Bear in mind that this is also one of the more
> simple message sequences. Some of them even vary depending on which
> chip is present.
Frankly speaking, my quadspi driver's code is just like Jones's code.
Yes, a big "switch".

The opcode is just like an index to trigger the proper operation.
That's why i add this hook @->read_reg(). (the hook acts as the ioctl)

If we do not use this hooks, we should add more hooks such as
@->read_id, @->read_sr, @->read_cr...

That's make the interface not graceful enough.


I read the your patch implementing the read_id:

http://lists.infradead.org/pipermail/linux-mtd/2013-November/050221.html


it's more readable. But i think Jones's stfsm_read_reg() is workable too.


If you do not like the read_reg() hook, do you have any better idea?



thanks
Huang Shijie
