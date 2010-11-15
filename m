From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Nov 2010 21:46:14 +0000
Subject: [PATCH v2 04/20] ARM: LPAE: Do not assume Linux PTEs are always
	at PTRS_PER_PTE offset
In-Reply-To: <20101115174251.GB31421@n2100.arm.linux.org.uk>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-5-git-send-email-catalin.marinas@arm.com>
	<20101115174251.GB31421@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinej2U_tEWM25m7VW7=PndxVPohaKjJ=10wn+C1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2010 17:42, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 12, 2010 at 06:00:24PM +0000, Catalin Marinas wrote:
>> Placing the Linux PTEs at a 2KB offset inside a page is a workaround for
>> the 2-level page table format where not enough spare bits are available.
>> With LPAE this is no longer required. This patch changes such assumption
>> by using a different macro, LINUX_PTE_OFFSET, which is defined to
>> PTRS_PER_PTE for the 2-level page tables.
>
> Hmm. ?I think we should be doing this a different way - in fact, I think
> we should switch the order of the linux vs hardware page tables. ?This
> actually simplifies the code a bit too - notice that we lose the arith.
> in __pte_map, __pte_unmap, pmd_page_vaddr, which is all page table
> walking stuff.

It looks like a good clean-up to me (though I need some refactoring on
my LPAE patches). Do you plan to push this upstream? If you add a
comment and a signed-off line, I can carry it in my LPAE branch until
it appears in mainline.

Thanks.

-- 
Catalin
