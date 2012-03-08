From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Mar 2012 09:21:22 +0000
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <4F57FED8.7050708@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-2-git-send-email-bill4carson@gmail.com>
 <20120229103207.GB17745@arm.com> <4F4E0BDE.6040708@gmail.com>
 <20120229153814.GK17745@arm.com> <4F57FED8.7050708@gmail.com>
Message-ID: <20120308092121.GA26727@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 12:35:36AM +0000, bill4carson wrote:
> On 2012?02?29? 23:38, Catalin Marinas wrote:
> > On Wed, Feb 29, 2012 at 11:28:30AM +0000, bill4carson wrote:
> >> On 2012?02?29? 18:32, Catalin Marinas wrote:
> >>> On Mon, Feb 13, 2012 at 09:44:22AM +0000, Bill Carson wrote:
> >>>> +static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
> >>>> +					   unsigned long addr, pte_t *ptep)
> >>>> +{
> >>>> +	pte_t old_pte = *ptep;
> >>>> +	set_huge_pte_at(mm, addr, ptep, pte_wrprotect(old_pte));
> >>>> +}
> >>>
> >>> You could use the generic ptep_set_wrprotect()
> >>
> >> I'm a bit of confused about this.
> >>
> >> generic ptep_set_wrprotect() can not set huge pte, that's why
> >> set_huge_pte_at is used instead here.
> >
> > Ah, the generic one can only work with with LPAE where set_huge_pte_at()
> > is just a set_pte_at(). So this part looks good.
> 
> Thanks for your time to review PATCH1/7 :)
> 
> I'm wondering if reset of this patch set is ok,
> I would like to start working on V3 as per your comments.

I haven't finished looking through the patches. Probably I will by the
end of this week.

-- 
Catalin
