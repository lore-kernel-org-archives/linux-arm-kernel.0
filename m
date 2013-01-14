From: zonque@gmail.com (Daniel Mack)
Date: Mon, 14 Jan 2013 23:26:59 -0000
Subject: [PATCH v8 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <20130114180602.GV14149@atomide.com>
References: <1355481404-27695-1-git-send-email-zonque@gmail.com>
 <1355481404-27695-6-git-send-email-zonque@gmail.com>
 <CALF0-+UbqFF17X1Ok1s1AGKg6SBmvMc1mvjVuZb=Ej7xo+qcmA@mail.gmail.com>
 <20130114180602.GV14149@atomide.com>
Message-ID: <CACTFLAMT2-6VRkNSO3OF6X=afTYKRz=JcDkYqqyZ4VNT5xBVkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jan 15, 2013 2:06 AM, "Tony Lindgren" <tony@atomide.com> wrote:
>
> * Ezequiel Garcia <elezegarcia@gmail.com> [121223 13:49]:
> > On Fri, Dec 14, 2012 at 7:36 AM, Daniel Mack <zonque@gmail.com> wrote:
> > > +
> > > +Example for an AM33xx board:
> > > +
> > > +       gpmc: gpmc at 50000000 {
> > > +               compatible = "ti,am3352-gpmc";
> > > +               ti,hwmods = "gpmc";
> > > +               reg = <0x50000000 0x1000000>;
> > > +               interrupts = <100>;
> > > +               gpmc,num-cs = <8>;
> > > +               gpmc,num-waitpins = <2>;
> > > +               #address-cells = <2>;
> > > +               #size-cells = <1>;
> > > +               ranges = <0 0 0x08000000 0x2000>;       /* CS0: NAND
*/
> > > +
> > > +               nand at 0,0 {
> > > +                       reg = <0 0 0>; /* CS0, offset 0 */
> >
> > I'm a bit confused by this: what are the other two values in "reg"?
> > I see you've only added a binding for CS.
> >
> > I've extended a bit on your work and added a binding to enable OneNAND
> > device on my IGEP board.
> >
> > I might send some patches in case anyone wants to give it a try.
>
> Daniel, should this be updated to just pass the CS?

No, as Rob pointed out earlier in a thread about this topic, the 'ranges'
feature will help doing the math for the offset calculation eventually, so
we need to pass all three values.

Regards,
Daniel
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130114/c232814c/attachment.html>
