From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 18:03:40 +0200
Subject: [Patch V2 2/2] i2c: mv64xxx: Remove internal compatible string
 from Documentation
In-Reply-To: <20140728155256.GH2891@lunn.ch>
References: <1406395238-29758-1-git-send-email-andrew@lunn.ch>
 <30588206.eyRbtryspM@wuerfel> <20140728155256.GH2891@lunn.ch>
Message-ID: <5484382.ltXF4cCzA4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 17:52:56 Andrew Lunn wrote:
> > > We don't translate into 'Marketing names'. We just turn the register
> > > values into a stringified number. So it would have to be something
> > > like:
> > > 
> > >         if (soc_name_is("7826") && soc_revision_is("1"))
> > 
> > Hmm, I think that is inconsistent with how the strings are used
> > on other platforms, where you want something that uniquely identifies
> > the device in user-readable strings.
> 
> Unfortunately, it is not so simple. There are a few different Armada
> XP SoCs. E.g. dual core and quad core. And this is pretty normal for
> Marvell. There are maybe 5 different Kirkwoods, a few different
> Orion5x etc. So at minimum it would of had to be e.g. "Armada XP
> 7826".
> 
> However, it is too late now. This is part of the ABI, and Debian's
> flash-kernel is making use of this in order to get the right DT blob.
> So we cannot change it.
> 

Ok, I see. Let's hope then that "Marvell" as a family name in combination
with those numbers remains unique. A driver will probably have to
check all three, but it could be combined into a single function that
takes NULL as a don't care argument:

	if (soc_is("Marvell", "7826", NULL))
		...

	Arnd
