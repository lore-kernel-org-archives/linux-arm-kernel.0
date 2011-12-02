From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Dec 2011 09:49:16 +0100
Subject: backlight/ld9040.c: regulator control in the lcd driver
In-Reply-To: <000c01ccb0c6$697c2aa0$3c747fe0$%lee@samsung.com>
References: <000c01ccb0c6$697c2aa0$3c747fe0$%lee@samsung.com>
Message-ID: <CACRpkdbRdtsw-3FXtevuJL7G=tcE+1s11iRw=zou1G25hufBSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 2, 2011 at 8:45 AM, leedonghwa <dh09.lee@samsung.com> wrote:

[From your mail headers]
> X-Mailer: Microsoft Office Outlook 12.0

No please. That mailer does not work, all your whitespace is screwed up.
Consult: Documentation/email-clients.txt

> This patch supports regulator power control in the driver.

Always CC the regulator maintainers on patches like this please.

> +???????? lcd->reg_vdd3 = regulator_get(lcd->dev, "vdd");
> +???????? if (IS_ERR(lcd->reg_vdd3)) {
> +?????????????????? dev_info(lcd->dev, "no %s regulator found\n", "vdd");
> +?????????????????? lcd->reg_vdd3 = NULL;
> +???????? }
> +
> +???????? lcd->reg_vci = regulator_get(lcd->dev, "vci");
> +???????? if (IS_ERR(lcd->reg_vci)) {
> +?????????????????? dev_info(lcd->dev, "no %s regulator found\n", "vci");
> +?????????????????? lcd->reg_vci = NULL;
> +???????? }

As explained in earlier discussion with Mark regarding the SMSC911x
driver regulator, treat these as errors and do not fail
"gracefully" like this.

Reference:
http://marc.info/?l=linux-netdev&m=131914562120725&w=2

Yours,
Linus Walleij
