From: k.kozlowski.k@gmail.com (=?UTF-8?Q?Krzysztof_Koz=C5=82owski?=)
Date: Thu, 16 Apr 2015 21:24:03 +0900
Subject: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix return value check in
 s3c24xx_iis_dev_probe()
In-Reply-To: <1429186682-20629-1-git-send-email-weiyj_lk@163.com>
References: <1429186682-20629-1-git-send-email-weiyj_lk@163.com>
Message-ID: <CAJKOXPf5kiC4pvk0zAOYXu2z8LJAWTLHbcMMzdXzvL+rpiT8Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-16 21:18 GMT+09:00  <weiyj_lk@163.com>:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function devm_ioremap_resource() returns
> ERR_PTR() and never returns NULL. The NULL test in the return
> value check should be replaced with IS_ERR().
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  sound/soc/samsung/s3c24xx-i2s.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Good catch.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Best regards,
Krzysztof
