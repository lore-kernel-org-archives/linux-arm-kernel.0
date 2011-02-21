From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:19:53 -0800
Subject: [PATCH v2 15/21] ARM: tegra: clock: Round rate before setting rate
In-Reply-To: <1298154371-5641-17-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-17-git-send-email-ccross@android.com>
Message-ID: <AANLkTi=jJRhyMZXbs3Unr-U+J59rt4SxMQtT4KtCqWbe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 19, 2011 at 2:26 PM, Colin Cross <ccross@android.com> wrote:

> diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
> index 8d01a49..9798585 100644
> --- a/arch/arm/mach-tegra/clock.c
> +++ b/arch/arm/mach-tegra/clock.c
> @@ -86,6 +86,7 @@ static unsigned long clk_predict_rate_from_parent(struct clk *c, struct clk *p)
>
> ? ? ? ?if (c->mul != 0 && c->div != 0) {
> ? ? ? ? ? ? ? ?rate *= c->mul;
> + ? ? ? ? ? ? ? rate += c->div / 2; /* round up */

Shouldn't this be "rate += c->div - 1;"?



-Olof
