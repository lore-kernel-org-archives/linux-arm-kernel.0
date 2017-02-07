From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 7 Feb 2017 21:56:49 +0200
Subject: [PATCH -next v2] pinctrl: samsung: Fix return value check in
 samsung_pinctrl_get_soc_data()
In-Reply-To: <20170205155849.4362-1-weiyj.lk@gmail.com>
References: <20170125140321.23911-1-weiyj.lk@gmail.com>
 <20170205155849.4362-1-weiyj.lk@gmail.com>
Message-ID: <20170207195649.zambijropn3qgdwr@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 05, 2017 at 03:58:49PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function devm_ioremap() returns NULL pointer not
> ERR_PTR(). Fix by using devm_ioremap_resource instead of devm_ioremap.
> 
> Fixes: 8b1bd11c1f8f ("pinctrl: samsung: Add the support the multiple
> IORESOURCE_MEM for one pin-bank")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> v1 -> v2: use devm_ioremap_resource instead of devm_ioremap
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
