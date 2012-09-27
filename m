From: marex@denx.de (Marek Vasut)
Date: Thu, 27 Sep 2012 02:29:54 +0200
Subject: [PATCH 2/3] ARM: dts: imx53-qsb: Make DA9053 regulator functional
In-Reply-To: <CAOMZO5Bi7gMH4RE047-uxc5bhz_UuQpLArpOSMae03U08tebxA@mail.gmail.com>
References: <1348702057-2351-1-git-send-email-festevam@gmail.com>
 <201209270200.57482.marex@denx.de>
 <CAOMZO5Bi7gMH4RE047-uxc5bhz_UuQpLArpOSMae03U08tebxA@mail.gmail.com>
Message-ID: <201209270229.54462.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> Hi Marek,
> 
> On Wed, Sep 26, 2012 at 9:00 PM, Marek Vasut <marex@denx.de> wrote:
> > Dear Fabio Estevam,
> > 
> > [...]
> > 
> >> +                                     interrupt-parent = <&gpio7>;
> >> +                                     interrupts = <11 0x8>; /*
> >> low-level
> > 
> > active IRQ at GPIO7_11 */
> > 
> > You mean active-low ? :-)
> 
> Actually I meant 'active low level-sensitive':
> 
> From Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt:
> 
>  The second cell bits[3:0] is used to specify trigger type and level flags:
>       1 = low-to-high edge triggered.
>       2 = high-to-low edge triggered.
>       4 = active high level-sensitive.
>       8 = active low level-sensitive

Thank you, I need to update my knowledge on the imx v7 :)

> > What was the conclusion on over-using regulator-always-on ?
> 
> I will be glad to get some suggestions about this.
> 
> With the original code the regulators were getting disabled, which
> caused some key power supplies to be removed and then system died.
> 
> Looking at the mx53qsb/DA9053 board schematics I cannot see any of
> these supplies that can be turned-off, and that's why I kept the
> 'always-on' flag.

I agree, let's see what Mark has to say. I believe your approach is valid.

> Regards,
> 
> Fabio Estevam

Best regards,
Marek Vasut
