From: plaes@plaes.org (plaes at plaes.org)
Date: Thu, 24 Nov 2011 11:49:33 +0200
Subject: [PATCH] ARM: mach-orion5x: Use hex2bin that is present in
 kernel lib
In-Reply-To: <20111124064018.GD795@wantstofly.org>
References: <1322058417.2472.9.camel@localhost.localdomain>
 <20111124064018.GD795@wantstofly.org>
Message-ID: <1322128173.31424.12.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?hel kenal p?eval, N, 2011-11-24 kell 07:40, kirjutas Lennert Buytenhek:
> On Wed, Nov 23, 2011 at 04:26:57PM +0200, plaes at plaes.org wrote:
>
[...]
> >
> > [...]
> >
> >  	for (i = 0; i < 6; i++)	{
> > -		int byte;
> > -
> > -		byte = dns323_parse_hex_byte(mac_page + (i * 3));
> > -		if (byte < 0) {
> > +		if (hex2bin(addr[i], mac_page + (i * 3), 2))
> >  			goto error_fail;
> 
> I don't think that this does what you think it does...

Indeed. I assume that it didn't even compile. I have fixed the two
issues I found in the previous patch and tweaked the printk output for
TS-x09. Run-tested with similar code on x86 so now I'm confident enough
to sign it off ;)

P?ikest,
Priit Laes ;)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-mach-orion5x-Use-hex2bin-that-is-present-in-kern.patch
Type: text/x-patch
Size: 3353 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111124/e786a30b/attachment.bin>
