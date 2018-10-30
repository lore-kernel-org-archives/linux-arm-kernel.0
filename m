From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 30 Oct 2018 16:25:28 -0300
Subject: [PATCH] ARM: dts: fsl: Fix improperly quoted stdout-path values
In-Reply-To: <20181030190802.20722-1-robh@kernel.org>
References: <20181030190802.20722-1-robh@kernel.org>
Message-ID: <CAOMZO5BHnzYWPQ4NJmcFUe8NjPYyCR9HEUj2-wJ22zx9g7j=gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 4:08 PM Rob Herring <robh@kernel.org> wrote:
>
> A quoted label reference doesn't expand to the node path and is taken as
> a literal string. Dropping the quotes can fix this unless the baudrate
> string is appended in which case we have to use the alias.
>
> At least on VF610, the problem was masked by setting the console in
> bootargs. Use the alias syntax with baudrate parameter so we can drop
> setting the console in bootargs.
>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
