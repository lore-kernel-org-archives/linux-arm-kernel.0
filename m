From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 4 Nov 2013 08:58:21 -0300
Subject: [PATCH v2 08/27] mtd: nand: pxa3xx: Use chip->cmdfunc instead of
 the internal
In-Reply-To: <20131103213237.GB5896@gmail.com>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382137374-21251-9-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131103213237.GB5896@gmail.com>
Message-ID: <20131104115820.GB2516@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 03, 2013 at 04:32:40PM -0500, Huang Shijie wrote:
> On Fri, Oct 18, 2013 at 08:02:35PM -0300, Ezequiel Garcia wrote:
> > @@ -1011,14 +1011,16 @@ static void pxa3xx_nand_free_buff(struct pxa3xx_nand_info *info)
> >  static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
> >  {
> >  	struct mtd_info *mtd;
> > +	struct nand_chip *chip;
> >  	int ret;
> Please add a empty line here.
> 

Sure, I will.

> >  	mtd = info->host[info->cs]->mtd;
> > +	chip = mtd->priv;
> >  	/* use the common timing to make a try */
> >  	ret = pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
> >  	if (ret)
> >  		return ret;
> >  
> > -	pxa3xx_nand_cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
> > +	chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
> >  	if (info->is_ready)
> >  		return 0;
> Reviewed-by: Huang Shijie <shijie8@gmail.com>

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
