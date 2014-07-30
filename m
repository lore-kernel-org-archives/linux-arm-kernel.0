From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Wed, 30 Jul 2014 02:11:48 +0000
Subject: [PATCHv2 2/3] ARM: dts: vf610-twr: Add PWM0's pinctrl node
In-Reply-To: <8738dkuh7a.fsf@nbsps.com>
References: <1395627736-5338-1-git-send-email-Li.Xiubo@freescale.com>
 <1395627736-5338-3-git-send-email-Li.Xiubo@freescale.com>
 <8738dkuh7a.fsf@nbsps.com>
Message-ID: <4eb97d0849cd4a4787d8405df7391816@BN1PR0301MB0609.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill Pringlemeir,

> > diff --git a/arch/arm/boot/dts/vf610-twr.dts
> > b/arch/arm/boot/dts/vf610-twr.dts index f3af8ea..3fabdb5 100644 ---
> > a/arch/arm/boot/dts/vf610-twr.dts +++
> > b/arch/arm/boot/dts/vf610-twr.dts @@ -213,6 +213,17 @@
> > 			>;
> > 		};
> >
> > + pinctrl_pwm0: pwm0grp { + fsl,pins = < + VF610_PAD_PTB0__FTM0_CH0
> 
> Hi Xiubo,
> 
> I think you added this for the tower audio board?  Maybe the beeper?

For the PWM leds and beepers, for now only the ch0~ch3 are used here.

> Are these lines needed?
> 
> +	VF610_PAD_PTB6__FTM0_CH6		0x1582
> +	VF610_PAD_PTB7__FTM0_CH7		0x1582
> 
> According to my tower schematics, PTB6 routes to the Primary B35/GPIO4,
> and B40/FTM0CH6/PWM4 and to the jumpers J23.  PTB7 routes to
> B39/FTM0CH7/PWM5, EIRQ3/B55/B56, and jumper J24.  I think that most
> people have some tower serial card which can also route these lines
> and/or they are sent to the OpenSDA chip which does a ttyACM (USB
> serial) on all Tower main boards.
> 
> Did you just add all FTM channels 0-7 in the DTS?  Or are each and every
> one mapped to a pin on the expansion/riser boards.  Could we remove the
> two lines above and use,
> 
> 	pinctrl_uart2: uart2grp {
> 		fsl,pins = <
>                         VF610_PAD_PTB6__UART2_TX                0x21a2
>                         VF610_PAD_PTB7__UART2_RX                0x21a1
> 		>;
> 	};
> 
> So that the PTB6/7 map to UART2?  Or are these indeed a conflict with
> some audio board (or other)? 

There hasn't any confliction with audio board as far as I know.
I think they can be removed.


> I think it might be valuable to add the
> 'ttyLP2' to the vf610-twr.  An MMC image could echo 'wrong serial port,
> set J23/24' for instance to tell people that the serial console was not
> connected properly (or something else).  People may also wish to use a
> serial interface for other peripherals or as a 2nd debug port.
> 

Hum, if so I think it's okay.

@Shawn,

Do you have any comments here ?


Thanks,

BRs
Xiubo



> Thanks,
> Bill Pringlemeir.
