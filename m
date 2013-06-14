From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 14 Jun 2013 17:24:30 +0200
Subject: [PATCH 1/2] i2c-mv64xxx: Fix timing issue on Armada XP (errata
 FE-8471889)
In-Reply-To: <20130607182500.10593e73@skate>
References: <1370620140-17177-1-git-send-email-gregory.clement@free-electrons.com>
 <1370620140-17177-2-git-send-email-gregory.clement@free-electrons.com>
 <20130607182500.10593e73@skate>
Message-ID: <20130614152430.GF2929@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 06:25:00PM +0200, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Fri,  7 Jun 2013 17:48:59 +0200, Gregory CLEMENT wrote:
> 
> > +/*
> > + * 5us delay in order to avoid repeated start
> > + * timing violation on Armada XP SoC.
> > + */
> > +static int mv64xxx_i2c_errata_delay;
> 
> This should probably be a per-I2C controller variable, i.e in
> mv64xxx_i2c_data.

Yes.

> 
> 
> > +	if (!mv64xxx_i2c_errata_delay &&
> > +	    of_machine_is_compatible("marvell,armadaxp"))
> > +		mv64xxx_i2c_errata_delay = 1;
> 
> I am wondering whether it should be done this way, or using a separate
> DT property.

Need to think about it. It is similar to the sda-hold-time issue, I
guess.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130614/e78ff3be/attachment.sig>
