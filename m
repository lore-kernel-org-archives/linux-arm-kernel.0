From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 27 May 2015 16:27:47 +0200
Subject: [PATCH] soc: mediatek: Add compile dependency to pmic-wrapper
In-Reply-To: <1432729865-32319-1-git-send-email-matthias.bgg@gmail.com>
References: <1432729865-32319-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <CABuKBeLD9wpMqErGmFD6c_LTem_DXxu19CEvu0DJ4c6R4CeotQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-27 14:31 GMT+02:00 Matthias Brugger <matthias.bgg@gmail.com>:
> The pmic-wrapper calls the reset controller. If CONFIG_RESET_CONTROLLER
> is not set, compilation fails with:
> drivers/soc/mediatek/mtk-pmic-wrap.c: In function ?pwrap_probe?:
> drivers/soc/mediatek/mtk-pmic-wrap.c:836:2: error: implicit declaration of function ?devm_reset_control_get? [-Werror=implicit-function-declaration]
>
> This patch sets the dependency in the Kconfig file.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/soc/mediatek/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Applied to v4.1-next/soc
