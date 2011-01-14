From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 14 Jan 2011 10:48:32 +0100
Subject: [PATCH v5 08/10] ARM: mxs: add ocotp read function
In-Reply-To: <20110114084009.GL26617@pengutronix.de>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
	<1294989894-20780-1-git-send-email-shawn.guo@freescale.com>
	<20110114084009.GL26617@pengutronix.de>
Message-ID: <20110114094832.GG24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

On Fri, Jan 14, 2011 at 09:40:09AM +0100, Sascha Hauer wrote:
> On Fri, Jan 14, 2011 at 03:24:54PM +0800, Shawn Guo wrote:
> > +const u32 *mxs_get_ocotp(void)
> > +{
> > + [...]
> > +}
> 
> EXPORT_SYMBOL?
I don't think this should be necessary.  mxs_get_ocotp should only be
called from platform code that cannot (ot at least should not) be
modular.  I suggest to skip it for now and if we really need it later
only add it then.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
