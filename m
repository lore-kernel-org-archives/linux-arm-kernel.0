From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 Jun 2014 16:37:27 +0100
Subject: [PATCHv2 1/4] arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
In-Reply-To: <CAPvkgC3rMhN0cvZsjX028XDk8esnyvi0GTSvcXFmn9ub_vcZuQ@mail.gmail.com>
References: <1401742658-11841-1-git-send-email-lauraa@codeaurora.org>
 <1401742658-11841-2-git-send-email-lauraa@codeaurora.org>
 <20140603152201.GP23149@arm.com>
 <CAPvkgC3rMhN0cvZsjX028XDk8esnyvi0GTSvcXFmn9ub_vcZuQ@mail.gmail.com>
Message-ID: <20140603153727.GR23149@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 04:31:57PM +0100, Steve Capper wrote:
> On 3 June 2014 16:22, Will Deacon <will.deacon@arm.com> wrote:
> 
> [ ... ]
> 
> >
> > We already have an isb in flush_tlb_kernel_range.
> 
> Hi Will,
> The following thread discusses the removal of the isb() from
> flush_tlb_kernel_range:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/252829.html
> 
> Also, I asked for it to be added to this series in this email thread
> but you thought it was benign:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/252869.html
> So we could probably do without the isb(.).

Bah, I'd completely forgotten all of that! Anyway, I'd say it's up to
the patch removing the existing isb from flush_tlb_kernel_range to fix
the callers, not for other people to anticipate that change.

Even with that change, the isb isn't needed, as mentioned in the second
link above.

Will
