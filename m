From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Jul 2014 14:06:29 +0200
Subject: [PATCH v2 1/2] gpio: Add driver for Zynq GPIO controller
In-Reply-To: <20140711062811.GC3003@tarshish>
References: <1403091577-10232-1-git-send-email-harinik@xilinx.com>
 <5cc8b89b-20ff-4fa9-92dd-bb2f6d3512d8@BY2FFO11FD030.protection.gbl>
 <CACRpkdb1M3-hrSKLKWz21LCJ1sMvsq5E-aqkpmVhy0NwOS5HhA@mail.gmail.com>
 <20140707152309.GH4939@tarshish>
 <CACRpkdY+3hy5iw=uRdmu665NWsoGacTMgjUq97219kEcfn7Dqw@mail.gmail.com>
 <20140711062811.GC3003@tarshish>
Message-ID: <CACRpkdYi_xbixsgvF0NMVdRmxbAgDVOnq-vzYVpDkLHTL8-12A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 8:28 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> On Tue, Jul 08, 2014 at 11:27:57AM +0200, Linus Walleij wrote:

>> What is the usecase here?
>
> During boot I need to know, for example, when an FPGA is ready to be
> programmed, and when said FPGA has finished its initialization. I also read
> the sate of on-board DIP switches to determine the desired boot method. I find
> the current sysfs interface quite convenient for these and similar tasks.

So given that an FPGA is a piece of hardware, it should have its firmware
loaded from the kernel and a kernel driver communicating with it I guess?

I feel the smell of a huge bundle of userspace drivers for something that
should be handled by the kernel.

Yours,
Linus Walleij
