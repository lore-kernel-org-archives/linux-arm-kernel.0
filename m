From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 25 Jun 2014 15:54:56 -0600
Subject: [PATCH v1 5/9] of: Add NVIDIA Tegra XHCI controller binding
In-Reply-To: <1403072180-4944-6-git-send-email-abrestic@chromium.org>
References: <1403072180-4944-1-git-send-email-abrestic@chromium.org>
 <1403072180-4944-6-git-send-email-abrestic@chromium.org>
Message-ID: <53AB4530.2050106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2014 12:16 AM, Andrew Bresticker wrote:
> Add device-tree binding documentation for the XHCI controller present
> on Tegra124 and later SoCs.

> diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xhci.txt

> + - clock-names: Must include the following entries:
> +    - xusb_host
> +    - xusb_falcon_src
> +    - xusb_ss
> +    - xusb_ss_src
> +    - xusb_hs_src
> +    - xusb_fs_src

Looking at include/dt-bindings/clock/tegra124-car.h I see a few entries
potentially missing here:

#define TEGRA124_CLK_XUSB_HOST_SRC 252
#define TEGRA124_CLK_XUSB_DEV_SRC 256
#define TEGRA124_CLK_XUSB_DEV 257
#define TEGRA124_CLK_XUSB_SS_DIV2 312

> +    - pll_u_480m

Not just pll_u?
