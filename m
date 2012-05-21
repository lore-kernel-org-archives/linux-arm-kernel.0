From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 09:12:21 +0200
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <20120517143035.GA19548@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
 <20120517143035.GA19548@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdaM+EDDMh=i+i6a2zBGRN+3BQmkk94hNNHVJkTRK9cfXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 4:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Is there any reason you can see not to do this?

Nope, I like the patches for Versatile and RealView, and should have
worked on them myself if I could have free:ed up some time. They
are much needed in-tree since I hear there are more PL08x-based platforms
out there that need signal muxing and the reference designs should provide a
good example of how to do that.

It also provides me a good reason to go and actually test this on the
PB11MPcore as it lands in the next kernel.

> I ultimately need to kill off the passing of struct pl08x_dma_chan to
> these functions, because that's preventing me moving the struct into
> drivers/dma - which I need to in order to convert amba-pl08x.c to use
> virt-dma.c.

OK, no big deal.

> The only use of pl08x_dma_chan in the functions below is for the debug
> prints, which I suggest we just kill off - or we could change them to
> be cd->bus_id, which is the same thing anyway.

Any way is fine with me.

Yours,
Linus Walleij
