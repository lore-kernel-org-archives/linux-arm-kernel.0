From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Dec 2014 16:53:31 +0000
Subject: [PATCH v5 6/6] ASoC: dwc: Add devicetree support for Designware
 I2S
In-Reply-To: <8da45b000fb1f9a029b30fcf5abe50941f45e32e.1419936132.git.Andrew.Jackson@arm.com>
References: <cover.1419936132.git.Andrew.Jackson@arm.com>
 <8da45b000fb1f9a029b30fcf5abe50941f45e32e.1419936132.git.Andrew.Jackson@arm.com>
Message-ID: <20141230165331.GM17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 10:55:48AM +0000, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
> 
> Allow the driver to be configured through a device tree rather than platform
> data.

Applied but...

> +#ifdef CONFIG_OF
> +		.of_match_table = of_match_ptr(dw_i2s_of_match),
> +#endif

...the whole point of of_match_ptr() is that it avoids the need for the
ifdef, please send a followup removing them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141230/a8ba5042/attachment-0001.sig>
