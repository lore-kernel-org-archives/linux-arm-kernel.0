From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 30 Sep 2014 19:21:49 +0200
Subject: [PATCH 4/6] hwrng: atmel: Add TRNG DT binding doc
In-Reply-To: <87bnpxoww9.fsf@dell.be.48ers.dk>
References: <1412093987-30241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412093987-30241-5-git-send-email-boris.brezillon@free-electrons.com>
 <87bnpxoww9.fsf@dell.be.48ers.dk>
Message-ID: <20140930192149.464ac50f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, 30 Sep 2014 19:12:22 +0200
Peter Korsgaard <peter@korsgaard.com> wrote:

> >>>>> "Boris" == Boris Brezillon <boris.brezillon@free-electrons.com> writes:
> 
>  > Document DT bindings of Atmel's TRNG (True Random Number Generator) IP.
>  > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>  > ---
>  >  Documentation/devicetree/bindings/hwrng/atmel-trng.txt | 16 ++++++++++++++++
>  >  1 file changed, 16 insertions(+)
>  >  create mode 100644 Documentation/devicetree/bindings/hwrng/atmel-trng.txt
> 
>  > diff --git a/Documentation/devicetree/bindings/hwrng/atmel-trng.txt b/Documentation/devicetree/bindings/hwrng/atmel-trng.txt
>  > new file mode 100644
>  > index 0000000..4ac5aaa
>  > --- /dev/null
>  > +++ b/Documentation/devicetree/bindings/hwrng/atmel-trng.txt
>  > @@ -0,0 +1,16 @@
>  > +Atmel TRNG (True Random Number Generator) block
>  > +
>  > +Required properties:
>  > +- compatible : Should be "atmel,at91sam9g45-trng"
>  > +- reg : Offset and length of the register set of this block
>  > +- interrupts : the interrupt number for the TRNG block
> 
> The interrupt isn't strictly speaking required as it isn't used by the
> driver, but as 9G45 has the signal wired up I guess it makes sense.

This irq might be used in a near future (in order to wait for data as
requested by hwrng code when the wait argument is true).
Thus I prefer to keep it as required.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
