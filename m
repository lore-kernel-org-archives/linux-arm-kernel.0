From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Feb 2015 10:48:40 +0100
Subject: [PATCH 6/6] [RFC] mtd: mxc-nand: Warn on unimplemented commands
In-Reply-To: <20150211104016.0d7eec4d@ipc1.ka-ro>
References: <1423594800-24214-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1423594800-24214-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150211094256.2ef2805b@ipc1.ka-ro>
 <20150211090017.GW10842@pengutronix.de>
 <20150211104016.0d7eec4d@ipc1.ka-ro>
Message-ID: <20150211094840.GN12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 10:40:16AM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Uwe Kleine-K?nig wrote:
> > Hello Lothar,
> > 
> > On Wed, Feb 11, 2015 at 09:42:56AM +0100, Lothar Wa?mann wrote:
> > > > diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> > > > index 0083b4ee4f33..372e0e38f59b 100644
> > > > --- a/drivers/mtd/nand/mxc_nand.c
> > > > +++ b/drivers/mtd/nand/mxc_nand.c
> > > > @@ -1160,6 +1160,10 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
> > > >  		memcpy32_fromio(host->data_buf, host->main_area0, 512);
> > > >  		host->buf_start = 0;
> > > >  		break;
> > > > +	default:
> > > > +		WARN_ONCE(1, "Unimplemented command (cmd=%u)\n",
> > > > +			  command);
> > > > +		break;
> > > >  	}
> > > useless break;
> > Do you mean the line break? That's right, I fixed it here for a later
> > v2. But I guess you mean the (literal) break here. Right, it could be
> > dropped without change in semantic, but I thought adding it matches the
> > usually recommended style?!
> > 
> Documentation/CodingStyle has this example:
> |        default:
> |                break;
> |        }
> but there is no useful statement in the 'default' case, so the
> 'break' is necessary here.
> IMO this doesn't mandate to add a 'break' at the end of the default
> clause if there are actual statements in this path.

The 'default:' is not necessarily at the end. Dropping the 'break' in
the last case makes it easy to forget to add the break when additional
cases are added below the last one.

IMO the 'break' should stay there.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
