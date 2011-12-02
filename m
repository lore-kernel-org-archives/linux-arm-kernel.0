From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 02 Dec 2011 18:53:58 +0100
Subject: [PATCH] net/macb: add DT support
In-Reply-To: <20111202172854.GB4998@totoro>
References: <20111202153832.GA4998@totoro>
 <1322846050-4543-1-git-send-email-nicolas.ferre@atmel.com>
 <20111202172854.GB4998@totoro>
Message-ID: <4ED910B6.7080000@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2011 06:28 PM, Jamie Iles :
> Hi Nicolas,
>
> On Fri, Dec 02, 2011 at 06:14:10PM +0100, Nicolas Ferre wrote:
>> From: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
>>
>> Allow the device tree to provide the mac address and the phy mode.
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
>> [nicolas.ferre at atmel.com: change "compatible" node property, doc and DT hwaddr]
>> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
>> Cc: Jamie Iles<jamie@jamieiles.com>
>
> Looks nice to me.  There's a patch below to add the GEM stuff to the
> binding too if you want to role that in.

Yes, I will push it in a "v3" (I was busy correcting a bug and did not 
see your answer before sending v2...).

> Acked-by: Jamie Iles<jamie@jamieiles.com>
>
> 8<----
>
> diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
> index 7f0b90a..e09e3fb 100644
> --- a/Documentation/devicetree/bindings/net/macb.txt
> +++ b/Documentation/devicetree/bindings/net/macb.txt
> @@ -1,9 +1,11 @@
> -* Cadence MACB Ethernet controller
> +* Cadence MACB/GEM Ethernet controller
>
>   Required properties:
> -- compatible: Should be "cdns,[<chip>-]macb"
> +- compatible: Should be "cdns,[<chip>-]{macb,gem}"
>     Use "cdns,at91sam9260-macb" Atmel at91sam9260 and at91sam9263 SoCs.
>     Use "cdns,at32ap7000-macb" for other 10/100 usage or use the generic form: "cdns,macb"
> +  Use "cnds,pc302-gem" for Picochip picoXcell pc302 and later devices based on
> +  the Cadence GEM, or the generic form "cdns,gem".
>   - reg: Address and length of the register set for the device
>   - interrupts: Should contain macb interrupt
>   - phy-mode: String, operation mode of the PHY interface.
> diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
> index 103c6e6..89060e6 100644
> --- a/drivers/net/ethernet/cadence/macb.c
> +++ b/drivers/net/ethernet/cadence/macb.c
> @@ -1247,6 +1247,8 @@ static const struct of_device_id macb_dt_ids[] = {
>   	{ .compatible = "cdns,at32ap7000-macb" },
>   	{ .compatible = "cdns,at91sam9260-macb" },
>   	{ .compatible = "cdns,macb" },
> +	{ .compatible = "cdns,pc302-gem" },
> +	{ .compatible = "cdns,gem" },
>   	{ /* sentinel */ }
>   };

BTW, I think we may also modify the MII/RMII selection code for adding 
gigabit selection... but maybe you already have the patches?

Best regards,
-- 
Nicolas Ferre
