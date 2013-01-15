From: joe@perches.com (Joe Perches)
Date: Tue, 15 Jan 2013 10:31:05 -0800
Subject: [PATCH 1/1] clk-divider: fix is_power_of_two()
In-Reply-To: <1358245685-4392-1-git-send-email-james.hogan@imgtec.com>
References: <1358245685-4392-1-git-send-email-james.hogan@imgtec.com>
Message-ID: <1358274665.2597.11.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-15 at 10:28 +0000, James Hogan wrote:
> The macro is_power_of_two() in clk-divider.c was defined as !(i & ~i)
> which is always true. Correct it to !(i & (i - 1)).
[]
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
[]
> @@ -29,8 +29,8 @@
[]
> -#define div_mask(d)	((1 << (d->width)) - 1)
> -#define is_power_of_two(i)	!(i & ~i)
> +#define div_mask(d)	((1 << ((d)->width)) - 1)
> +#define is_power_of_two(i)	(!((i) & ((i) - 1)))

Use is_power_of_2 in log2.h instead?
