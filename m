From: robh@kernel.org (Rob Herring)
Date: Fri, 31 Aug 2018 08:18:36 -0400
Subject: [PATCH 2/3] dt-bindings: firmware: coreboot: document board
 variant properties
In-Reply-To: <20180822120214.11848-2-heiko@sntech.de>
References: <20180822120214.11848-1-heiko@sntech.de>
 <20180822120214.11848-2-heiko@sntech.de>
Message-ID: <20180831121836.GA23441@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2018 at 02:02:13PM +0200, Heiko Stuebner wrote:
> Since at least 2014 coreboot exports board specific variant ids for
> board-revision, used ram-modules and component variants on the same board
> into the loaded devicetree.
> 
> These are set on all devicetree-based Chromebooks since then, so at
> least we can make the effort to document these long-used properties.

Long used, but never reviewed, so that doesn't really matter.

> 
> A case where these are used is for example to determine the touchscreen
> type that is only identifyable via the sku-id when updating its firmware
> on the Scarlet tablet from the Gru ChromeOS family.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/firmware/coreboot.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/coreboot.txt b/Documentation/devicetree/bindings/firmware/coreboot.txt
> index 4c955703cea8..cfc7623e2577 100644
> --- a/Documentation/devicetree/bindings/firmware/coreboot.txt
> +++ b/Documentation/devicetree/bindings/firmware/coreboot.txt
> @@ -21,6 +21,12 @@ Required properties:
>  	0xc0389481 that resides in the topmost 8 bytes of the area.
>  	See coreboot's src/include/imd.h for details.
>  
> +Board variant properties determined via strapping measures (like gpios):
> + - board-id: board-specific id indicating the board-revision
> + - ram-code: board-specific id identifying the used ram-module
> + - sku-id: board-specific id indicating a variant (using different
> +           display panels for example)

The appear to be consumed by coreboot, but the purpose of the /firmware 
nodes has describing firmware interfaces provided by the platform. 

Not saying we can't put things to configure the firmware there, but it 
would be a departure and something we should consider. These properties 
aren't really coreboot specific and probably belong at the root node. 
Though I think we already discussed a 'board-id' property for QCom (and 
ended up with a compatible string approach instead.

Rob
