From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Feb 2013 15:23:38 +0100
Subject: [PATCH RFC 2/7] net: smsc911x: add pinctrl support
In-Reply-To: <1360442671-15216-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1360442671-15216-3-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CACRpkdY8FBoMCO1hjEOhCir=5mNJpiY7sG3PMvKeXJ-hHXXmjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 9, 2013 at 9:44 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> If no pinctrl is available just report a warning since
> it may not needed in some cases (e.g: non-DT kernels).
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
(...)
> +       struct pinctrl *pinctrl;
(...)
> +       pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +       if (IS_ERR(pinctrl)) {
> +               retval = PTR_ERR(pinctrl);
> +               if (retval == -EPROBE_DEFER)
> +                       goto out_0;
> +
> +               dev_warn(&pdev->dev, "No pinctrl provided\n");
> +       }

NACK.

This will be handled from the device core after the v3.9 merge
window.

See:
http://marc.info/?l=linux-kernel&m=135887740715083&w=2

Yours,
Linus Walleij
