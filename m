From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Dec 2013 12:54:43 +0000
Subject: [PATCH v2 4/7] mfd: ssbi: Add regmap read/write helpers
In-Reply-To: <1387831563-13535-5-git-send-email-sboyd@codeaurora.org>
References: <1387831563-13535-1-git-send-email-sboyd@codeaurora.org>
 <1387831563-13535-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131224125443.GC30815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 12:46:00PM -0800, Stephen Boyd wrote:

> +int ssbi_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	*val = 0;
> +	return ssbi_read(context, reg, (u8 *)val, 1);
> +}
> +EXPORT_SYMBOL_GPL(ssbi_reg_read);
> +
> +int ssbi_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	return ssbi_write(context, reg, (u8 *)&val, 1);
> +}
> +EXPORT_SYMBOL_GPL(ssbi_reg_write);

Not a big deal but could these just be inlined in the headers?
