From: robh@kernel.org (Rob Herring)
Date: Tue, 19 Jan 2016 11:16:11 -0600
Subject: [LINUX PATCH 4/5] Documentation: mmc: Updated the binding doc
 for Arasan SDHCI.
In-Reply-To: <1453213055-35563-4-git-send-email-lakshmis@xilinx.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
 <1453213055-35563-4-git-send-email-lakshmis@xilinx.com>
Message-ID: <20160119171611.GA2708@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 07:47:34PM +0530, P L Sai Krishna wrote:
> This patch adds broken-mmc-highspeed property to the binding
> doc for Arasan SDHCI.
> 
> Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 2088d9f..5884832 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -20,7 +20,8 @@ Required Properties:
>  Optional Properties:
>    - broken-tuning: Indicates tuning broken in Silicon 1.0 of
>  			  Zynq Ultrascale+ MPSoC.
> -
> +  - broken-mmc-highspeed: Indicates to force
> +				the controller to use in standard speed.

We already have the inverse of this with "cap-mmc-highspeed".

The only potential problem is it will need to be added to existing DTs 
if you start disabling high speed by default. Maybe that's not an issue 
for users of the Arasan driver.

Otherwise, you should determine this with a more specific compatible 
string.

Rob
