From: joe@perches.com (Joe Perches)
Date: Wed, 27 Feb 2013 20:22:54 -0800
Subject: [RFC PATCH v2 0/4] Add support for LZ4-compressed kernel
In-Reply-To: <20130227173644.GC17833@n2100.arm.linux.org.uk>
References: <1361859870-15751-1-git-send-email-kyungsik.lee@lge.com>
 <512D1C12.4080109@oberhumer.com>
 <alpine.LFD.2.03.1302261557220.1254@syhkavp.arg>
 <87fw0i7n6d.fsf@dell.be.48ers.dk>
 <20130226221027.GW17833@n2100.arm.linux.org.uk>
 <1361929234.1924.8.camel@joe-AO722>
 <20130227095609.GY17833@n2100.arm.linux.org.uk>
 <1361980152.2035.13.camel@joe-AO722>
 <20130227163118.GB17833@n2100.arm.linux.org.uk>
 <1361984688.2035.20.camel@joe-AO722>
 <20130227173644.GC17833@n2100.arm.linux.org.uk>
Message-ID: <1362025374.1928.13.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(removed Richard Purdie and Albin Tonnerre as their email addresses
 seem to be bounding)

> While recently asking someone to enable VFP debugging, so I could help
> sort out a problem they had reported, this is the debug output I was
> greeted by thanks to your meddling:

:) Meddling... You sound like one of those nameless
villains on Scooby Doo.  If only I had a cool nickname
like Dave "Shaggy" Kliekamp.  I guess you'd have to call
me Velma.

> [  927.235546] \x01\x01\x01\x01\x01\x01\x01\x01
> ...
> [  927.241505] \x01\x01\x01\x01\x01\x01\x01\x01\x01\x01\x01                     
> 
> 7.6 `.asciz "STRING"'...
> ========================
> 
> `.asciz' is just like `.ascii', but each string is followed by a zero
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> byte.  The "z" in `.asciz' stands for "zero".
> ^^^^^

Yeah, sorry.  I thought that the zero was after any
concatenation like .c.  Learned something.  'preciate
that.  Would have appreciated a polite "you broke it"
email too.

> ??? Yea, right, meanwhile breaking the ability of stuff to produce
> kernel messages.

Fortunately, that's the only .S instance.

> > > > > > > so that we can see whether it's worth updating the LZO code
> > Sounded as if you were doubtful to me.
> _In_ the decompressor.  We're talking about the _decompressor_ in
> this thread.

My opinion is it's useful to update LZO.

cheers, Joe (aka: Velma)
