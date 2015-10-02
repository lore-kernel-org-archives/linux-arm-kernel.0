From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 02 Oct 2015 13:39:26 +0300
Subject: [PATCH v2 01/15] KVM: arm/arm64: VGIC: don't track used LRs in the
 distributor
In-Reply-To: <560E5D2F.1000401@arm.com>
References: <1436538111-4294-1-git-send-email-andre.przywara@arm.com>
 <1436538111-4294-2-git-send-email-andre.przywara@arm.com>
 <00cb01d0fcf8$6a906000$3fb12000$@samsung.com> <560E5D2F.1000401@arm.com>
Message-ID: <00d701d0fcfe$9cba1d40$d62e57c0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> For instance how did you come up with that 16384? LPIs could actually be
> much bigger (in fact the emulation currently support up to 64k).

 Well, read "at least 16384". I actually don't remember the exact value you've put in.

> >  Since the map itself is actually used only for piggy-back optimization, it is possible to
> easily
> > get rid of it using for_each_set_bit(lr, vgic_cpu->lr_used, vgic->nr_lr) iteration instead.
> 
> Can't you use the ELRSR bitmap instead? The idea of lr_used sounds like
> a moot optimization to me.

 I'll take a look. You seem to be right, lr_used became a direct (well, inverted) copy of elrsr
after full elrsr synchronization was introduced long time ago. It's just current code relying on
lr_used everywhere.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
