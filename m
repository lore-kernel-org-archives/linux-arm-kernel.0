From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 3 Aug 2014 09:27:11 +0800
Subject: [PATCH v2] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <CAOMZO5DiYLwJkTrhCEn9rfrNsPmjBNDr8zeqs=DNKmpdKpCTqA@mail.gmail.com>
References: <1404341584-21668-1-git-send-email-festevam@gmail.com>
 <CAOMZO5DiYLwJkTrhCEn9rfrNsPmjBNDr8zeqs=DNKmpdKpCTqA@mail.gmail.com>
Message-ID: <20140803012710.GC2167@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 02, 2014 at 05:24:31PM -0300, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Wed, Jul 2, 2014 at 7:53 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk tree,
> > the glitchy parent mux of ldb_di[x]_clk can cause a glitch to enter the
> > ldb_di_ipu_div divider. If the divider gets locked up, no ldb_di[x]_clk is
> > generated, and the LVDS display will hang when the ipu_di_clk is sourced from
> > ldb_di_clk.
> >
> > To fix the problem, both the new and current parent of the ldb_di_clk should
> > be disabled before the switch. This patch ensures that correct steps are
> > followed when ldb_di_clk parent is switched in the beginning of boot.
> >
> > Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> > Changes since v1:
> >
> > - Remove cpu_is_imx6dl() from disable_anatop_clocks.
> > - Do not use bit 31 of CCM_ANALOG_PFD_528n
> 
> Any comment about this patch?

I believe that the agreement we reached during v1 review is we would
work around the issue in bootloader.

Shawn
