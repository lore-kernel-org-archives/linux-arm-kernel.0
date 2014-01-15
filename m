From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jan 2014 12:17:07 +0100
Subject: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
In-Reply-To: <20140115110537.GA25824@e106331-lin.cambridge.arm.com>
References: <1389763265-27300-2-git-send-email-yao.yuan@freescale.com>
 <1389763265-27300-3-git-send-email-yao.yuan@freescale.com>
 <20140115110537.GA25824@e106331-lin.cambridge.arm.com>
Message-ID: <15900408.Osb5heuoGi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014 11:05:37 Mark Rutland wrote:
> On Wed, Jan 15, 2014 at 05:21:05AM +0000, Yuan Yao wrote:
> > --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> > +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> > @@ -4,11 +4,24 @@ Required properties:
> >  - compatible : Should be "fsl,<soc>-lpuart"
> >  - reg : Address and length of the register set for the device
> >  - interrupts : Should contain uart interrupt
> > +- clocks : from common clock binding: handle to uart clock
> > +- clock-names : from common clock binding: Shall be "ipg"
> 
> Why are these now requried if they weren't previously? That breaks old
> dts. I can't see any new code touching clocks. Was this an old but
> undocumented requirement?

It was previously required but not documented. I asked Yuan Yao to
add the text to the binding along with the new "dmas" addition.

It would have been cleaner to do this as a separate patch, but at
the very least it should be mentioned in the changelog.

	Arnd
