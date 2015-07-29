From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 29 Jul 2015 17:07:33 +0200
Subject: [PATCH v4 4/5] tty/serial: at91: add support to FIFOs
In-Reply-To: <CAHp75VdW8grMZdh0VmZAL-EhMdw-M6-PtJUT4Ms8SidsWu4QSw@mail.gmail.com>
References: <cover.1435842688.git.cyrille.pitchen@atmel.com>
 <4d8e90ad2cbb0d020dae4a4806ffc8864b5b22b6.1435842688.git.cyrille.pitchen@atmel.com>
 <CAHp75VdW8grMZdh0VmZAL-EhMdw-M6-PtJUT4Ms8SidsWu4QSw@mail.gmail.com>
Message-ID: <20150729150733.GB6073@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 29/07/2015 at 17:51:38 +0300, Andy Shevchenko wrote :
> On Thu, Jul 2, 2015 at 4:18 PM, Cyrille Pitchen
> <cyrille.pitchen@atmel.com> wrote:
> > Depending on the hardware, TX and RX FIFOs may be available. The RX
> > FIFO can avoid receive overruns, especially when DMA transfers are
> > not used to read data from the Receive Holding Register. For heavy
> > system load, The CPU is likely not be able to fetch data fast enough
> > from the RHR.
> 
> This patch broke avr32 console (as seen in today's linux-next) on ATNGW100.
> Reverting helps. I'm pretty sure the issue is in 8 bit vs. 32 bit I/O access.
> 
> # uname -a
> Linux buildroot 4.2.0-rc4-next-20150729+ #97 Wed Jul 29 17:50:11 EEST
> 2015 avr32 GNU/Linux
> 
> Do you, guys, have that board (NGW100) or it's officially unsupported?
> If the latter is the case I would really appreciate if you remove the
> support from the kernel side.
> 

The main issue here is that the main atmel arm developers don't have
access to any avr32 board. I'd say that everything that is done is best
effort to not break avr32 but it is not tested at all.

Don't hesitate to submit patches when something breaks...

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
