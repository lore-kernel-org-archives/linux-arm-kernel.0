From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 5 Mar 2015 13:43:38 +0000
Subject: [PATCH v2] ARM: STi: Add STiH410 SoC support
In-Reply-To: <1425560706-22907-1-git-send-email-fabrice.gasnier@st.com>
References: <1425560706-22907-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20150305134338.GE31098@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 05 Mar 2015, Fabrice GASNIER wrote:

> This patch adds support to STiH410 SoC.
> 
> Please note "st,stih410" is already present in device tree.
> The problem is that it is missing the entry in the match table,
> and so the L2 cache and other cpus than 0 don't get initialized.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>  Documentation/devicetree/bindings/arm/sti.txt | 4 ++++
>  arch/arm/mach-sti/board-dt.c                  | 1 +
>  2 files changed, 5 insertions(+)

Sorry, this is the one I was looking at oneline.

Same comments apply though.

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/Documentation/devicetree/bindings/arm/sti.txt b/Documentation/devicetree/bindings/arm/sti.txt
> index d70ec35..8d27f6b 100644
> --- a/Documentation/devicetree/bindings/arm/sti.txt
> +++ b/Documentation/devicetree/bindings/arm/sti.txt
> @@ -13,6 +13,10 @@ Boards with the ST STiH407 SoC shall have the following properties:
>  Required root node property:
>  compatible = "st,stih407";
>  
> +Boards with the ST STiH410 SoC shall have the following properties:
> +Required root node property:
> +compatible = "st,stih410";
> +
>  Boards with the ST STiH418 SoC shall have the following properties:
>  Required root node property:
>  compatible = "st,stih418";
> diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
> index b067390..b373aca 100644
> --- a/arch/arm/mach-sti/board-dt.c
> +++ b/arch/arm/mach-sti/board-dt.c
> @@ -18,6 +18,7 @@ static const char *stih41x_dt_match[] __initdata = {
>  	"st,stih415",
>  	"st,stih416",
>  	"st,stih407",
> +	"st,stih410",
>  	"st,stih418",
>  	NULL
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
