From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 May 2015 21:59:14 +0800
Subject: [PATCH v2] ARM: imx: imx7d requires anatop
In-Reply-To: <2517471.Cl2S35hGoT@wuerfel>
References: <2067135.qgAceiU7yZ@wuerfel>
 <2517471.Cl2S35hGoT@wuerfel>
Message-ID: <20150529135913.GN16165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 11:28:05AM +0200, Arnd Bergmann wrote:
> Like i.MX6, the i.MX7 code calls into the anatop driver, which fails
> if that is disabled:
> 
> arch/arm/mach-imx/built-in.o: In function `imx7d_init_machine':
> arch/arm/mach-imx/mach-imx7d.c:24: undefined reference to `imx_anatop_init'
> arch/arm/mach-imx/built-in.o: In function `imx7d_init_irq':
> arch/arm/mach-imx/mach-imx7d.c:29: undefined reference to `imx_init_revision_from_anatop'
> 
> This patch ensures that for an imx7-only build, we still get anatop
> built-in, matching what we do for imx6. We also need to select 
> HAVE_IMX_MMDC, as that is needed by the anatop code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I ran into a related problem, please use this version instead
> of the first one, to cover all cases.

Applied, thanks.
