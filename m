From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Jan 2014 11:31:16 +0000
Subject: [PATCH v7 2/4] Documentation: Add APM X-Gene SoC 15Gbps
 Multi-purpose PHY driver binding documentation
In-Reply-To: <1389769840-15469-3-git-send-email-lho@apm.com>
References: <1389769840-15469-1-git-send-email-lho@apm.com>
 <1389769840-15469-2-git-send-email-lho@apm.com>
 <1389769840-15469-3-git-send-email-lho@apm.com>
Message-ID: <20140115113116.GC25824@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 07:10:38AM +0000, Loc Ho wrote:
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Tuan Phan <tphan@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  .../devicetree/bindings/phy/apm-xgene-phy.txt      |   94 ++++++++++++++++++++
>  1 files changed, 94 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/apm-xgene-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/apm-xgene-phy.txt b/Documentation/devicetree/bindings/phy/apm-xgene-phy.txt
> new file mode 100644
> index 0000000..4ffbae0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/apm-xgene-phy.txt
> @@ -0,0 +1,94 @@
> +* APM X-Gene 15Gbps Multi-purpose PHY nodes
> +
> +PHY nodes are defined to describe on-chip 15Gbps Multi-purpose PHY. Each
> +PHY (pair of lanes) has its own node.
> +
> +Required properties:
> +- compatible		: Shall be "apm,xgene-phy" or
> +			  "apm,xgene-phy-ext". The "apm,xgene-phy" describes
> +			  an PHY with internal reference PLL located within
> +			  the IP. The "apm,xgene-phy-ext" describes an PHY
> +			  where the internal reference PLL located outside of
> +			  the IP.

How about:

- compatible: shall contain one of:
  * "apm,xgene-phy" - PHY has an internal reference PLL.
  * "apm,xgene-phy-ext" - PHYs has an external reference PLL.

Cheers,
Mark.
