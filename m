From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 3 Mar 2016 21:43:55 +0900
Subject: [rtc-linux] [RFC 07/15] pinctrl: mvebu: Add missing MFD_SYSCON
 dependency on HAS_IOMEM
In-Reply-To: <1456992221-26712-8-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-8-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAJKOXPeVNrzCJ0TTeBG=H0w2+qHzAcXfTck9gBBmZFvVPpPx0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-03-03 17:03 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> The MFD_SYSCON depends on HAS_IOMEM so when selecting it avoid unmet
> direct dependencies.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/pinctrl/mvebu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pinctrl/mvebu/Kconfig b/drivers/pinctrl/mvebu/Kconfig
> index 170602407c0d..13685923729c 100644
> --- a/drivers/pinctrl/mvebu/Kconfig
> +++ b/drivers/pinctrl/mvebu/Kconfig
> @@ -7,6 +7,7 @@ config PINCTRL_MVEBU
>
>  config PINCTRL_DOVE
>         bool
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select PINCTRL_MVEBU
>         select MFD_SYSCON

False alarm, no need for the patch (non-selectable symbol)

Best regards,
Krzysztof
