From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 11 Jul 2018 11:35:41 -0700
Subject: [PATCH] ARM: dts: imx: Add ZII SCU3 ESB
In-Reply-To: <20180711145713.GB14155@lunn.ch>
References: <20180711050704.11492-1-andrew.smirnov@gmail.com>
 <20180711145713.GB14155@lunn.ch>
Message-ID: <CAHQ1cqF_=S1hHkLdenuByi0e=71DdkjPWcHBrm-rSMYpE_k3ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 7:57 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Jul 10, 2018 at 10:07:04PM -0700, Andrey Smirnov wrote:
> > +             switch at 0 {
> > +                     compatible = "marvell,mv88e6085";
> > +                     reg = <0>;
> > +                     dsa,member = <0 0>;
> > +                     eeprom-length = <512>;
> > +                     interrupt-parent = <&gpio4>;
> > +                     interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> > +                     interrupt-controller;
> > +                     #interrupt-cells = <2>;
>
> Hi Andrey
>
> I don't see a pinmux for this GPIO. Is one needed?

I got lucky and this pin is configured in GPIO mode out of reset. But
strictly speaking, yeah, I think there should be a pinmux entry for
this. Since things are working as is, I'll send a separate patch
adding that instead of re-spinning this one.

Thanks
Andrey Smirnov
