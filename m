From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Jul 2014 11:27:57 +0200
Subject: [PATCH v2 1/2] gpio: Add driver for Zynq GPIO controller
In-Reply-To: <20140707152309.GH4939@tarshish>
References: <1403091577-10232-1-git-send-email-harinik@xilinx.com>
 <5cc8b89b-20ff-4fa9-92dd-bb2f6d3512d8@BY2FFO11FD030.protection.gbl>
 <CACRpkdb1M3-hrSKLKWz21LCJ1sMvsq5E-aqkpmVhy0NwOS5HhA@mail.gmail.com>
 <20140707152309.GH4939@tarshish>
Message-ID: <CACRpkdY+3hy5iw=uRdmu665NWsoGacTMgjUq97219kEcfn7Dqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 7, 2014 at 5:23 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> On Mon, Jul 07, 2014 at 04:51:56PM +0200, Linus Walleij wrote:

>> This needs someone to step in and provide a replacement, my preferred
>> mechanism would be a /dev/gpiochip0/... hierarchy using char devices.
>
> I really like the ability to control GPIOs from shell, both interactively and
> scripted. I find it useful for quick hardware level debugging,

I would be happy to carry it in the unstable-ABI debugfs for sure.
It's the supported ABI that bothers me.

> and for boot
> time scripting (mainly in initramfs).

What is the usecase here?

> Do you intend to preserve this
> capability in the future? Will I need a special utility (or Busybox applet) to
> do this with char device ioctl?

It is ABI so we have to preserve it. But sometimes people come with
new zuper-complex userspace usecases and want to add this or
that crazy ABI to do stuff in userspace that the kernel can do better.
And all that I intend to just NACK.

Yours,
Linus Walleij
