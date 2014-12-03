From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 11:52:41 +0100
Subject: [PATCH 07/12] Documentation: dt: imx: add MSCM documentation
In-Reply-To: <1417565531-4507-8-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
 <1417565531-4507-8-git-send-email-stefan@agner.ch>
Message-ID: <57320597.hlx9GuXmaF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 01:12:06 Stefan Agner wrote:
> +Freescale Vybrid Miscellaneous System Control Module
> +
> +The MSCM IP contains Access Control and TrustZone Security hardware,
> +CPU Configuration registers and Interrupt Router control.
> +
> +Required properties:
> +- compatible : "fsl,vf610-mscm"
> +- reg : the register range of the MSCM module
> +
> +Example:
> +       mscm: mscm at 40001000 {                 
> +               compatible = "fsl,vf610-mscm";
> +               reg = <0x40001000 0x1000>;    
> +       };                                    

This sounds like one of those generic system controller devices.
Should this be marked as syscon an accessed through
syscon_regmap_lookup_by_phandle()?

If you only eve have one driver touching these registers, that
won't be necessary of course.

	arnd
