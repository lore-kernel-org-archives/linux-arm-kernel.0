From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 14:54:27 +0300
Subject: [RFC/PATCH 02/13] serial: omap: always return IRQ_HANDLED
In-Reply-To: <20120821125005.235926e0@bob.linux.org.uk>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
 <1345540555-24359-3-git-send-email-balbi@ti.com>
 <20120821125005.235926e0@bob.linux.org.uk>
Message-ID: <20120821115426.GC10347@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 12:50:05PM +0100, Alan Cox wrote:
> On Tue, 21 Aug 2012 12:15:44 +0300
> Felipe Balbi <balbi@ti.com> wrote:
> 
> > Even if we enter our IRQ handler just to notice
> > that the our device didn't generate the IRQ,
> > that still means "handling" and IRQ, so let's
> > return IRQ_HANDLED.
> 
> That looks wrong - you'll defeat the stuck IRQ protection. If we didn't
> cause the IRQ then we are IRQ_NONE ?

that's true. I'll drop this patch from the list. My bad.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/3c2e60a4/attachment.sig>
