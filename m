From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Thu, 30 Nov 2017 08:07:52 +0100
Subject: [PATCH v2 6/6] ARM: ep93xx: ts72xx: Add support for BK3 board -
 ts72xx derivative
In-Reply-To: <20171129230704.68b5ec42@jawa>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171121143204.1839-1-lukma@denx.de>
 <20171121143204.1839-7-lukma@denx.de>
 <86943b7f-be3a-2f41-1ffe-c4d7abfee148@gmail.com>
 <20171129230704.68b5ec42@jawa>
Message-ID: <20171130080752.f805cbf32704649bf8735385@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lukasz,

On Wed, 29 Nov 2017 23:07:04 +0100
Lukasz Majewski <lukma@denx.de> wrote:

> > > +/*************************************************************************
> > > + * BK3 support code
> > > +
> > > *************************************************************************/
> > > +static struct mtd_partition bk3_nand_parts[] = {
> > > +	{
> > > +		.name		= "System",
> > > +		.offset	= 0x00000000,  
> > 
> > I see the above and below lines as unaligned
> 
> This is strange.... I'm using emacs with extension to have coding style
> for kernel.
> 
> Probably tabs get unaligned...

Yes, seems that they are.

[...]

> > 
> > > +	.atag_offset	= 0x100,
> > > +	.map_io	= bk3_map_io,  
> > 
> > again, inconsistent alignment...
> 
> Even more..... checkpatch.pl did not complained....

checkpatch.pl wouldn't complain, as there are basically two styles,
some people do not align the individual assignments in the structures at all.
But I was quite confident in the beginning and now even applied your v3 to
the code. And indeed it's unaligned... I even checked with emacs. Still
unaligned.

-- 
Alexander Sverdlin.
