From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 8 Oct 2014 14:30:45 -0700
Subject: [RFC] pinctrl driver for Zynq
In-Reply-To: <CACRpkdaZ2Yy7=CcOjnsQ0K7KYTN=wHaeZTDNxpvnf+axLLLJ_g@mail.gmail.com>
References: <c2b9a1c1-d3b9-48c5-9c14-a4c3a95965fa@BN1AFFO11FD046.protection.gbl>
 <CACRpkdaZ2Yy7=CcOjnsQ0K7KYTN=wHaeZTDNxpvnf+axLLLJ_g@mail.gmail.com>
Message-ID: <b5dad4dd03004926a818446558bfdede@BY2FFO11FD018.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-10-07 at 01:05PM +0200, Linus Walleij wrote:
> On Wed, Sep 24, 2014 at 11:09 PM, S?ren Brinkmann
[...]
> > +++ b/drivers/pinctrl/Kconfig
> > @@ -305,6 +305,14 @@ config PINCTRL_PALMAS
> >           open drain configuration for the Palmas series devices like
> >           TPS65913, TPS80036 etc.
> >
> > +config PINCTRL_ZYNQ
> > +       bool "Pinctrl driver for Xilinx Zynq"
> > +       depends on ARCH_ZYNQ
> > +       select PINMUX
> > +       select GENERIC_PINCONF
> 
> Thanks for using generic pinconf. But you haven't implemented
> it yet?!

Muxing uses the generic pinconf stuff to parse the DT. Even for muxing
only I need this, I think. That codes needs to change with your
proposed change to introduce the 'groups' property.

	S?ren
