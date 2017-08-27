From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Aug 2017 00:25:14 +0200
Subject: [patch v6 0/3] JTAG driver introduction
In-Reply-To: <593cd0d3-8e06-0992-c155-1322014c0477@longlandclan.id.au>
References: <1503418256-5215-1-git-send-email-oleksandrs@mellanox.com>
 <CACRpkdZePXyo8Q36mBH7OnJU3E=yWPWSGkGUOH=zJFMjM=Yrhw@mail.gmail.com>
 <CAPLgG==Jj=Ys=SvhOCspSfunbWnuqPySvW9RfuqE8HYnG4C=ZQ@mail.gmail.com>
 <CACRpkdbozWaL0RXyZXjzxYK3JHiqYziSkTGSgGORdptX-rwR8A@mail.gmail.com>
 <593cd0d3-8e06-0992-c155-1322014c0477@longlandclan.id.au>
Message-ID: <CACRpkdbgbRgqi=sVs0Rk_qPLUFC6wwvcWKKdiDjfXHdUZ4EXjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 10:50 AM, Stuart Longland
<stuartl@longlandclan.id.au> wrote:
> [Note: dropping vadimp at maellanox.com as SMTP server complained about the
> DNS server returning NXDOMAIN.  Apologies.]
> On 25/08/17 18:32, Linus Walleij wrote:
>> Gnah!
>> Whoever writes a slot-in replacement making the character device
>> take precendence wins lots of karma.
>
> What would such a replacement look like though?

Something that looks for /dev/gpiochipN and if it exists open the GPIOs
from there and make that take precedence over any /sys/gpio/*
poking.

> Some sort of system whereby you can read/write single-line commands as
> if talking to a GPIO expander over a UART?

I don't really understand the question. All GPIO expanders become
a gpiochip, and have their own character device in /dev.

> Would you access the GPIOs one by one, or would you perhaps map them
> into a bitmap (maybe arbitrarily, up to 64-bits wide) and perform masked
> operations on the bitmap?

The character device supports up to 64bits of simultaneous line
switches, but the in-kernel API can only handle 32bits
in a single register write.

> I'm no fan of the sysfs GPIO interface, but it beats poking around at
> registers behind the kernel's back.

Have a look at libgpiod and tools/gpio/* in the kernel.

Yours,
Linus Walleij
