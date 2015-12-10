From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 10 Dec 2015 12:05:48 +0100 (CET)
Subject: [PATCH RESEND] pinctrl: bcm2835: Fix initial value for
 direction_output
In-Reply-To: <1449511825-6156-1-git-send-email-stefan.wahren@i2se.com>
References: <1449511825-6156-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1330071479.188146.762be339-5c35-483f-b17c-6076dc1d3758.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 7. Dezember 2015 um 19:10
> geschrieben:
>
>
> Currently the provided initial value for bcm2835_gpio_direction_output
> has no effect. So fix this issue by changing the value before
> changing the GPIO direction. As a result we need to move the function below
> bcm2835_gpio_set.
>
> Suggested-by: Martin Sperl <kernel@martin.sperl.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: e1b2dc70cd5b ("pinctrl: add bcm2835 driver")
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---

on Nov 30 you wrote that you want Stephen's ACK and now it's there.

But your current patch "[PATCH 092/182] pinctrl: bcm2835: use gpiochip data
pointer" seems to conflict with my?

Any wishes?

Stefan

>
> This patch was inspired by this discussion [1].
>
> [1] -
> http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-April/001499.html
>
> Changes:
> - added suggested-by, fixes and acked-by tag since first submit
>
> drivers/pinctrl/bcm/pinctrl-bcm2835.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
>
