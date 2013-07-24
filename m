From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 24 Jul 2013 16:49:45 +0200
Subject: [PATCH 0/3] sh-pfc: Don't include mach/*.h headers were not
 required
In-Reply-To: <CANqRtoQHD9bk4uyAE9GAPvz_ZTLx1EtohFjaYhnetmwQ1Te1qg@mail.gmail.com>
References: <1374671368-4681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CANqRtoQHD9bk4uyAE9GAPvz_ZTLx1EtohFjaYhnetmwQ1Te1qg@mail.gmail.com>
Message-ID: <2297366.cgFF8sJl8f@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Wednesday 24 July 2013 23:44:05 Magnus Damm wrote:
> On Wed, Jul 24, 2013 at 10:09 PM, Laurent Pinchart wrote:
> > Hello,
> > 
> > The (long) road to multiplatform kernels requires getting rid of mach/*.h
> > headers in device drivers. This patch set removes some of the included
> > mach headers from the sh-pfc driver. The only remaining one is
> > mach/irqs.h, to get the irq_pin() macro. This will require more work, see
> > [1] for a discussion of the issue.
> 
> That's a blocker for some of the SoCs, right? I suppose the ones using a
> separate GPIO controller are OK as-is?

Yes. It's a multiplatform blocker for r8a73a4, r8a7740 and sh73a0. SoCs using 
a separate GPIO controller are fine (although the same problem might pop up 
for future SoCs with a separate GPIO controller if the GPIO IRQs are handled 
by a device separate from the GPIO controller).

> > The patches are based on v3.11-rc2. Linus, do you usually pick pinctrl
> > patches from the list, or should I send you a pull request ?
> > 
> > [1]
> > http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg473450.html
> > 
> > Laurent Pinchart (3):
> >   sh-pfc: Remove unneeded mach/<soc>.h includes
> >   sh-pfc: sh7372: Replace <mach/irqs.h> with <linux/sh_intc.h>
> >   sh-pfc: sh73a0: Remove EXT_IRQ16L and EXT_IRQ16H macros
> 
> These are fine with me. Thanks for your help!
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thank you.

-- 
Regards,

Laurent Pinchart
