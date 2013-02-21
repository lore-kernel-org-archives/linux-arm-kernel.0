From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Feb 2013 19:37:27 +0100
Subject: [PATCH v3 01/12] gpio: pxa: identify ed mask reg with platform
 data
In-Reply-To: <1361164358-5845-2-git-send-email-haojian.zhuang@linaro.org>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
 <1361164358-5845-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYcv9xC4-eXS2-0bqbp03c10+1K_a_DWdf97m5Z3Y75OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 6:12 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Avoid to judge whether edge mask register exists by CPU. Use platform
> data to identify it instead. The gpio edge mask register exists in MMP
> series SoC.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
(...)
> +       pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +       if (!pdata)
> +               return -ENOMEM;
> +       if (of_find_property(np, "marvell,gpio-ed-mask", NULL))

Should you not use of_property_read_bool()?

Should you not also update some DT binding document for this?

Yours,
Linus Walleij
