From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 9 Sep 2016 21:24:28 +0200
Subject: [PATCH 1/9] mtd: nand: Create a NAND reset function
In-Reply-To: <20160909142635.23a8c865@bbrezillon>
References: <1473422712-12359-1-git-send-email-s.hauer@pengutronix.de>
 <1473422712-12359-2-git-send-email-s.hauer@pengutronix.de>
 <CAOMZO5DfSU5rhf45Vcs7Sit=v2FdQtm=nhdfstZdYwizP6C-=w@mail.gmail.com>
 <20160909142635.23a8c865@bbrezillon>
Message-ID: <20160909192428.bxexkdokigezeqc7@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Sep 09, 2016 at 02:26:35PM +0200, Boris Brezillon wrote:
> On Fri, 9 Sep 2016 09:15:52 -0300
> Fabio Estevam <festevam@gmail.com> wrote:
> > On Fri, Sep 9, 2016 at 9:05 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > 
> > >  /**
> > > + * nand_reset - Reset and initialize a NAND device
> > > + * @chip: The NAND chip
> > > + *
> > > + * Returns 0 for success or negative error code otherwise
> > > + */
> > > +int nand_reset(struct nand_chip *chip)
> > > +{
> > > +       chip->cmdfunc(&chip->mtd, NAND_CMD_RESET, -1, -1);
> > > +
> > > +       return 0;  
> > 
> > It always return 0 here, so the comment and code do not match.
> 
> Not sure this is a big problem, because the function is updated in
> patch 6 and after that it can return an error.

Also from a purely logically POV "Returns 0 for success or negative
error code otherwise" doesn't contradict the implementation. The
function just always succeeds and so the statement is true because the
left argument of the or expression is true :-)

SCNR
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
