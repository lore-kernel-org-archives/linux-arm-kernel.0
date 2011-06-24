From: premi@ti.com (Premi, Sanjeev)
Date: Fri, 24 Jun 2011 18:31:47 +0530
Subject: [PATCH 1/2] omap2+: pm: Use if...else instead of goto
In-Reply-To: <4E048A1F.7000303@ti.com>
References: <1308911742-27394-1-git-send-email-premi@ti.com>
	<1308911742-27394-2-git-send-email-premi@ti.com>
	<4E048793.1020505@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2EA4@dbde02.ent.ti.com>
	<4E048A1F.7000303@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2EAE@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shilimkar, Santosh 
> Sent: Friday, June 24, 2011 6:29 PM
> To: Premi, Sanjeev
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2] omap2+: pm: Use if...else instead of goto
> 
> On 6/24/2011 6:24 PM, Premi, Sanjeev wrote:
> >> -----Original Message-----
> >> From: Shilimkar, Santosh
> >> Sent: Friday, June 24, 2011 6:18 PM
> >> To: Premi, Sanjeev
> >> Cc: linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org
> >> Subject: Re: [PATCH 1/2] omap2+: pm: Use if...else instead of goto
> >>
> >> On 6/24/2011 4:05 PM, Sanjeev Premi wrote:
> >>> This patch replaces the use of goto with simple
> >>> if...else syntax. No change in functionality.
> >>>
> >>> This also means that the comment describing the
> >>> dependency between CONFIG_SMP and calculation
> >>> of loops_per_jiffy can be unified.
> >>>
> >>> Signed-off-by: Sanjeev Premi<premi@ti.com>
> >>> ---
> >> Don't see need of this patch as well considering your second patch.
> >> So NAK.
> >>
> > [sp] May be it isn't needed - but it surely highlights some
> >       bad code that does find way upstream.
> >
> If you think of using if else makes code better than use
> of goto, then I just ignore your comment. Because that means
> core scheduler code is also bad as per your remark which makes
> use of goto.

[sp] No. It is context based - and in this context goto isn't
     any good... because code it evaluates to simple if..else
     as we "goto" over just another instruction.

> 
> Regards
> Santosh
> 
