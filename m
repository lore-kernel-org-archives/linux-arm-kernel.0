From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 28 Feb 2010 16:12:16 +0000
Subject: [PATCH] CLKDEV: remove extra clk_find iterations
In-Reply-To: <4B88D956.1090003@st.com>
References: <4B88D956.1090003@st.com>
Message-ID: <20100228161216.GH30679@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 27, 2010 at 02:05:34PM +0530, Viresh KUMAR wrote:
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

hmm, looks like your mailer has reformatted this message

and two, please add a useful description, what is going on here?

> ---
>  arch/arm/common/clkdev.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> =======================================
> 
> diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
> index aae5bc0..736dfba 100644
> 
> --- a/arch/arm/common/clkdev.c
> 
> +++ b/arch/arm/common/clkdev.c
> 
> @@ -55,7 +55,10 @@
> 
> static?struct?clk?*clk_find(const?char?*dev_id,?const?char?*con_id)
> ? ? if?(match?==?0)
> ? ? ? continue;
> +? ? if?(match?==?3)
> +? ? ? return?p->clk;
> +
> ? ? if?(match?>?best)?{
> ? ? ? clk?=?p->clk;
> ? ? ? best?=?match;
> 
> -- 1.6.0.2
> 
> 
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
