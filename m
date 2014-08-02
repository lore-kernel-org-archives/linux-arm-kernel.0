From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 2 Aug 2014 17:24:31 -0300
Subject: [PATCH v2] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <1404341584-21668-1-git-send-email-festevam@gmail.com>
References: <1404341584-21668-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5DiYLwJkTrhCEn9rfrNsPmjBNDr8zeqs=DNKmpdKpCTqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Jul 2, 2014 at 7:53 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk tree,
> the glitchy parent mux of ldb_di[x]_clk can cause a glitch to enter the
> ldb_di_ipu_div divider. If the divider gets locked up, no ldb_di[x]_clk is
> generated, and the LVDS display will hang when the ipu_di_clk is sourced from
> ldb_di_clk.
>
> To fix the problem, both the new and current parent of the ldb_di_clk should
> be disabled before the switch. This patch ensures that correct steps are
> followed when ldb_di_clk parent is switched in the beginning of boot.
>
> Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
>
> - Remove cpu_is_imx6dl() from disable_anatop_clocks.
> - Do not use bit 31 of CCM_ANALOG_PFD_528n

Any comment about this patch?
