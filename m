From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 3 Jun 2011 14:02:58 +0200
Subject: i.MX consolidation patches
In-Reply-To: <20110602154659.697EFD09481@gemini.denx.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601210855.663A3CEFB4E@gemini.denx.de>
	<BANLkTi=HqEBRzyU4_HXnNHTeOPL9vPW8PA@mail.gmail.com>
	<20110602154659.697EFD09481@gemini.denx.de>
Message-ID: <20110603120258.GR23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 05:46:59PM +0200, Wolfgang Denk wrote:
> Dear Matt,
> 
> In message <BANLkTi=HqEBRzyU4_HXnNHTeOPL9vPW8PA@mail.gmail.com> you wrote:
> >
> > In this case, just a load address in the uImage header of 0 (or some
> > other totally-impossible value like 0xffffffff
> > in case 0 is perfectly valid somewhere) and then just jump to the
> > entry point by deriving the value from the
> > header size - based on the fact that ARM images are PIC and the Linux
> > kernel always puts the entry point
> > at 0 offset - to the address of the uImage header + size of the uImage
> > header (which U-Boot knows already
> > from parsing the header).
> 
> I'm not a friend of using magic values that are "totally-impossible".
> This is confusing, and here it is not needed.

I find using a field labelled 'entry point' and 'load address' as
absolute addresses or offsets into sdram depending on some flag
also quite confusing. btw how do you want to decide whether the
fields are offsets or absolute addresses? I see no flags field in
the uImage format.

> 
> If we could agree to interpret load address and entry point as
> offsets, the only remaining problem is to find out if we can use a
> common offset.

The zImages encapsulated in uImages are relocatable. So pick any offset
between 32k and 128MB into sdram like Russell explained. Higher values
are not desirable as this would break boards with less sdram.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
