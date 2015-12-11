From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Dec 2015 13:43:31 +0100
Subject: [RESEND RFC PATCH 1/2] gpio: Add isr property of gpio pins
In-Reply-To: <1449544808-3163-2-git-send-email-peda@lysator.liu.se>
References: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
 <1449544808-3163-2-git-send-email-peda@lysator.liu.se>
Message-ID: <CACRpkdbQztU14hY60HPv78TjVWVLx6RBzrFQqddVfNv3cj142g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 8, 2015 at 4:20 AM, Peter Rosin <peda@lysator.liu.se> wrote:

> From: Peter Rosin <peda@axentia.se>
>
> Adds the possibility to read the interrupt status register bit for the
> gpio pin. Expose the bit as an isr file in sysfs.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

NACK. We have frozen the sysfs ABI and we are working on a
character device to replace it for userspace access, see:
http://marc.info/?l=linux-gpio&m=144550276512673&w=2

Second question is *WHY* you want this crazy thing? Userspace
should want *events* from a file descriptor, like IIO does it for
example (on top of a proper chardev), not polling a register to
figure out if an IRQ occurred.

We need to think about the real solution to what you want to do.

Yours,
Linus Walleij
