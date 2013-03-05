From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 5 Mar 2013 14:18:49 +0800
Subject: [PATCH] ARM:SPEAr3xx: fix compilation breakage due to missing
 header file
In-Reply-To: <7dd824ea0e7427a203c459fc4084d304ace44c9e.1362461902.git.vipulkumar.samar@st.com>
References: <7dd824ea0e7427a203c459fc4084d304ace44c9e.1362461902.git.vipulkumar.samar@st.com>
Message-ID: <CAOh2x=myeXiJ7t4Akz3MA56iJWpoc9N+Lh4+ndUmudxT9faaeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 5, 2013 at 2:04 PM, Vipul Kumar Samar
<vipulkumar.samar@st.com> wrote:
> commit 3a95b9fb (pl080.h: moved from arm/include/asm/hardware to
> include/linux/amba/) broke the compilation for SPEAr3xx machine.
>
> This patch is to include missing header file in spear3xx.c.
>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> ---
>  arch/arm/mach-spear3xx/spear3xx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
> index f9d754f..7c218d9 100644
> --- a/arch/arm/mach-spear3xx/spear3xx.c
> +++ b/arch/arm/mach-spear3xx/spear3xx.c
> @@ -14,6 +14,7 @@
>  #define pr_fmt(fmt) "SPEAr3xx: " fmt
>
>  #include <linux/amba/pl022.h>
> +#include <linux/amba/pl080.h>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
