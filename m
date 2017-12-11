From: lukma@denx.de (Lukasz Majewski)
Date: Mon, 11 Dec 2017 22:39:41 +0100
Subject: [PATCH v4 5/5] ARM: ep93xx: ts72xx: Add support for BK3 board -
 ts72xx derivative
In-Reply-To: <SN1PR0101MB156532C13ABBAE280B3754CED0370@SN1PR0101MB1565.prod.exchangelabs.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130235140.12243-1-lukma@denx.de>
 <20171130235140.12243-6-lukma@denx.de>
 <SN1PR0101MB156532C13ABBAE280B3754CED0370@SN1PR0101MB1565.prod.exchangelabs.com>
Message-ID: <20171211223941.744be82f@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hartley,

> On Thursday, November 30, 2017 4:52 PM, Lukasz Majewski wrote:
> >
> > The BK3 board is a derivative of the ts72xx reference design.  
> 
> Lukasz,
> 
> I was just reviewing the other TS-72xx boards and noticed this:
> 
> <snip>
> 
> > +/* BK3 specific defines */
> > +#define BK3_CPLDVER_PHYS_BASE		0x23400000
> > +#define BK3_CPLDVER_VIRT_BASE		0xfebfd000
> > +#define BK3_CPLDVER_SIZE		0x00001000
> > +  
> 
> <snip>
> 
> > +static struct map_desc bk3_io_desc[] __initdata = {
> > +	{
> > +		.virtual	= BK3_CPLDVER_VIRT_BASE,
> > +		.pfn		=
> > __phys_to_pfn(BK3_CPLDVER_PHYS_BASE),
> > +		.length	= BK3_CPLDVER_SIZE,
> > +		.type		= MT_DEVICE,
> > +	}
> > +};
> > +  
> 
> This register appears to be common to all the TS-72xx boards.

The CPLD was used on the reference ts-72xx boards, but support for it
seems to not be present in the mainline kernel.

Do you have a ts72xx board with CPLD embedded? Is any of your design
using it?


My another concern - is it safe to perform IO mapping on memory regions
which are not used / specified? When I do a single ts72xx mapping - for
all boards - then we may end up with some mappings which are not needed.

With the code as it is - I only map regions which are already used on
relevant boards.

> 
> I don't think Arnd has pulled the series yet. Would you mind renaming
> the defines and rebasing this patch? 

If needed I can resend the patch series, or prepare a single fix patch.
No problem.

> The BK3 board and other TS-72xx
> boards can then have a common .map_io.
> 
> Thanks,
> Hartley
> 



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171211/0cfc9f29/attachment.sig>
