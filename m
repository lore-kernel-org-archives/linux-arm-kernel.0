From: joro@8bytes.org (joro at 8bytes.org)
Date: Sat, 28 Apr 2018 11:02:17 +0200
Subject: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
In-Reply-To: <1524839460.2693.531.camel@hpe.com>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org>
 <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org>
 <1524764948.2693.478.camel@hpe.com>
 <20180426200737.GS15462@8bytes.org>
 <1524781764.2693.503.camel@hpe.com>
 <20180427073719.GT15462@8bytes.org>
 <1524839460.2693.531.camel@hpe.com>
Message-ID: <20180428090217.n2l3w4vobmtkvz6k@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 02:31:51PM +0000, Kani, Toshi wrote:
> So, we can add the step 2 on top of this patch.
>  1. Clear pud/pmd entry.
>  2. System wide TLB flush <-- TO BE ADDED BY NEW PATCH
>  3. Free its underlining pmd/pte page.

This still lacks the page-table synchronization and will thus not fix
the BUG_ON being triggered.

> We do not need to revert this patch.  We can make the above change I
> mentioned.

Please note that we are not in the merge window anymore and that any fix
needs to be simple and obviously correct.


Thanks,

	Joerg
