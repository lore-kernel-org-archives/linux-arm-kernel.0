From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 15 Nov 2010 15:30:59 +0000
Subject: [Patch v3] Fix audmuxv2 debugfs indexing. [was: Patch IMX
	audmux debugfs.]
In-Reply-To: <BLU0-SMTP271B3B53A7BF23C621F315B8360@phx.gbl>
References: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
	<20101110152619.GB8950@pengutronix.de>
	<BLU0-SMTP84DA72E534B9B3F1DCEA5BB8320@phx.gbl>
	<20101112071706.GF6017@pengutronix.de>
	<20101112114942.GA28804@sirena.org.uk>
	<87oc9rk6fe.fsf@sympatico.ca>
	<BLU0-SMTP271B3B53A7BF23C621F315B8360@phx.gbl>
Message-ID: <20101115153058.GG12986@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 10:09:12AM -0500, Bill Pringlemeir wrote:

> -       for (i = 1; i < 8; i++) {
> +       for (i = 0; i < 6; i++) {
>                 snprintf(buf, sizeof(buf), "ssi%d", i);
>                 if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
>                                          (void *)i, &audmux_debugfs_fops))

We appear to have misplaced a SSI port here...
