From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Mar 2012 17:07:38 +0200
Subject: [PATCH 01/12] mfd: twl-core: don't depend on pdata->irq_base/end
In-Reply-To: <87pqcegapk.fsf@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-2-git-send-email-b-cousson@ti.com>
 <87pqcegapk.fsf@ti.com>
Message-ID: <20120319150736.GM25935@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 14, 2012 at 01:59:51PM -0700, Kevin Hilman wrote:
> Benoit Cousson <b-cousson@ti.com> writes:
> 
> > From: Felipe Balbi <balbi@ti.com>
> >
> > With sparse IRQs the driver shouldn't depend at all on
> > any IRQ values coming from board-file.
> >
> > Remove every occurences of pdata->irq_base/end.
> 
> Well, not quite *every*. :)
> 
> If the driver isn't going to use those fields anymore, they should also
> be removed from the pdata struct too[1].  Also, the remaining board/init
> code that is initializing those fields should be removed as well[2], since
> it obviously has no effect.

indeed, but the idea was to decouple driver changes from arch/arm/*omap*
changes minimizing the oportunity of conflicts. So, e.g. on v3.4 we
change driver and on v3.5 we change board files.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120319/87cc24ee/attachment.sig>
