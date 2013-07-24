From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 24 Jul 2013 23:44:05 +0900
Subject: [PATCH 0/3] sh-pfc: Don't include mach/*.h headers were not
 required
In-Reply-To: <1374671368-4681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374671368-4681-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CANqRtoQHD9bk4uyAE9GAPvz_ZTLx1EtohFjaYhnetmwQ1Te1qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Wed, Jul 24, 2013 at 10:09 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Hello,
>
> The (long) road to multiplatform kernels requires getting rid of mach/*.h
> headers in device drivers. This patch set removes some of the included mach
> headers from the sh-pfc driver. The only remaining one is mach/irqs.h, to get
> the irq_pin() macro. This will require more work, see [1] for a discussion of
> the issue.

That's a blocker for some of the SoCs, right? I suppose the ones using
a separate GPIO controller are OK as-is?

> The patches are based on v3.11-rc2. Linus, do you usually pick pinctrl patches
> from the list, or should I send you a pull request ?
>
> [1] http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg473450.html
>
> Laurent Pinchart (3):
>   sh-pfc: Remove unneeded mach/<soc>.h includes
>   sh-pfc: sh7372: Replace <mach/irqs.h> with <linux/sh_intc.h>
>   sh-pfc: sh73a0: Remove EXT_IRQ16L and EXT_IRQ16H macros

These are fine with me. Thanks for your help!

Acked-by: Magnus Damm <damm@opensource.se>
