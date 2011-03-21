From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Mar 2011 13:19:07 +0000
Subject: [PATCH v4 08/19] ARM: LPAE: Introduce the 3-level page table
	format definitions
In-Reply-To: <20110321125606.GC22222@n2100.arm.linux.org.uk>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-9-git-send-email-catalin.marinas@arm.com>
	<AANLkTi=d0q0Upde3=b4tpu3icOr4XdifcFRvBHuXgsBN@mail.gmail.com>
	<20110124214225.GO24104@n2100.arm.linux.org.uk>
	<AANLkTikH9tBTGCiJ-+dvhh1tajMVq_6ua41MMZmq48sC@mail.gmail.com>
	<20110321125606.GC22222@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimZ+b_yNf1-72AGUMcPbFRFuHVPtvf24VigRWK-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 March 2011 12:56, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Mon, Mar 21, 2011 at 12:36:55PM +0000, Catalin Marinas wrote:
>> Any plans for the nopmd patches? I haven't seen them in -next or on the list.
>
> I dropped them again because of those pesky warnings, so again I'm not
> planning to push them this window as I don't wish to be deluged in
> people reporting the warnings.
>
> They really need fixing once we know how the LPAE stuff interacts with
> the change. ?At the moment I've no idea whether the existing section
> support ends up at pgd or pmd level with LPAE.

With LPAE, the section should be at the pmd level (2nd level page
table) as the PGDIR_SHIFT is 30. But if we standardise on using the
pmd in both cases, macros like pmd_val() would expand to the right
level with classic page tables (it goes up to pgd_val).

PMD_SHIFT also gets defined as PGDIR_SHIFT for the classic page
tables. One of my patches in the series converts the existing code to
PMD_SHIFT from PGDIR_SHIFT.

I'm happy to give this a try if you have some existing patches for the
classic page tables (I can even start from scratch but I don't want to
duplicate work).

-- 
Catalin
