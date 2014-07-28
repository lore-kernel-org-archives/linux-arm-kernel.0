From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 28 Jul 2014 17:25:06 +0200
Subject: [Patch V2 2/2] i2c: mv64xxx: Remove internal compatible string
 from Documentation
In-Reply-To: <6346429.sjQYojn1ot@wuerfel>
References: <1406395238-29758-1-git-send-email-andrew@lunn.ch>
 <5514427.elClhaDPhf@wuerfel> <20140728141217.GE2891@lunn.ch>
 <6346429.sjQYojn1ot@wuerfel>
Message-ID: <20140728152506.GF2891@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Add a call something like:
> > 
> > /*
> >  * Return the soc device attributes for a given soc_dev. If soc_dev is NULL,
> >  * the first device on the soc bus is returned.
> >  */
> > struct soc_device_attribute *soc_attribute_get(struct soc_device * soc_dev);
> 
> Interesting idea, yes.

O.K, i will take a shot of implementing this sometime in the next few
weeks. Bit busy at the moment.
 
> There could also be a higher-level function that does a strcmp() in addition,
> so that a driver can do some variation of
> 
> 	if (soc_name_is("Armada XP") && soc_revision_is("A0"))

We don't translate into 'Marketing names'. We just turn the register
values into a stringified number. So it would have to be something
like:

	if (soc_name_is("7826") && soc_revision_is("1"))

	Andrew
