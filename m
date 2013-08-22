From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 22 Aug 2013 09:57:42 +0200
Subject: [PATCH v7 1/7] ARM: common: vic: Parse interrupt and resume masks
 from device tree
In-Reply-To: <CACRpkdboi3MUiUSDuhjwsjzVH3y9bYf9VpyfWK6PCkV-0fUZzw@mail.gmail.com>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
 <1377120111-25601-2-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdboi3MUiUSDuhjwsjzVH3y9bYf9VpyfWK6PCkV-0fUZzw@mail.gmail.com>
Message-ID: <1741526.ERsruKK5Pm@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 of August 2013 01:19:34 Linus Walleij wrote:
> On Wed, Aug 21, 2013 at 11:21 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > +++ b/Documentation/devicetree/bindings/arm/vic.txt
> > 
> > @@ -18,6 +18,9 @@ Required properties:
> >  Optional properties:
> >  
> >  - interrupts : Interrupt source for parent controllers if the VIC is
> >  nested.> 
> > +- interrupt-mask : Bit mask of valid interrupt sources (defaults to
> > all valid) +- wakeup-mask : Bit mask of interrupt sources that can
> > wake up the system +  (defaults to all allowed)
> 
> The "interrupt-mask" is called "valid-mask" on the FPGA IRQ controller
> See
> Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt
> 
> Example:
> 
>                 reg = <0x10000040 0x100>;
>                 clear-mask = <0xffffffff>;
>                 valid-mask = <0x00000007>;
> 
> Please use the same name.

Oh, I haven't noticed that. Thanks for the information.

Best regards,
Tomasz
