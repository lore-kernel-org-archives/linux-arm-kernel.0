From: ezequiel.garcia@free-electrons.com ('Ezequiel Garcia')
Date: Thu, 10 Jul 2014 14:07:16 -0300
Subject: [PATCH v3 1/4] ethernet: Add new driver for Marvell Armada 375
 network unit
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D172700F9@AcuExch.aculab.com>
References: <1404758751-2346-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1404758751-2346-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140707221823.GC16677@electric-eye.fr.zoreil.com>
 <20140710151904.GA5283@arch.cereza>
 <063D6719AE5E284EB5DD2968C1650D6D172700F9@AcuExch.aculab.com>
Message-ID: <20140710170716.GA17727@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Jul 03:26 PM, David Laight wrote:
> From: Ezequiel Garcia
> ...
> > > > +/* Compare tcam data bytes with a pattern */
> > > > +static bool mvpp2_prs_tcam_data_cmp(struct mvpp2_prs_entry *pe,
> > > > +				    unsigned int offs, unsigned int size,
> > > > +					   unsigned char *bytes)
> > > > +{
> > > > +	unsigned char byte, mask;
> > > > +	int i;
> 
> Hmm. should be 'unsigned int' for the comparison against 'size'.
> 

Right. I've reworked this entirely, because it was barely readable,
and now the size parameter is gone.

> > > > +
> > > > +	for (i = 0; i < size; i++) {
> > > > +		mvpp2_prs_tcam_data_byte_get(pe, offs + i, &byte, &mask);
> > > > +
> > > > +		if (byte != bytes[i])
> > > > +			return false;
> > >
> > > Please reduce the scope of "byte" and "mask".
> > >
> > 
> > Agreed. This applies on several other places, I'll fix them all.
> > 
> > > > +	}
> > > > +	return true;
> 
> Not sure about other people, but I prefer variables to be defined
> at the top of a function so that I can find them.
> Minimising the scope tends to make code harder to read.
> 
> If this was a big function, then reducing the scope of 'temporary'
> variables need for a few lines (like the above loop) can make sense
> because it reduces the clutter at the top of the function.
> 

Yeah, that makes sense. I'm fine either way; I'll be submitting v4 now
addressing most of Francois' feedback. Feel free to complain if you think
some function is not readable enough and can be improved.

Thanks for taking a look,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
