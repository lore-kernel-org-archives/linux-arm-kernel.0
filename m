From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 09:50:44 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
Message-ID: <CACRpkdY+prqSeohT5BEoOKS6sfXdFTA6ZzuKzH4GSPX5jcjgzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 1, 2015 at 9:34 PM, Richard Cochran
<richardcochran@gmail.com> wrote:

> The system-on-chips using this IP core have well defined gpio numbers.
> Instead of using random numbers, this patch lets the device tree specify
> the correct gpio numbering.
>
> Signed-off-by: Richard Cochran <rcochran@linutronix.de>
(...)
> +- snps,base : The base gpio number.

NACK. And it has been NACKed before again and again, search
the mailinglist for repetitive answers.

The GPIO numbers inside the Linux kernel are Linux specific and
have nothing to do with the hardware numbers. If they sometimes
match it is a lucky coincidence. The same goes for IRQ numbers
in the kernel FWIW.

So this "binding" has nothing to do with describing the hardware,
which device tree is for. If it ever comes to exist it needs to be
a "linux-*" property. But I doubt it will.

We are working to remove dependency on them by introducing GPIO
descriptors and thinking heavily about how to handle the userspace
sysfs ABI moving forward. But for the ABI the numbers just need to
be stable, not intuitive.

Yours,
Linus Walleij
