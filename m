From: mturquette@linaro.org (Michael Turquette)
Date: Thu, 18 Jun 2015 11:36:54 -0700
Subject: [PATCH v2] clk: mvebu: flag the crypto clk as CLK_IGNORE_UNUSED
In-Reply-To: <55816094.2020208@free-electrons.com>
References: <1434470179-20835-1-git-send-email-boris.brezillon@free-electrons.com>
 <55816094.2020208@free-electrons.com>
Message-ID: <20150618183654.25948.26168@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2015-06-17 04:57:08)
> Hi Mike, Stephen,
> 
> On 16/06/2015 17:56, Boris Brezillon wrote:
> > The crypto SRAM, used by the armada 370 cpuidle code to workaround a bug
> > in the BootROM code, requires the crypto clk to be up and running.
> > Flag the crypto clk as IGNORE_UNUSED until we add the proper
> > infrastructure to define the crypto SRAM in the DT and reference the crypto
> > clk in this SRAM node.
> > 
> > Reported-by: Kevin Hilman <khilman@linaro.org>
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Tested-by: Kevin Hilman <khilman@linaro.org>
> > Fixes: 29e623475c50267ee3aaa49ebb6cbe107bce8d2a ("clk: mvebu: add
> > missing CESA gate clk").
> > Cc: <stable@vger.kernel.org> #4.1
> 
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Would it possible to apply this fix on 4.1-rc8 ?

Hi Gregory,

I'm a bit confused by this. This patch fixes "clk: mvebu: add missing
CESA gate clk", right? That patch lives in clk-next. It was not pushed
to Linus' tree yet via a -fixes branch.

Thus I can just apply this patch to clk-next and the problem should be
resolved in clk-next, no?

Furthermore, I do not have 29e623475c50267ee3aaa49ebb6cbe107bce8d2a
anywhere in my tree. I'm not sure where this sha1 hash came from.

Regards,
Mike

> 
> Thanks,
> 
> Gregory
> 
> > ---
> > Changes since v1:
> > - add the Reported-by tag
> > - add the missing trailing ','
> > 
> >  drivers/clk/mvebu/armada-370.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
> > index c19fd77..2c7c108 100644
> > --- a/drivers/clk/mvebu/armada-370.c
> > +++ b/drivers/clk/mvebu/armada-370.c
> > @@ -163,7 +163,7 @@ static const struct clk_gating_soc_desc a370_gating_desc[] __initconst = {
> >       { "pex1", "pex1_en", 9, 0 },
> >       { "sata0", NULL, 15, 0 },
> >       { "sdio", NULL, 17, 0 },
> > -     { "crypto", NULL, 23, 0 },
> > +     { "crypto", NULL, 23, CLK_IGNORE_UNUSED },
> >       { "tdm", NULL, 25, 0 },
> >       { "ddr", NULL, 28, CLK_IGNORE_UNUSED },
> >       { "sata1", NULL, 30, 0 },
> > 
> 
> 
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
