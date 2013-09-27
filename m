From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Sep 2013 10:51:17 +0800
Subject: device tree binding documentation outdated
In-Reply-To: <CACRpkda9HZ4JKnidnJJh-HkhCgtvJwQPQJnv9CZ4iYcQP36_Nw@mail.gmail.com>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <CACRpkda9HZ4JKnidnJJh-HkhCgtvJwQPQJnv9CZ4iYcQP36_Nw@mail.gmail.com>
Message-ID: <20130927025116.GG25146@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 11:35:43PM +0200, Linus Walleij wrote:
> On Thu, Sep 26, 2013 at 10:29 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Thu, Sep 26, 2013 at 4:51 PM, Russell King - ARM Linux
> 
> >> I mean the stuff which looks like this:
> >>
> >> #define MX6QDL_PAD_ENET_MDC__ESAI_TX5_RX0           0x1e8 0x5b8 0x858 0x2 0x0
> >
> > Let me try to decode it:
> >
> > 0x1e8: Offset of IOMUXC_SW_MUX_CTL_PAD_ENET_MDC register
> >
> > 0x5b8: Offset of IOMUXC_SW_PAD_CTL_PAD_ENET_MDC register
> >
> > 0x2: This means that the MUX_MODE field selects the ESAI_TX5_RX0 function
> > in this pad
> >
> > 0x0: SELECT_INPUT not used for this pad
> 
> This I guess predates the inctroduction of defines into the DTC,
> but we can do a lot better now.
> 
> Can someone from the i.MX camp take a sweep and convert this
> to defines in some include/dt-bindings/imx.h or similar file so
> this thing becomes readable?

We call those macros like MX6QDL_PAD_ENET_MDC__ESAI_TX5_RX0 in
imx6q-pinfunc.h pin function ID.  It's all about choosing a pinmux
function (ESAI_TX5_RX0) for given pad (MX6QDL_PAD_ENET_MDC), and
that's all what users care and need to read from the macro.  The
decoding of the macro is the register details that users do not care in
general.  But fsl,pinctrl bindings doc documented these details anyway.

Shawn
