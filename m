From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Jul 2014 14:38:41 +0200
Subject: [PATCH v2 1/2] gpio: Add driver for Zynq GPIO controller
In-Reply-To: <20140711122744.GE3003@tarshish>
References: <1403091577-10232-1-git-send-email-harinik@xilinx.com>
 <5cc8b89b-20ff-4fa9-92dd-bb2f6d3512d8@BY2FFO11FD030.protection.gbl>
 <CACRpkdb1M3-hrSKLKWz21LCJ1sMvsq5E-aqkpmVhy0NwOS5HhA@mail.gmail.com>
 <20140707152309.GH4939@tarshish>
 <CACRpkdY+3hy5iw=uRdmu665NWsoGacTMgjUq97219kEcfn7Dqw@mail.gmail.com>
 <20140711062811.GC3003@tarshish>
 <CACRpkdYi_xbixsgvF0NMVdRmxbAgDVOnq-vzYVpDkLHTL8-12A@mail.gmail.com>
 <20140711122744.GE3003@tarshish>
Message-ID: <CACRpkdb6OrTW63AuVqyFt_h=J-WpcvL+Bb7HpM+RD7EeSDoAbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 2:27 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> On Fri, Jul 11, 2014 at 02:06:29PM +0200, Linus Walleij wrote:

>> So given that an FPGA is a piece of hardware, it should have its firmware
>> loaded from the kernel and a kernel driver communicating with it I guess?
>>
>> I feel the smell of a huge bundle of userspace drivers for something that
>> should be handled by the kernel.
>
> The FPGA can be loaded using simple SPI bit-banging, for which I used the
> userspace SPI interface. Nothing fancy, just a few hundred LoC. Kernel driver
> along with a userspace interface to be maintained forever for this task seems
> an overkill to me.

OK I'd say yes maybe it's like a modem on the other side of a serial
line then, and then it makes sense to have that as a userspace thing.

It's just that when it comes to anything relating to the electrical
connections on the board, that stuff should be in some device tree
or similar HW description format, and then this needs to be parsed
by userspace too, and ... yuck. It's just so incoherent in a
helicopter view.

Yours,
Linus Walleij
