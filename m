From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 23 Feb 2016 06:02:55 +0000
Subject: [PATCH] ARM: at91: sama5/dts: move hsmc_clk out of nfc node
In-Reply-To: <56CB05EF.9020105@atmel.com>
References: <1455687741-9625-1-git-send-email-wenyou.yang@atmel.com>
 <56CB05EF.9020105@atmel.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641D642838E@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Ferre, Nicolas
> Sent: 2016?2?22? 20:58
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>; Rob Herring
> <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark Brown
> <broonie@kernel.org>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kumar
> Gala <galak@codeaurora.org>; Alexandre Belloni <alexandre.belloni@free-
> electrons.com>; Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>;
> Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Wu, Josh <Josh.wu@atmel.com>; Josh Wu
> <rainyfeeling@outlook.com>; Alexandre Belloni <alexandre.belloni@free-
> electrons.com>
> Subject: Re: [PATCH] ARM: at91: sama5/dts: move hsmc_clk out of nfc node
> 
> Le 17/02/2016 06:42, Wenyou Yang a ?crit :
> > From: Josh Wu <josh.wu@atmel.com>
> >
> > In sama5d3, sama5d4 chips, pmecc will use the hsmc clock. As pmecc is
> > part of HSMC. So move out hsmc_clk from nfc node to nand node.
> >
> > Signed-off-by: Josh Wu <rainyfeeling@outlook.com>
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> 
> I'm not against this change, but beware, it must be applied in synchronization with
> the patch just posted "[PATCH] mtd: atmel_nand:
> move the hsmc_clk from nfc node to nand node"

Okay, revert the mail address to the original one, keep it consistent.

And add this address to CC. 

> 
> Bye,
> 
> 
> > ---
> >
> >  arch/arm/boot/dts/sama5d3.dtsi |    2 +-
> >  arch/arm/boot/dts/sama5d4.dtsi |    2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/sama5d3.dtsi
> > b/arch/arm/boot/dts/sama5d3.dtsi index a532791..a242d27 100644
> > --- a/arch/arm/boot/dts/sama5d3.dtsi
> > +++ b/arch/arm/boot/dts/sama5d3.dtsi
> > @@ -1474,6 +1474,7 @@
> >  			atmel,nand-has-dma;
> >  			pinctrl-names = "default";
> >  			pinctrl-0 = <&pinctrl_nand0_ale_cle>;
> > +			clocks = <&hsmc_clk>;
> >  			atmel,pmecc-lookup-table-offset = <0x0 0x8000>;
> >  			status = "disabled";
> >
> > @@ -1486,7 +1487,6 @@
> >  					0xffffc000 0x00000070	/* NFC HSMC
> regs */
> >  					0x00200000 0x00100000	/* NFC
> SRAM banks */
> >  					>;
> > -				clocks = <&hsmc_clk>;
> >  			};
> >  		};
> >  	};
> > diff --git a/arch/arm/boot/dts/sama5d4.dtsi
> > b/arch/arm/boot/dts/sama5d4.dtsi index b8032bc..1499b33 100644
> > --- a/arch/arm/boot/dts/sama5d4.dtsi
> > +++ b/arch/arm/boot/dts/sama5d4.dtsi
> > @@ -295,6 +295,7 @@
> >  			atmel,nand-has-dma;
> >  			pinctrl-names = "default";
> >  			pinctrl-0 = <&pinctrl_nand>;
> > +			clocks = <&hsmc_clk>;
> >  			status = "disabled";
> >
> >  			nfc at 90000000 {
> > @@ -306,7 +307,6 @@
> >  					0xfc05c000 0x00000070	/* NFC
> HSMC regs */
> >  					0x00100000 0x00100000	/* NFC
> SRAM banks */
> >                                           >;
> > -				clocks = <&hsmc_clk>;
> >  				atmel,write-by-sram;
> >  			};
> >  		};
> >
> 
> 
> --
> Nicolas Ferre


Best Regards,
Wenyou Yang
