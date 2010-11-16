From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Nov 2010 09:59:38 +0000
Subject: [PATCH v2 02/20] ARM: LPAE: Factor out 2-level page table
	definitions into separate files
In-Reply-To: <AANLkTikrz+yM6idm-aij10vsKZMVSOBfZSdeEJbDRwiC@mail.gmail.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-3-git-send-email-catalin.marinas@arm.com>
	<20101115233129.GG31421@n2100.arm.linux.org.uk>
	<AANLkTikrz+yM6idm-aij10vsKZMVSOBfZSdeEJbDRwiC@mail.gmail.com>
Message-ID: <20101116095938.GA12891@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 09:14:52AM +0000, Catalin Marinas wrote:
> On 15 November 2010 23:31, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > This should become:
> >
> > typedef struct { pteval_t pte; } pte_t;
> >
> > L_PTE_* can then be declared using linux/const.h stuff to typedef them
> > to pteval_t.
> 
> I already do this for LPAE but can be done for the 2-level definitions
> for consistency.

No you don't.  You define the 2nd level definitions using pmd_t which
is _wrong_.  pmd_t is the type of the pmd container, not the pmd value.

> BTW, do you think it's worth adding STRICT_MM_TYPECHECKS for LPAE as
> well? It would probably spot some issues.

Definitely, because it'll throw out warnings for most of your _AT(pmd_t,)
definitions.
