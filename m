From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 30 Nov 2015 16:06:14 -0300
Subject: [PATCH 1/2] regulator: Add coupled regulator
In-Reply-To: <1448897346-17780-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1448897346-17780-1-git-send-email-maxime.ripard@free-electrons.com>
 <1448897346-17780-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CABxcv=kn+jkQV2g=a+Sz8TdhMcvcQiBWsBuPejA159mm8WWB=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,

On Mon, Nov 30, 2015 at 12:29 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

[snip]

>
> +config REGULATOR_COUPLED_VOLTAGE

Shouldn't this depend on OF?

> +       tristate "Coupled voltage regulator support"

the Kconfig symbol is tristate so the driver can be built as a module...

> +
> +static struct of_device_id coupled_regulator_of_match[] = {
> +       { .compatible = "coupled-voltage-regulator" },
> +       { /* Sentinel */ },
> +};
> +

...but the driver is missing a MODULE_DEVICE_TABLE(of, ...) so module
autoloading won't work.

Best regards,
Javier
