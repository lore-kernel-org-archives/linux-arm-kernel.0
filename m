From: robherring2@gmail.com (Rob Herring)
Date: Wed, 25 Feb 2015 08:38:42 -0600
Subject: [PATCH V5 1/2] mmc: dw_mmc: exynos: Support eMMC's HS400 mode
In-Reply-To: <1422499318-13726-2-git-send-email-alim.akhtar@samsung.com>
References: <1422499318-13726-1-git-send-email-alim.akhtar@samsung.com>
 <1422499318-13726-2-git-send-email-alim.akhtar@samsung.com>
Message-ID: <CAL_Jsq+Mr=WOoCjWRnHnUqo8+UmqxxHbMG3M8+kLNgfhPASteA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 8:41 PM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> From: Seungwon Jeon <tgih.jun@samsung.com>
>
> Implements HS400 mode support for exynos host driver.
> This also include some updates as new mode is added.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> [Alim: addressed review comments]
> ---
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    7 +
>  drivers/mmc/host/dw_mmc-exynos.c                   |  185 ++++++++++++++++----
>  drivers/mmc/host/dw_mmc-exynos.h                   |   19 +-
>  drivers/mmc/host/dw_mmc.c                          |   16 +-
>  drivers/mmc/host/dw_mmc.h                          |    2 +
>  5 files changed, 195 insertions(+), 34 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> index ee4fc05..aad9844 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -36,6 +36,8 @@ Required Properties:
>    in transmit mode and CIU clock phase shift value in receive mode for double
>    data rate mode operation. Refer notes below for the order of the cells and the
>    valid values.
> +* samsung,dw-mshc-hs400-timing: Specifies the value of CIU TX and RX clock phase
> +  shift value for hs400 mode operation.

What are the units?

Rob
