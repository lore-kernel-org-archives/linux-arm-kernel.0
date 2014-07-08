From: bp@alien8.de (Borislav Petkov)
Date: Tue, 8 Jul 2014 13:42:28 +0200
Subject: [PATCHv7 3/3] edac: altera: Add EDAC support for Altera SoC
 SDRAM Controller.
In-Reply-To: <20140708113109.GC8100@amd.pavel.ucw.cz>
References: <1403730927-16163-1-git-send-email-tthayer@altera.com>
 <1403730927-16163-4-git-send-email-tthayer@altera.com>
 <20140708113109.GC8100@amd.pavel.ucw.cz>
Message-ID: <20140708114227.GB27659@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 01:31:09PM +0200, Pavel Machek wrote:
> > +	read_reg = readl(mc_vbase + DRAMADDRW);
> > +
> > +	width = readl(mc_vbase + DRAMIFWIDTH);
> > +
> > +	col = (read_reg & DRAMADDRW_COLBIT_MASK) >>
> > +		DRAMADDRW_COLBIT_LSB;
> > +	row = (read_reg & DRAMADDRW_ROWBIT_MASK) >>
> > +		DRAMADDRW_ROWBIT_LSB;
> > +	bank = (read_reg & DRAMADDRW_BANKBIT_MASK) >>
> > +		DRAMADDRW_BANKBIT_LSB;
> > +	cs = (read_reg & DRAMADDRW_CSBIT_MASK) >>
> > +		DRAMADDRW_CSBIT_LSB;
> 
> As I said, all the defines only make this harder to read. The code is
> pretty obvious if you put numbers in here...

Since when it is a good coding practice to put naked numbers instead of
descriptive macro names??!

Now, I can understand that the macro names could be made more
descriptive so that you can understand what they mean, but naked
numbers?! You must be joking although 1st of April is long gone.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
