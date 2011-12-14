From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Dec 2011 23:15:53 +0100
Subject: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux subsystem
In-Reply-To: <20111214211152.GM27267@pengutronix.de>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-5-git-send-email-b29396@freescale.com>
 <20111214211152.GM27267@pengutronix.de>
Message-ID: <CACRpkdYHtgx3Qgx4QRdgOahQXjvSWE_iogWCZjaYQ-VnyS62uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 10:11 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Dec 15, 2011 at 12:03:42AM +0800, Dong Aisheng wrote:

>> + ? ? pmx = pinmux_get(&pdev->dev, NULL);
>> + ? ? if (IS_ERR(pmx)) {
>> + ? ? ? ? ? ? err = PTR_ERR(pmx);
>> + ? ? ? ? ? ? goto err_pmx_get;
>> + ? ? }
>> + ? ? err = pinmux_enable(pmx);
>> + ? ? if (err)
>> + ? ? ? ? ? ? goto err_pmx_enable;
>> + ? ? imx_data->pmx = pmx;
>> +
>
> Won't this break every i.MX except i.MX6?

Not this patch on its own, first the machines have to
select PINCTRL
select PINMUX_FOO

*Then* it will break :-D

So if you want to do this for i.MX you need something like
selectable dummy pinmuxes, i.e. pinmux_get() to return something
that just say "OK" to everything like the dummy regulators.

Shall I try to create something like that?

Yours,
Linus Walleij
