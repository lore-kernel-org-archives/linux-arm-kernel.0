From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Oct 2015 20:59:19 +0100
Subject: [PATCH v2] arm64: dts: Added syscon-reboot node for FSL's LS2085A
 SoC
In-Reply-To: <CY1PR0301MB07483E9D229314891961B6AD872F0@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1446066584-3738-1-git-send-email-German.Rivera@freescale.com>
 <3919319.0f6zV1T7g0@wuerfel>
 <CY1PR0301MB07483E9D229314891961B6AD872F0@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <3842856.zmPu9RX8Gg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 October 2015 16:34:26 Stuart Yoder wrote:
> My suggestion is to perhaps make that more explicit in the proposed
> device tree node, by making the reg size "4" and naming it
> as per the register name
> 
>        rstcr: rstcr at 1E60000 {
>                compatible = "syscon";
>                reg = <0x0 0x1E60000 0x0 0x4>;
>        };
> 
> The intent is really just to expose a single reset register
> and use syscon-reboot until PSCI is available.

I would rather see a more specific compatible string here that describes
the actual name, e.g.

	compatible = "fsl,ls2085a-rstcr", "syscon";

this way we have the option of making it a real driver later on by matching
on the specific string, but using the fallback syscon string otherwise.

BTW, please change the address to lowercase letters in both the node name and
the reg property. I would also change the name to 'syscon' instead of 'rstcr',
making that

	rstcr: syscon at 1e60000 {
		...
	};

	Arnd
