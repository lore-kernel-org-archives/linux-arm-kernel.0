From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 28 Aug 2018 10:57:43 +0300
Subject: [PATCH] ASoC: Convert to using %pOFn instead of device_node.name
In-Reply-To: <20180828015252.28511-51-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-51-robh@kernel.org>
Message-ID: <CAHp75Vd2B47bMHOuDtFcRUbbMXekgxsG+WP5kj-E1Z_K09=C4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 4:57 AM Rob Herring <robh@kernel.org> wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

> +       snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%pOFn",
> +                (unsigned long long) res.start, dma_channel_np);

I understand that is not the part of the change, but wouldn't be good
to replace that ugly casting with proper specifier as well?
I mean
%pa ... &res.start

> +                       dev_err(&pdev->dev, "%pOFn sync own reference\n",
> +                               np);

One line?

-- 
With Best Regards,
Andy Shevchenko
