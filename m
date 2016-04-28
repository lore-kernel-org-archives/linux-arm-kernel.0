From: robh@kernel.org (Rob Herring)
Date: Wed, 27 Apr 2016 21:51:44 -0500
Subject: [PATCHv2 4/7] Documentation: dt: socfpga: Add Arria10 Ethernet
 binding
In-Reply-To: <1461606768-14404-5-git-send-email-tthayer@opensource.altera.com>
References: <1461606768-14404-1-git-send-email-tthayer@opensource.altera.com>
 <1461606768-14404-5-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160428025144.GA5837@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 12:52:45PM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the device tree bindings needed to support the Altera Ethernet
> FIFO buffers on the Arria10 chip.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2  No Change
> ---
>  .../bindings/arm/altera/socfpga-eccmgr.txt         |   24 ++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
> index 5a6b160..aa1c593 100644
> --- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
> @@ -76,6 +76,18 @@ Required Properties:
>  - compatible : Should be "altr,socfpga-a10-ocram-ecc"
>  - reg        : Address and size for ECC block registers.
>  
> +Ethernet FIFO ECC
> +Required Properties:
> +- compatible : Should be "altr,socfpga-a10-emac0-rx-ecc" for the 1st EMAC
> +	Receive	buffer
> +	or "altr,socfpga-a10-emac0-tx-ecc" for the 1st EMAC Transmit buffer
> +	or "altr,socfpga-a10-emac1-rx-ecc" for the 2nd EMAC Receive buffer
> +	or "altr,socfpga-a10-emac1-tx-ecc" for the 2nd EMAC Transmit buffer
> +	or "altr,socfpga-a10-emac2-rx-ecc" for the 3rd EMAC Receive buffer
> +	or "altr,socfpga-a10-emac2-tx-ecc" for the 3rd EMAC Transmit buffer

These blocks don't really appear to be different other than the 
interrupt mask (which is in another block?). I think they should be the 
same compatible with a property for the interrupt (perhaps a full 
interrupt-controller binding). 

> +- reg        : Address and size for ECC block registers.
> +- parent     : phandle to parent Ethernet node.

Needs a better name and altr prefix. Maybe altr,eth-mac?

Rob
