From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 9 Sep 2016 14:26:35 +0200
Subject: [PATCH 1/9] mtd: nand: Create a NAND reset function
In-Reply-To: <CAOMZO5DfSU5rhf45Vcs7Sit=v2FdQtm=nhdfstZdYwizP6C-=w@mail.gmail.com>
References: <1473422712-12359-1-git-send-email-s.hauer@pengutronix.de>
 <1473422712-12359-2-git-send-email-s.hauer@pengutronix.de>
 <CAOMZO5DfSU5rhf45Vcs7Sit=v2FdQtm=nhdfstZdYwizP6C-=w@mail.gmail.com>
Message-ID: <20160909142635.23a8c865@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Sep 2016 09:15:52 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Sascha,
> 
> On Fri, Sep 9, 2016 at 9:05 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> >  /**
> > + * nand_reset - Reset and initialize a NAND device
> > + * @chip: The NAND chip
> > + *
> > + * Returns 0 for success or negative error code otherwise
> > + */
> > +int nand_reset(struct nand_chip *chip)
> > +{
> > +       chip->cmdfunc(&chip->mtd, NAND_CMD_RESET, -1, -1);
> > +
> > +       return 0;  
> 
> It always return 0 here, so the comment and code do not match.

Not sure this is a big problem, because the function is updated in
patch 6 and after that it can return an error.
