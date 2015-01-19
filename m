From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Jan 2015 23:25:15 +0100
Subject: [PATCH 1/6] dt: bindings: update mvebu-mbus DT binding with new
 compatible properties
In-Reply-To: <1419943428-18491-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1419943428-18491-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150119222515.GE2938@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 01:43:42PM +0100, Thomas Petazzoni wrote:
> Contrary to what was originally thought, the Armada 375 and Armada 38x
> MBus windows hardware block is *not* compatible with the Armada 370,
> due to a difference in how window 13 is handled. It was rather
> compatible with the Armada XP MBus hardware block.
> 
> However, the DTs for Armada 375 and Armada 38x encode the following
> compatible string for MBus:
> 
>   compatible = "marvell,armada375-mbus", "marvell,armada370-mbus", "simple-bus";
>   compatible = "marvell,armada380-mbus", "marvell,armada370-mbus", "simple-bus";
> 
> So, by extending the mvebu-mbus DT binding to also cover the
> marvell,armada375-mbus and marvell,armada380-mbus compatible strings,
> we can define a new behavior for those SoCs without changing the DT.
> 
> Therefore, this commit adds those two new compatible strings to the DT
> binding documentation of mvebu-mbus. Note that it re-uses two existing
> duplicated lines for the armada370-mbus and armadaxp-mbus compatible
> strings.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Added to mvebu/dt

      Andrew

> ---
>  Documentation/devicetree/bindings/bus/mvebu-mbus.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/bus/mvebu-mbus.txt b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
> index 5e16c3c..fa6cde4 100644
> --- a/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
> +++ b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
> @@ -6,8 +6,8 @@ Required properties:
>  - compatible:	 Should be set to one of the following:
>  		 marvell,armada370-mbus
>  		 marvell,armadaxp-mbus
> -		 marvell,armada370-mbus
> -		 marvell,armadaxp-mbus
> +		 marvell,armada375-mbus
> +		 marvell,armada380-mbus
>  		 marvell,kirkwood-mbus
>  		 marvell,dove-mbus
>  		 marvell,orion5x-88f5281-mbus
> -- 
> 2.1.0
> 
