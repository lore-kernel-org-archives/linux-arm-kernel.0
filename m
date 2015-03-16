From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 16 Mar 2015 15:23:29 +0800
Subject: [PATCH 05/10] ARM: zx: bring up the secondary core
In-Reply-To: <2076674.uPo0q8sg2C@wuerfel>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-6-git-send-email-jun.nie@linaro.org>
 <2076674.uPo0q8sg2C@wuerfel>
Message-ID: <20150316072327.GK20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 14, 2015 at 10:25:03PM +0100, Arnd Bergmann wrote:
> On Saturday 14 March 2015 19:49:40 Jun Nie wrote:
> > +
> > +       /*
> > +        * This is really belt and braces; we hold unintended secondary
> > +        * CPUs in the holding pen until we're ready for them.  However,
> > +        * since we haven't sent them a soft interrupt, they shouldn't
> > +        * be there.
> > +        */
> > +       write_pen_release(cpu);
> > +
> > 
> 
> Why do you need the holding pen on this platform? Is there a firmware
> bug or just missing hardware support for proper SMP power management?

Arnd,

As this is how things are handled in vendor's kernel, we thought the
hardware might be lack of SMP power management.  But we will check with
vendor to see if there is any level of hardware support for secondary
core management, so that we can save the use of holding pen.

Thanks for the comment.

Shawn
