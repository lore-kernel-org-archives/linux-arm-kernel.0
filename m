From: nm@ti.com (Nishanth Menon)
Date: Thu, 31 May 2012 18:39:20 -0500
Subject: [PATCH 3/3] ARM: OMAP3+: PM: VP: check only the VPINIDLE status
 bit
In-Reply-To: <87k3zsvsm7.fsf@ti.com>
References: <1337369601-14915-1-git-send-email-nm@ti.com>
 <1337369601-14915-4-git-send-email-nm@ti.com>
 <87k3zsvsm7.fsf@ti.com>
Message-ID: <20120531233918.GC23870@horus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:27-20120531, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Currently we check against the entire 32 bits of the status register
> > Where, bits 1-31 are marked as reserved and mentioned in TRM as read
> > returns undefined values. 
> 
> ouch
> 
> > Hence, check against purely the vpinidle status bit.
> >
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: linux-omap at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> >
> > Reported-by: Vinay Amancha <vinaykumar@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Thanks for the fix.
> 
> Looking at this combined with the previous patches, since this same
> thing is done several places, it looks like we need a helper function
> 'omap_vp_wait_for_idle()' or similar.  That function will do the check,
> wait for timeout, and return an error if failure.  The callers can than
> do appropriate error handling upon failure.
> 
yep - i think a static inline should do just fine here considering just
a test_timeout is involved.
will post out a new series in a few mins.
-- 
Regards,
Nishanth Menon
