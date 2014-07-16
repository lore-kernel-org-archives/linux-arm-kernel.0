From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Jul 2014 09:32:01 +0200
Subject: [PATCH 4/6] clk: tegra: add nvidia,tegra132-ccplex-clk binding
In-Reply-To: <1405437890-6468-5-git-send-email-pdeschrijver@nvidia.com>
References: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
 <1405437890-6468-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20140716073200.GE7978@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 06:24:34PM +0300, Peter De Schrijver wrote:
> Tegra132 has a few new clocks for the CPU complex (ccplex).
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  .../bindings/clock/nvidia,tegra132-ccplex-clk.txt  |   27 ++++++++++++++++++++
>  include/dt-bindings/clock/tegra132-ccplex.h        |   12 +++++++++
>  2 files changed, 39 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra132-ccplex-clk.txt
>  create mode 100644 include/dt-bindings/clock/tegra132-ccplex.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra132-ccplex-clk.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra132-ccplex-clk.txt
> new file mode 100644
> index 0000000..1441e36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra132-ccplex-clk.txt
> @@ -0,0 +1,27 @@
> +NVIDIA Tegra132 ccplex clocks

Perhaps: "NVIDIA Tegra132 CPU complex (ccplex) clocks". Otherwise this
file doesn't expand the ccplex abbreviation at all and it may not be
obvious to everyone.

> +This binding uses the common clock binding:
> +Documentation/devicetree/bindings/clock/clock-bindings.txt

clock-bindings.txt is in the same directory as this file, so a slightly
better wording would be:

	This binding uses the common clock binding as described in the
	clock-bindings.txt file in this directory.

Note that these absolute paths may not remain the same when the device
tree bindings are moved out of the kernel tree.

> +The Tegra132 ccplex clock module on Tegra132 is the HW module responsible
> +for the ccplex related clocks.

The end repeats the beginning of this sentence, so its information
content is rather low. Maybe the last part of this sentence could be:
"... responsible for the CPU and related clocks".

> diff --git a/include/dt-bindings/clock/tegra132-ccplex.h b/include/dt-bindings/clock/tegra132-ccplex.h
[...]
> +#define TEGRA132_CCPLEX_CCLK_G 1
> +#define TEGRA132_PLL_X 2
> +#define TEGRA132_CCPLEX_CLK_MAX 3

Maybe these should use TEGRA132_CLK_ as prefix for consistency with the
CAR binding?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/141aa548/attachment-0001.sig>
