From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Dec 2011 21:03:24 +0000
Subject: [PATCH v4 2/4] ARM: pxa168: Add SDHCI support
In-Reply-To: <1324386781-25271-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <CAN1soZxZjdzivfttUhDDvjUDiyiAC5SSKtB0rXR1D=3=q6O0wQ@mail.gmail.com>
 <1324386781-25271-1-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <20111220210324.GD2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just two minor style issues in this patch.

On Tue, Dec 20, 2011 at 06:43:01PM +0530, Tanmay Upadhyay wrote:
> +static inline int pxa168_add_sdh(int id, struct sdhci_pxa_platdata *data)
> +{
> +	struct pxa_device_desc *d = NULL;
> +
> +	switch (id) {
> +	case 1: d = &pxa168_device_sdh1; break;
> +	case 2: d = &pxa168_device_sdh2; break;
> +	case 3: d = &pxa168_device_sdh3; break;
> +	case 4: d = &pxa168_device_sdh4; break;

Style.
	case X:
		d = &y;
		break;

> +static void sdh_clk_disable(struct clk *clk)
> +{
> +	__raw_writel(__raw_readl(clk->clk_rst) & ~(clk->enable_val),

Parens around clk->enable_val not required.

> +	INIT_CLKREG(&clk_sdh1, NULL, "PXA-SDHCLK"),
> +	INIT_CLKREG(&clk_sdh2, NULL, "PXA-SDHCLK"),
> +	INIT_CLKREG(&clk_sdh3, NULL, "PXA-SDHCLK"),
> +	INIT_CLKREG(&clk_sdh4, NULL, "PXA-SDHCLK"),

So these clocks are registered with the same name?  How are they
distinguished by clk_get()?
