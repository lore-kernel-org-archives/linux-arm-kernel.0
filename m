From: charu@ti.com (Varadarajan, Charulatha)
Date: Wed, 8 Dec 2010 18:03:02 +0530
Subject: [PATCH RESEND] ARM: io: fix namespace conflicts
In-Reply-To: <1291358089-10490-1-git-send-email-sourav.poddar@ti.com>
References: <1291358089-10490-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <AANLkTi=Zbqb2nGCJmh-8r83S9j4DgxjKfZW6eEL-Un9c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Fri, Dec 3, 2010 at 12:04, Sourav Poddar <sourav.poddar@ti.com> wrote:
> Having __v as the variable name for the definition of different macros leads
> to the namespace pollution. For example,
> readl(p)
> unrolls to:
> ({ u32 __v = ({ u32 __v = (( __u32)(__le32)(( __le32) ((void)0,
> *(volatile unsigned int *)((p))))); __v; }); __asm__ __volatile__ ("mcr
> p15,
> , %0, c7, c10, 5" : : "r" (0) : "memory"); __v; });
>
> ({ u32 __v = ({ u32 __v
> causes sparse warning: "warning: symbol '__v' shadows an earlier one"
>
> Using variable names which use the function name prefix across the
> various macros avoids the namespace pollution.
>
> With this change, ~200 sparse warnings in omap2plus_defconfig build are
> fixed.
>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed by: Nishanth Menon <nm@ti.com>
> ---
> Links related to previous discussions are as follows:
> https://patchwork.kernel.org/patch/250171/
> http://www.spinics.net/lists/linux-omap/msg38569.html
> http://marc.info/?t=128506336700011&r=1&w=2
>
> arch/arm/include/asm/io.h | ? 32 +++++++++++++++++++++-----------
> ?1 files changed, 21 insertions(+), 11 deletions(-)
>

If no comments, pls ack this patch.

Thanks,
V Charulatha
