From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 02 Feb 2015 13:54:54 +0100
Subject: [PATCH v4 9/9] drm/exynos: add support for 'hdmi' clock
In-Reply-To: <CAOMZO5BSvxvbM0nOHk2ogY0j23PwazFCMikiiEv-XtHae3=L_g@mail.gmail.com>
References: <1421756219-21037-1-git-send-email-m.szyprowski@samsung.com>
 <1421756219-21037-10-git-send-email-m.szyprowski@samsung.com>
 <CAOMZO5BSvxvbM0nOHk2ogY0j23PwazFCMikiiEv-XtHae3=L_g@mail.gmail.com>
Message-ID: <54CF739E.2070407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-01-22 14:00, Fabio Estevam wrote:
> On Tue, Jan 20, 2015 at 10:16 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>
>> +       mixer_res->hdmi = devm_clk_get(dev, "hdmi");
>> +       if (IS_ERR(mixer_res->hdmi)) {
>> +               dev_err(dev, "failed to get clock 'hdmi'\n");
>> +               return -ENODEV;
> 'return PTR_ERR(mixer_res->hdmi);' would be better.

ok.

>
>> +       }
>> +
>>          mixer_res->sclk_hdmi = devm_clk_get(dev, "sclk_hdmi");
>>          if (IS_ERR(mixer_res->sclk_hdmi)) {
>>                  dev_err(dev, "failed to get clock 'sclk_hdmi'\n");
>> @@ -1095,6 +1102,7 @@ static void mixer_poweron(struct exynos_drm_manager *mgr)
>>          pm_runtime_get_sync(ctx->dev);
>>
>>          clk_prepare_enable(res->mixer);
>> +       clk_prepare_enable(res->hdmi);
> Better check whether clk_prepare_enable failed.

This will be handled by a separate patch, because checking for error 
values from
clk_repare_enable is missing almost all over the Exynos DRM driver.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
