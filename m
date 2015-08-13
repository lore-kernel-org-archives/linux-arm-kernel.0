From: balbi@ti.com (Felipe Balbi)
Date: Thu, 13 Aug 2015 10:47:36 -0500
Subject: [PATCH-next 1/4] Revert "ARM: 7655/1: smp_twd: make
 twd_local_timer_of_register() no-op for nosmp"
In-Reply-To: <20150813153707.GF7576@n2100.arm.linux.org.uk>
References: <1439409416-32673-1-git-send-email-balbi@ti.com>
 <1439409416-32673-2-git-send-email-balbi@ti.com>
 <20150813153707.GF7576@n2100.arm.linux.org.uk>
Message-ID: <20150813154736.GI27560@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 04:37:07PM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 12, 2015 at 02:56:53PM -0500, Felipe Balbi wrote:
> > This reverts commit 904464b91eca8c665acea033489225af02eeb75a.
> > 
> > The problem pointed out by commit 904464b91eca ("ARM: 7655/1:
> > smp_twd: make twd_local_timer_of_register() no-op for nosmp")
> > doesn't exist anymore.
> > 
> > We can safely boot with nosmp and the warning won't show up.
> > 
> > The other side benefit of this patch is that TWD has a chance
> > to probe on single-core A9 systems such as AM437x which sport
> > TWD.
> 
> I don't remember all the details from Feb 2013 on why we made that
> change.  If this is proven safe, then I guess it's okay.

Do you want me to upload to your patch system and, perhaps, keep in
linux-next for v4.4 merge window ? (too late for v4.3 I guess).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150813/67ef08f1/attachment-0001.sig>
