From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 24 Sep 2013 15:12:27 -0700
Subject: [PATCH V3 1/6] clk: exynos-audss: convert to platform device
In-Reply-To: <524200FB.8010004@gmail.com>
References: <1379982078-23381-1-git-send-email-abrestic@chromium.org>
 <1380046016-5811-1-git-send-email-abrestic@chromium.org>
 <524200FB.8010004@gmail.com>
Message-ID: <CAL1qeaEpu=YRasZpSvrCTNwC6OGWZgECjwDSFgkAN07eWObmrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static int exynos_audss_clk_remove(struct platform_device *pdev)
>> +{
>> +       int i;
>> +
>> +       of_clk_del_provider(pdev->dev.of_node);
>> +
>> +       for (i = 0; i<  EXYNOS_AUDSS_MAX_CLKS; i++) {
>> +               if (!IS_ERR_OR_NULL(clk_table[i]))
>> +                       clk_unregister(clk_table[i]);
>> +       }
>
>
> Since we only get here if all the clocks are registered properly and we
> always register EXYNOS_AUDSS_MAX_CLKS clocks, couldn't this simply be:
>
>
>         for (i = 0; i < EXYNOS_AUDSS_MAX_CLKS; i++)
>                 clk_unregister(clk_table[i]);
>
> ?

Once support is added for Exynos5420, we won't always register
EXYNOS_AUDSS_MAX_CLKS clocks, so we'd still need the NULL check.

Thanks,
Andrew
