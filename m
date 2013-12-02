From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 2 Dec 2013 15:25:23 +0100
Subject: [PATCH 1/2] ARM: dts: tegra: Header file for pinctrl constants
In-Reply-To: <1385992502-12771-1-git-send-email-ldewangan@nvidia.com>
References: <1385992502-12771-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <20131202142522.GA17566@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 07:25:01PM +0530, Laxman Dewangan wrote:

I think the canonical subject prefix for Tegra is:

	ARM: tegra:

Perhaps also mention that you "Add" the header file? Like so:

	ARM: tegra: Add header file for pinctrl constants

> Defines pincontrol constants to use from Tegra's DTS file

Perhaps: "This new header file defines..."? "DTS files"

> for tegra pincontrol properties option.

"Tegra"

> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  include/dt-bindings/pinctrl/pinctrl-tegra.h |   65 +++++++++++++++++++++++++++
>  1 files changed, 65 insertions(+), 0 deletions(-)
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra.h
> 
> diff --git a/include/dt-bindings/pinctrl/pinctrl-tegra.h b/include/dt-bindings/pinctrl/pinctrl-tegra.h
[...]
> +/* Pull up/down/normal */
> +#define TEGRA_PIN_PUPD_NORMAL				0
> +#define TEGRA_PIN_PUPD_PULL_DOWN			1
> +#define TEGRA_PIN_PUPD_PULL_UP				2

Perhaps these would be easier to use as:

	#define TEGRA_PIN_PULL_NONE	0
	#define TEGRA_PIN_PULL_DOWN	1
	#define TEGRA_PIN_PULL_UP	2

?

> +/* Tristate/normal */
> +#define TEGRA_PIN_NORMAL				0
> +#define TEGRA_PIN_TRISTATE				1
> +
> +/* Rcv Sel enable/disable */
> +#define TEGRA_PIN_RCV_SEL_DISABLE			0
> +#define TEGRA_PIN_RCV_SEL_ENABLE			1
> +
> +/* Lock enable/disable */
> +#define TEGRA_PIN_LOCK_DISABLE				0
> +#define TEGRA_PIN_LOCK_ENABLE				1
> +
> +/* Open drain enable/disable */
> +#define TEGRA_PIN_OPEN_DRAIN_DISABLE			0
> +#define TEGRA_PIN_OPEN_DRAIN_ENABLE			1
> +
> +/* High speed mode */
> +#define TEGRA_PIN_DRIVE_HIGH_SPEED_MODE_DISABLE		0
> +#define TEGRA_PIN_DRIVE_HIGH_SPEED_MODE_ENABLE		1
> +
> +/* Schmitt enable/disable */
> +#define TEGRA_PIN_DRIVE_SCHMITT_DISABLE			0
> +#define TEGRA_PIN_DRIVE_SCHMITT_ENABLE			1

These are all boolean, so I wonder if perhaps we should be simply
defining a single pair and reuse that in different contexts:

	#define TEGRA_PIN_DISABLE	0
	#define TEGRA_PIN_ENABLE	1

The property names should provide enough context for them to be used
unambiguously.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/69608dfe/attachment.sig>
