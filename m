From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Mar 2017 15:32:00 +0100
Subject: [PATCH 4/5] dt-bindings: tegra: Update compatible strings for
 Tegra flowctrl
In-Reply-To: <1489584715-23138-5-git-send-email-jonathanh@nvidia.com>
References: <1489584715-23138-1-git-send-email-jonathanh@nvidia.com>
 <1489584715-23138-5-git-send-email-jonathanh@nvidia.com>
Message-ID: <20170320143200.GA17169@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 01:31:54PM +0000, Jon Hunter wrote:
> Update the compatible strings for Tegra Flow Control driver to match
> the device-tree source files for Tegra.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt     | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
> index ccf0adddc820..d92bf782985f 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
> @@ -1,7 +1,13 @@
>  NVIDIA Tegra Flow Controller
>  
>  Required properties:
> -- compatible: Should be "nvidia,tegra<chip>-flowctrl"
> +- compatible: Should contain one of the following:
> +	For Tegra20 must contain "nvidia,tegra20-flowctrl".
> +	For Tegra30 must contain "nvidia,tegra30-flowctrl".
> +	For Tegra114 must contain "nvidia,tegra114-flowctrl"
> +	For Tegra124 must contain "nvidia,tegra124-flowctrl"
> +	For Tegra132 must contain "nvidia,tegra124-flowctrl"
> +	For Tegra210 must contain "nvidia,tegra210-flowctrl"

I have a slight preference for the format:

	"nvidia,tegraXXX-flowctrl...": for TegraXXX

since that's what we've used in other bindings and is also closer to
what is, I think, planned for the longer term (i.e. DT bindings with
YAML(-like) syntax).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/75111c55/attachment.sig>
