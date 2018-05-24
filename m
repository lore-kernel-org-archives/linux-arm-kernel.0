From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 May 2018 11:27:38 +0100
Subject: [PATCHv2] arm64: Make sure permission updates happen for pmd/pud
In-Reply-To: <20180523184346.487-1-labbott@redhat.com>
References: <20180523184346.487-1-labbott@redhat.com>
Message-ID: <20180524102735.GA28425@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Wed, May 23, 2018 at 11:43:46AM -0700, Laura Abbott wrote:
> Commit 15122ee2c515 ("arm64: Enforce BBM for huge IO/VMAP mappings")
> disallowed block mappings for ioremap since that code does not honor
> break-before-make. The same APIs are also used for permission updating
> though and the extra checks prevent the permission updates from happening,
> even though this should be permitted. This results in read-only permissions
> not being fully applied. Visibly, this can occasionaly be seen as a failure
> on the built in rodata test when the test data ends up in a section or
> as an odd RW gap on the page table dump. Fix this by using
> pgattr_change_is_safe instead of p*d_present for determining if the
> change is permitted.
> 
> Reported-by: Peter Robinson <pbrobinson@gmail.com>
> Fixes: 15122ee2c515 ("arm64: Enforce BBM for huge IO/VMAP mappings")
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Switch to using pgattr_change_is_safe per suggestion of Will
> ---

Thanks for re-spinning so quickly. I'll queue as a fix with the relevant
tags.

Will
