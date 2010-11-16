From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Nov 2010 10:02:44 +0000
Subject: [PATCH v2 02/20] ARM: LPAE: Factor out 2-level page table
	definitions into separate files
In-Reply-To: <20101116095938.GA12891@n2100.arm.linux.org.uk>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-3-git-send-email-catalin.marinas@arm.com>
	<20101115233129.GG31421@n2100.arm.linux.org.uk>
	<AANLkTikrz+yM6idm-aij10vsKZMVSOBfZSdeEJbDRwiC@mail.gmail.com>
	<20101116095938.GA12891@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikXtb2KsoW72DKkJ4ER5E=HNtfC9CGUhLWGfvwK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2010 09:59, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 16, 2010 at 09:14:52AM +0000, Catalin Marinas wrote:
>> On 15 November 2010 23:31, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > This should become:
>> >
>> > typedef struct { pteval_t pte; } pte_t;
>> >
>> > L_PTE_* can then be declared using linux/const.h stuff to typedef them
>> > to pteval_t.
>>
>> I already do this for LPAE but can be done for the 2-level definitions
>> for consistency.
>
> No you don't. ?You define the 2nd level definitions using pmd_t which
> is _wrong_. ?pmd_t is the type of the pmd container, not the pmd value.

I was only referring to L_PTE_*. The PMD_* definitions are wrong indeed.

-- 
Catalin
