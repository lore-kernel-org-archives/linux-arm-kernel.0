From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Jan 2014 07:18:44 -0200
Subject: [PATCH v2 09/15] watchdog: orion: Add per-compatible clock
 initialization
In-Reply-To: <1390295561-3466-10-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-10-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <CAOMZO5BDS8Dh1PR6SJv1CK5Pkq5mub-Hs7c4RhxUn7o5efnbKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 7:12 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:

> +static int orion_wdt_clock_init(struct platform_device *pdev,
> +                               struct orion_watchdog *dev)
> +{
> +       dev->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(dev->clk))
> +               return -ENODEV;

Shouldn't it be 'return PTR_ERR(dev->clk)' instead?


> +       clk_prepare_enable(dev->clk);

clk_prepare_enable may fail, so better check its return value.

Regards,

Fabio Estevam
