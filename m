From: nm@ti.com (Nishanth Menon)
Date: Thu, 21 Jun 2018 06:36:44 -0500
Subject: [PATCH 3/5] arm64: dts: ti: Add Support for AM654 SoC
In-Reply-To: <20180621053754.GD112168@atomide.com>
References: <20180619194253.27288-1-nm@ti.com>
 <20180619194253.27288-4-nm@ti.com>
 <20180621053754.GD112168@atomide.com>
Message-ID: <20180621113644.g24yzcixzeegsiks@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05:37-20180621, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [180619 19:46]:
> > +	cbass_main: cbass at 100000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x00100000 0x00 0x00100000 0x00020000>, /* ctrl mmr */
> > +			 <0x00600000 0x00 0x00600000 0x00001100>, /* GPIO */
> > +			 <0x00900000 0x00 0x00900000 0x00012000>, /* serdes */
> > +			 <0x01000000 0x00 0x01000000 0x0af02400>, /* Most peripherals */
> > +			 <0x30800000 0x00 0x30800000 0x0bc00000>, /* MAIN NAVSS */
> > +			 /* MCUSS Range */
> > +			 <0x28380000 0x00 0x28380000 0x03880000>,
> > +			 <0x40200000 0x00 0x40200000 0x00900100>,
> > +			 <0x42040000 0x00 0x42040000 0x03ac2400>,
> > +			 <0x45100000 0x00 0x45100000 0x00c24000>,
> > +			 <0x46000000 0x00 0x46000000 0x00200000>,
> > +			 <0x47000000 0x00 0x47000000 0x00068400>;
> > +
> > +		cbass_mcu: cbass at 28380000 {
> > +			compatible = "simple-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0x28380000 0x28380000 0x03880000>, /* MCU NAVSS*/
> > +				 <0x40200000 0x40200000 0x00900100>, /* First peripheral window */
> > +				 <0x42040000 0x42040000 0x03ac2400>, /* WKUP */
> > +				 <0x45100000 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
> > +				 <0x46000000 0x46000000 0x00200000>, /* CPSW */
> > +				 <0x47000000 0x47000000 0x00068400>; /* OSPI space 1 */
> > +
> > +			cbass_wakeup: cbass at 42040000 {
> > +				compatible = "simple-bus";
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +				/* WKUP  Basic peripherals */
> > +				ranges = <0x42040000 0x42040000 0x03ac2400>;
> > +			};
> > +		};
> > +	};
> > +};
> 
> You should use cbass_main: interconnect at 1000000 and so on here.
> Other than that looks good to me, thanks for updating it.

Thanks, will wait till Monday to see if there are any further comments,
else will post a V2.

-- 
Regards,
Nishanth Menon
