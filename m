From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 19 Feb 2010 10:43:53 +0530
Subject: [PATCH 2/9] omap2/3/4: ioremap omap_globals module
In-Reply-To: <87wryaji6j.fsf@deeprootsystems.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
	<1266483554-15044-2-git-send-email-santosh.shilimkar@ti.com>
	<87wryaji6j.fsf@deeprootsystems.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C417FA23@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at deeprootsystems.com]
> Sent: Friday, February 19, 2010 3:55 AM
> To: Shilimkar, Santosh
> Cc: tony at atomide.com; linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/9] omap2/3/4: ioremap omap_globals module
> 
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
> > This is a clean-up patch towards dynamic allocation of IO space
> > instead of using harcoded macros to calculate virtual addresses.
> >
> > Also update the sdrc, prcm, tap and control module to
> > allocate iospace dynamically
> 
> You should drop the referenece to the TAP here since it's dropped.
> 
> > As per Tony's suggestion V2 version drops tap changes
> > becasue ioremap uses cpu_is_omap2420() and cpu_is_omap2430(),
> > so we can't use that for setting tap_base. Hence ioremap()
> > won't work for tap until omap2_check_revision() is done
> 
> And this type of comment should come after the '---' since
> it's relevant to the reviewers, but not to the final git history.
> 
> 
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > CC: Kevin Hilman <khilman@deeprootsystems.com>
> > CC: Tony Lindgren <tony@atomide.com>
> 
> After that, you can change the CC for me to a Reviewed-by.

Refreshed version attached with style fix and adding the Paul, Kevin's
Reviewed-by.

Regards,
Santosh
 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-omap2-3-4-ioremap-omap_globals-module.patch
Type: application/octet-stream
Size: 7220 bytes
Desc: 0002-omap2-3-4-ioremap-omap_globals-module.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100219/4426dd04/attachment-0001.obj>
