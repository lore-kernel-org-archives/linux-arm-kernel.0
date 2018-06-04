From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Jun 2018 16:07:10 +0100
Subject: [PATCH v12 4/5] arm64: Implement page table free interfaces
In-Reply-To: <98ef3cd0-a9a1-d5b5-f1a6-c0ab8b15ec6a@codeaurora.org>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
 <1527856758-27169-5-git-send-email-cpandya@codeaurora.org>
 <20180604121328.GG9482@arm.com>
 <98ef3cd0-a9a1-d5b5-f1a6-c0ab8b15ec6a@codeaurora.org>
Message-ID: <20180604150709.GA8593@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2018 at 07:13:18PM +0530, Chintan Pandya wrote:
> On 6/4/2018 5:43 PM, Will Deacon wrote:
> >On Fri, Jun 01, 2018 at 06:09:17PM +0530, Chintan Pandya wrote:
> >>+		next = addr;
> >>+		end = addr + PUD_SIZE;
> >>+		do {
> >>+			pmd_free_pte_page(entry, next);
> >>+		} while (entry++, next += PMD_SIZE, next != end);
> >>+
> >>+		pud_clear(pudp);
> >>+		__flush_tlb_kernel_pgtable(addr);
> >>+		pmd_free(NULL, table);
> >>+	}
> >>+	return 1;
> >
> >So with these patches, we only ever return 1 from these helpers. It looks
> >like the same is true for x86, so how about we make them void and move the
> >calls inside the conditionals in lib/ioremap.c? Obviously, this would be a
> >separate patch on the end.
> 
> That sounds valid code churn to me. But since x86 discussion is not
> concluded yet, I would wait to share until that gets resolved. May be
> not in v13 but separate effort. Would that be okay to you ?

Yes, fine by me.

Will
