From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 20 Jan 2017 18:21:02 +0100
Subject: [PATCH v5 2/2] net: dsa: mv88e6xxx: Add support for ethernet
 switch 88E6341
In-Reply-To: <20170120001203.GB31483@lunn.ch> (Andrew Lunn's message of "Fri,
 20 Jan 2017 01:12:03 +0100")
References: <20170119214934.27442-1-gregory.clement@free-electrons.com>
 <20170119214934.27442-3-gregory.clement@free-electrons.com>
 <87y3y6k7pg.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
 <20170120001203.GB31483@lunn.ch>
Message-ID: <8760l9641t.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vvien and Andrew,
 
 On ven., janv. 20 2017, Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Jan 19, 2017 at 05:26:03PM -0500, Vivien Didelot wrote:
>> Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
>> 
>> > +static bool mv88e6xxx_6341_family(struct mv88e6xxx_chip *chip)
>> > +{
>> > +	return chip->info->family == MV88E6XXX_FAMILY_6341;
>> > +}
>> 
>> I don't want to see these erronous family checks anymore, but I cannot
>> blame you for adding it since not all the code is moved to ops yet ;)

If there a series about to be merged I can rebase my series on it. Else
I propose to keep it and convert the family check to ops when you will
send the series for it.

>> 
>> >  	MV88E6XXX_FAMILY_6165,	/* 6123 6161 6165 */
>> >  	MV88E6XXX_FAMILY_6185,	/* 6108 6121 6122 6131 6152 6155 6182 6185 */
>> >  	MV88E6XXX_FAMILY_6320,	/* 6320 6321 */
>> > +	MV88E6XXX_FAMILY_6341,	/* 6141 6341 */
>> 
>> Maybe I missed it, Andrew, can you confirm that 6341 is a proper Marvell
>> family of switch chips?
>
> My understand is that it is. Marvell have not added it to DSDT. There
> is a new SDK called UMSD, also GPLv2 and BSD. They call this family
> Topaz, and the 6390 is Peridot.

I confirm that 6141 and 6341 are called Topaz. Actually I can add the
support for the 6141 too, it is just a matter of adding an ID and maybe
removing some ops as 6141 is a subset of 6341.

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
