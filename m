From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jan 2017 15:16:14 +0000
Subject: [PATCH] arm64: mm: fix show_pte KERN_CONT fallout
In-Reply-To: <1483453646-13617-1-git-send-email-mark.rutland@arm.com>
References: <1483453646-13617-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170104151614.GJ18193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 02:27:26PM +0000, Mark Rutland wrote:
> Recent changes made KERN_CONT mandatory for continued lines. In the
> absence of KERN_CONT, a newline may be implicit inserted by the core
> printk code.
> 
> In show_pte, we (erroneously) use printk without KERN_CONT for continued
> prints, resulting in output being split across a number of lines, and
> not matching the intended output, e.g.
> 
> [ff000000000000] *pgd=00000009f511b003
> , *pud=00000009f4a80003
> , *pmd=0000000000000000
> 
> Fix this by using pr_cont() for all the continuations.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/fault.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin can pick this one up for 4.10.

Will
