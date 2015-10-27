From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 10:51:57 +0100
Subject: [PATCH 07/11] pinctrl: use ngpios propety from DT
In-Reply-To: <1445233398-27129-8-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-8-git-send-email-pramodku@broadcom.com>
Message-ID: <CACRpkdY1GDs6ypqCiY3iiv3DkfnHchnY+bWPoCqU=_sgn9f5vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 7:43 AM, Pramod Kumar <pramodku@broadcom.com> wrote:

> Since identical hardware is used in several instances and all pins
> are not routed to pinctrl hence getting total number of gpios from
> DT make more sense hence stop using total number of gpios pins from
> drivers and extract it from DT.
>
> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

This patch is wrong.

Keep this per-compatible code, and only overrid the ngpios
if and only if:

- The ngpios is set in the DT node
- The ngpios in the DT node is *smaller* than the hardware
  defined number of GPIOs.

ngpios is for restricting the number of available lines due to
routing etc, not to define what the hardware has, because the
hardware most certainly have all the lines, it's just that you're
not using all of them.

Yours,
Linus Walleij
