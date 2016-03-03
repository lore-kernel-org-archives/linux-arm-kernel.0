From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 3 Mar 2016 21:44:44 +0900
Subject: [rtc-linux] [RFC 06/15] pinctrl: rockchip: Add missing MFD_SYSCON
 dependency on HAS_IOMEM
In-Reply-To: <1456992221-26712-7-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-7-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAJKOXPcbiscpC_RUe=ft9NTy1ZY1uaa_zkX6rOadnoym-UMR1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-03-03 17:03 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> The MFD_SYSCON depends on HAS_IOMEM so when selecting it avoid unmet
> direct dependencies.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/pinctrl/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index fb8200b8e8ec..dc7ab58d4d74 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -131,6 +131,7 @@ config PINCTRL_MESON
>
>  config PINCTRL_ROCKCHIP
>         bool
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select PINMUX

False alarm, no need for the patch (non-selectable symbol)

Best regards,
Krzysztof
