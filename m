From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Sep 2014 18:29:32 +0200
Subject: [PATCH 3/3] gpio: lib-sysfs: Add 'wakeup' attribute
In-Reply-To: <1409335127-26712-4-git-send-email-soren.brinkmann@xilinx.com>
References: <1409335127-26712-1-git-send-email-soren.brinkmann@xilinx.com>
 <1409335127-26712-4-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkda14yOtM=sfsiy2vajd-u-+YbkXZAADQLVNurM4TdCDeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 7:58 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> Add an attribute 'wakeup' to the GPIO sysfs interface which allows
> marking/unmarking a GPIO as wake IRQ.
> The file 'wakeup' is created in each exported GPIOs directory, if an IRQ
> is associated with that GPIO and the irqchip implements set_wake().
> Writing 'enabled' to that file will enable wake for that GPIO, while
> writing 'disabled' will disable wake.
> Reading that file will return either 'disabled' or 'enabled' depening on
> the currently set flag for the GPIO's IRQ.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

While I do see the utility of this patch, any kind of interrupt and
related handling in userspace makes me super-stressed and
nervous.

I need wide consent for this and please post this patch separately
from the zynq-related patches.

Yours,
Linus Walleij
