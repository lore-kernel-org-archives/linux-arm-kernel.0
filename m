From: ccross@google.com (Colin Cross)
Date: Mon, 7 Feb 2011 11:59:26 -0800
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <1297058877.800158.458894385837.1.gpush@pororo>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800158.458894385837.1.gpush@pororo>
Message-ID: <AANLkTi=5FNvWKQf6cRt4wNejC7u4XKsqLp9Pwc2Z45_3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 6, 2011 at 10:07 PM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
<snip>

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> new file mode 100644
> index 0000000..12e0daf
> --- /dev/null
> +++ b/drivers/clk/clk.c

<snip>

> +int clk_enable(struct clk *clk)
> +{
> + ? ? ? int ret = 0;
> +
> + ? ? ? if (!clk->ops->enable)
> + ? ? ? ? ? ? ? return 0;
> +
> + ? ? ? spin_lock(&clk->enable_lock);

spin_lock_irqsave/spin_unlock_irqrestore.  This could get called with
irqs on or off.
