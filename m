From: robh@kernel.org (Rob Herring)
Date: Tue, 21 Jun 2016 08:33:40 -0500
Subject: [PATCHv4 4/7] Documentation: dt: socfpga: Add Arria10 Ethernet
 binding
In-Reply-To: <1466434252-26107-5-git-send-email-tthayer@opensource.altera.com>
References: <1466434252-26107-1-git-send-email-tthayer@opensource.altera.com>
 <1466434252-26107-5-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160621133340.GA9073@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 09:50:49AM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the device tree bindings needed to support the Altera Ethernet
> FIFO buffers on the Arria10 chip.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2  No Change
> v3  Change to common compatible string based on maintainer comments
>     Add local IRQ values.
> v4  Add compatible string for parent node.
> ---
>  .../bindings/arm/altera/socfpga-eccmgr.txt         |   24 ++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
> index 15eb0df..7c714ba 100644
> --- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
> @@ -82,6 +82,14 @@ Required Properties:
>  - interrupts : Should be single bit error interrupt, then double bit error
>  	interrupt, in this order.
>  
> +Ethernet FIFO ECC
> +Required Properties:
> +- compatible : Should be "altr,socfpga-eth-mac-ecc"
> +- reg        : Address and size for ECC block registers.
> +- parent     : phandle to parent (altr,socfpga-stmmac) Ethernet node.

Sorry if I wasn't clear before, but I was suggesting changing 'parent' 
to 'altr,ethernet-mac':

altr,ethernet-mac = <&gmac0>;

Rob
