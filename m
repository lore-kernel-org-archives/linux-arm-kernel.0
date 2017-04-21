From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 21 Apr 2017 14:05:52 +0200
Subject: [PATCH v2 2/3] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <20170421113645.GA18422@Red>
References: <20170419071418.18995-1-antoine.tenart@free-electrons.com>
 <20170419071418.18995-3-antoine.tenart@free-electrons.com>
 <20170421073056.GA2041@Red> <20170421092935.fszux3qg5hbwwobj@kwain>
 <20170421113645.GA18422@Red>
Message-ID: <20170421120552.phujnp4csesm6p3h@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 01:36:45PM +0200, Corentin Labbe wrote:
> > > > +	memset(ipad + keylen, 0, blocksize - keylen);
> > > > +	memcpy(opad, ipad, blocksize);
> > > > +
> > > > +	for (i = 0; i < blocksize; i++) {
> > > > +		ipad[i] ^= 0x36;
> > > > +		opad[i] ^= 0x5c;
> > > 
> > > What are these constant ?
> > 
> > They are defined in the HMAC RFC, as ipad and opad values. See
> > https://www.ietf.org/rfc/rfc2104.txt.
> > 
> 
> Since many driver use them, I think defining them in include/ should be done (HMAC_IPAD/HMAC_OPAD)
> I will send a patch for it.

OK, I'll send a following up patch on this driver when your series is
merged.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170421/76266910/attachment.sig>
