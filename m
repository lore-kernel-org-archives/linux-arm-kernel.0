From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 17:47:50 +0200
Subject: [Patch V2 2/2] i2c: mv64xxx: Remove internal compatible string
 from Documentation
In-Reply-To: <20140728152506.GF2891@lunn.ch>
References: <1406395238-29758-1-git-send-email-andrew@lunn.ch>
 <6346429.sjQYojn1ot@wuerfel> <20140728152506.GF2891@lunn.ch>
Message-ID: <30588206.eyRbtryspM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 17:25:06 Andrew Lunn wrote:
> > > Add a call something like:
> > > 
> > > /*
> > >  * Return the soc device attributes for a given soc_dev. If soc_dev is NULL,
> > >  * the first device on the soc bus is returned.
> > >  */
> > > struct soc_device_attribute *soc_attribute_get(struct soc_device * soc_dev);
> > 
> > Interesting idea, yes.
> 
> O.K, i will take a shot of implementing this sometime in the next few
> weeks. Bit busy at the moment.
>  
> > There could also be a higher-level function that does a strcmp() in addition,
> > so that a driver can do some variation of
> > 
> >       if (soc_name_is("Armada XP") && soc_revision_is("A0"))
> 
> We don't translate into 'Marketing names'. We just turn the register
> values into a stringified number. So it would have to be something
> like:
> 
>         if (soc_name_is("7826") && soc_revision_is("1"))

Hmm, I think that is inconsistent with how the strings are used
on other platforms, where you want something that uniquely identifies
the device in user-readable strings.

I haven't checked how all the others are doing it though.

	Arnd
