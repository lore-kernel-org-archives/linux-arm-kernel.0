From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 18 May 2012 07:16:55 +0000
Subject: [PATCH] ARM: OMAP2+: fix gpmc request_irq
In-Reply-To: <CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
References: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
 <CAMQu2gxQVFRk7FvmOzOkW8LYFYg5f4B_rJ0bsU4yJwN4i6X8_Q@mail.gmail.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E98DCBD@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Fri, May 18, 2012 at 12:33:16, Shilimkar, Santosh wrote:
> + Afzal who has been doing quite a bit of GMPC work recently.
> 
> On Fri, May 18, 2012 at 10:13 AM, Ming Lei <ming.lei@canonical.com> wrote:
> > The IRQ52 on OMAP2+ is not a shared interrupt line. If IRQF_SHARED
> > is passed to request_irq and dev_id is set as NULL, request_irq will
> > return -EINVAL.
> >
> GPMC IRQ line can shared between the multiple devices you
> connect on it.
:
> Are you sure it fails ?
> I just tried booting OMAP4 with 3.4-rc4 and don't see the irq
> failure error message. What I am missing ?

Issue happens on l-o master, this was mentioned in [1], now I feel
right solution is to keep dev-id.

Regards
Afzal

[1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg68749.html
