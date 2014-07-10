From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 10 Jul 2014 15:26:55 +0000
Subject: [PATCH v3 1/4] ethernet: Add new driver for Marvell Armada 375
 network unit
In-Reply-To: <20140710151904.GA5283@arch.cereza>
References: <1404758751-2346-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1404758751-2346-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140707221823.GC16677@electric-eye.fr.zoreil.com>
 <20140710151904.GA5283@arch.cereza>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D172700F9@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia
...
> > > +/* Compare tcam data bytes with a pattern */
> > > +static bool mvpp2_prs_tcam_data_cmp(struct mvpp2_prs_entry *pe,
> > > +				    unsigned int offs, unsigned int size,
> > > +					   unsigned char *bytes)
> > > +{
> > > +	unsigned char byte, mask;
> > > +	int i;

Hmm. should be 'unsigned int' for the comparison against 'size'.

> > > +
> > > +	for (i = 0; i < size; i++) {
> > > +		mvpp2_prs_tcam_data_byte_get(pe, offs + i, &byte, &mask);
> > > +
> > > +		if (byte != bytes[i])
> > > +			return false;
> >
> > Please reduce the scope of "byte" and "mask".
> >
> 
> Agreed. This applies on several other places, I'll fix them all.
> 
> > > +	}
> > > +	return true;

Not sure about other people, but I prefer variables to be defined
at the top of a function so that I can find them.
Minimising the scope tends to make code harder to read.

If this was a big function, then reducing the scope of 'temporary'
variables need for a few lines (like the above loop) can make sense
because it reduces the clutter at the top of the function.

	David
