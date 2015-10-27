From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 10:41:14 +0100
Subject: [PATCH 05/11] dt-binding: Add ngpios property to GPIO controller
 node
In-Reply-To: <1445233398-27129-6-git-send-email-pramodku@broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-6-git-send-email-pramodku@broadcom.com>
Message-ID: <CACRpkdZRmJTF9_yzVJx_vPKH6M6PivcrPiLD7xMEs5HDvsLw7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 7:43 AM, Pramod Kumar <pramodku@broadcom.com> wrote:

> Add ngpios property to the gpio controller's DT node so that controller
> driver extracts total number of gpio lines present in controller
> from DT and removes dependency on driver.
>
> Signed-off-by: Pramod Kumar <pramodku@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
(...)
> +- ngpios:
> +    Total number of GPIOs the controller provides

This description is wrong. The number of GPIOs the controller *provides*
is to be determined by the compatible-string.

ngpios is used to restrict the number of lines *used* or *routed* from
the number *available*. (I hope that is what the code does as well.)
Such as if 12 GPIOs are used of the 32 available on 32bits in a
register.

Update this description to say what it really means.

Yours,
Linus Walleij
