From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 Feb 2018 06:58:00 +0100
Subject: [PATCH] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <20180213232812.31408-1-marek.vasut+renesas@gmail.com>
References: <20180213232812.31408-1-marek.vasut+renesas@gmail.com>
Message-ID: <20180214055800.od5yhgo753522yah@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> - * The r8a7790/lager and r8a7791/koelsch development boards have da9063 and
> - * da9210 regulators.  Both regulators have their interrupt request lines tied
> - * to the same interrupt pin (IRQ2) on the SoC.
> + * The r8a7790/lager,stout and r8a7791/koelsch development boards have da9063
> + * and da9210 regulators.  Both regulators have their interrupt request lines
> + * tied to the same interrupt pin (IRQ2) on the SoC.

I think listing the boards here doesn't scale well. Gose is already
missing. How about rephrasing the paragraph to something like "Some Gen2
development boards have..."?

>   *
>   * After cold boot or da9063-induced restart, both the da9063 and da9210 seem
>   * to assert their interrupt request lines.  Hence as soon as one driver
> @@ -118,6 +118,7 @@ static int __init rcar_gen2_regulator_quirk(void)
>  
>  	if (!of_machine_is_compatible("renesas,koelsch") &&
>  	    !of_machine_is_compatible("renesas,lager") &&
> +	    !of_machine_is_compatible("renesas,stout") &&
>  	    !of_machine_is_compatible("renesas,gose"))
>  		return -ENODEV;
>  
> -- 
> 2.15.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180214/5c6ad971/attachment.sig>
