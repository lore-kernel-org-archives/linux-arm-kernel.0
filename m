From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jun 2018 15:23:29 -0600
Subject: [PATCH 12/19] mmc: mmci: add variant property to request a reset
In-Reply-To: <1528809280-31116-13-git-send-email-ludovic.Barre@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-13-git-send-email-ludovic.Barre@st.com>
Message-ID: <20180625212329.GA26557@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 03:14:33PM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> Some variants could require a reset.
> STM32 sdmmc variant needs to reset hardware block
> during the power cycle procedure (for re-initialization)
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
>  drivers/mmc/host/mmci.c                        | 9 +++++++++
>  drivers/mmc/host/mmci.h                        | 4 ++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
> index 03796cf..e952707 100644
> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
> @@ -11,6 +11,8 @@ Required properties:
>  - compatible             : contains "arm,pl18x", "arm,primecell".
>  - vmmc-supply            : phandle to the regulator device tree node, mentioned
>                             as the VCC/VDD supply in the eMMC/SD specs.
> +depend of variant:

Just make it an optional property.

> +- resets                 : phandle to internal reset line.
>  
>  Optional properties:
>  - arm,primecell-periphid : contains the PrimeCell Peripheral ID, it overrides
