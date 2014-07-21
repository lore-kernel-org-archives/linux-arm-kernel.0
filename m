From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 21 Jul 2014 08:41:45 +0200
Subject: [PATCH] ARM: i.MX6: add more chip revision support
In-Reply-To: <20140721063520.GR23235@pengutronix.de>
References: <1405921091-28748-1-git-send-email-shawn.guo@freescale.com>
 <20140721063520.GR23235@pengutronix.de>
Message-ID: <20140721064145.GA7350@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 08:35:20AM +0200, Sascha Hauer wrote:
> On Mon, Jul 21, 2014 at 01:38:11PM +0800, Shawn Guo wrote:
> > From: Jason Liu <r64343@freescale.com>
> > 
> > Add more revision support for the new i.MX6DQ tap-out (TO1.5).  This
Is it "tap-out" or "tape-out"? A quick google request suggests the
latter.

> > TO1.5 is the Rev 1.3 as documented in i.MX6DQ data sheet, because TO1.3
> > and TO1.4 are never revealed.
> 
> So the chip identifies itself as 1.5 but the data sheet refers to it as
> 1.3. Is there a way to make that clear somewhere? Otherwise it's really
> confusing.
Yeah, from the commit log I would have expected the following patch:

+	case 5:
+		revision = IMX_CHIP_REVISION_1_3;
+		break;

maybe with a code comment. Also, the commit log only mentions i.MX6DQ; I
wonder about the other imx6 variants. I hope they use the same logic?

Best regards
Uwe
> > diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
> > index 4a40bbb46183..459ba290744b 100644
> > --- a/arch/arm/mach-imx/anatop.c
> > +++ b/arch/arm/mach-imx/anatop.c
> > @@ -104,6 +104,15 @@ void __init imx_init_revision_from_anatop(void)
> >  	case 2:
> >  		revision = IMX_CHIP_REVISION_1_2;
> >  		break;
> > +	case 3:
> > +		revision = IMX_CHIP_REVISION_1_3;
> > +		break;
> > +	case 4:
> > +		revision = IMX_CHIP_REVISION_1_4;
> > +		break;
> > +	case 5:
> > +		revision = IMX_CHIP_REVISION_1_5;
> > +		break;
> >  	default:
> >  		revision = IMX_CHIP_REVISION_UNKNOWN;
> >  	}

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
