From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Dec 2012 18:57:57 +0100
Subject: [PATCH 2/2] ARM: ux500: add pinctrl address resources
In-Reply-To: <1355821932-15799-2-git-send-email-fabio.baltieri@linaro.org>
References: <1355821932-15799-1-git-send-email-fabio.baltieri@linaro.org>
 <1355821932-15799-2-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdZyMWtx1s1mrNebPgJfn69tpDJmCR-w39puoxCci+vmWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 10:12 AM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> Current nmk_pinctrl driver is not PRCMU dependent anymore, so it needs
> its own DT address resources to work properly, as done for
> platform_device in:
>
> f482833 ARM: ux500: add PRCM register base for pinctrl
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Applied these two to the pinctrl fixes with one alteration:

> +               pinctrl at 80157000 {
> +                       reg = <0x80157000 0x2000>;
>                         compatible = "stericsson,nmk_pinctrl";

I inserted a comment here like this:

                pinctrl at 80157000 {
+                       // This is actually the PRCMU base address
                        reg = <0x80157000 0x2000>;

Yours,
Linus Walleij
