From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Aug 2017 23:07:29 +0200
Subject: [patch v6 0/3] JTAG driver introduction
In-Reply-To: <1503418256-5215-1-git-send-email-oleksandrs@mellanox.com>
References: <1503418256-5215-1-git-send-email-oleksandrs@mellanox.com>
Message-ID: <CACRpkdZePXyo8Q36mBH7OnJU3E=yWPWSGkGUOH=zJFMjM=Yrhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 6:10 PM, Oleksandr Shamray
<oleksandrs@mellanox.com> wrote:

> SoC which are not equipped with JTAG master interface, can be built
> on top of JTAG core driver infrastructure, by applying bit-banging of
> TDI, TDO, TCK and TMS pins within the hardware specific driver.

I guess you mean it should then use GPIO lines for bit-banging?

I was wondering about how some JTAG clients like openOCD does
this in some cases.

In my worst nightmare they export GPIO lines using
the horrid ABI in /sys/gpio/*

In best case they use the GPIO character device or even
libgpiod.

But having a JTAG abstraction inside the kernel that can
grab a few lines for JTAG defined in a device tree, ACPI DSDT
or similar makes sense too, as it abstracts the hardware so the
JTAG client can then just open whatever /dev/jtag0 is on the machine
and go ahead without having to bother about what GPIO lines
are connected exactly where.

Yours,
Linus Walleij
