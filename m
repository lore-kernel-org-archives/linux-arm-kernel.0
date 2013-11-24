From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 24 Nov 2013 15:56:32 +0800
Subject: crypto dependency in bit sliced AES
In-Reply-To: <20131124010207.GK16735@n2100.arm.linux.org.uk>
References: <CAKv+Gu8PESZ3uFZ6Rf+sma9QeRd7xSyrEa=RVCeDR1KtmLKEAA@mail.gmail.com>
 <20131122225256.GG16735@n2100.arm.linux.org.uk>
 <CA+55aFwRWGdA934GQdo6QpEuxRxeECvrpi9ctJWcVQ5pCyF1iw@mail.gmail.com>
 <20131123013924.GA16533@gondor.apana.org.au>
 <CAADWXX9CRRZF3Ewt5sXWQuCdKVVpe_-TdT+BW_MRrMUG2h1eGA@mail.gmail.com>
 <20131124010207.GK16735@n2100.arm.linux.org.uk>
Message-ID: <20131124075632.GA7807@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 24, 2013 at 01:02:07AM +0000, Russell King - ARM Linux wrote:
> On Sat, Nov 23, 2013 at 04:16:18PM -0800, Linus Torvalds wrote:
> >   Received-SPF: neutral (google.com: 178.18.16.133 is neither
> > permitted nor denied by best guess record for domain of
> > herbert at gondor.apana.org.au) client-ip=178.18.16.133;
> >   Authentication-Results: mx.google.com;
> >        spf=neutral (google.com: 178.18.16.133 is neither permitted nor
> > denied by best guess record for domain of herbert at gondor.apana.org.au)
> > smtp.mail=herbert at gondor.apana.org.au
> > 
> > with that whole "best guess record for domain" crap. So at the very
> > least your spf records are questionable.
> > 
> > And when I do "nslookup -q=mx gondor.apana.org.au" I get:
> > 
> >   Server: 192.168.0.1
> >   Address: 192.168.0.1#53
> > 
> >   Non-authoritative answer:
> >   gondor.apana.org.au canonical name = gondor.hengli.com.au.
> >   gondor.hengli.com.au mail exchanger = 10 mx2.hengli.com.au.
> >   gondor.hengli.com.au mail exchanger = 5 mx1.hengli.com.au.
> > 
> >   Authoritative answers can be found from:"
> 
> What probably doesn't help is this... from my exim logs:
> 
> <= herbert@gondor.apana.org.au H=ringil.hengli.com.au
> (fornost.hengli.com.au) [178.18.16.133]:51158 I=[78.32.30.222]:25 P=esmtps
> X=TLSv1:AES256-SHA:256 S=2150 id=20131123013924.GA16533 at gondor.apana.org.au
> T="Re: crypto dependency in bit sliced AES" for linux at arm.linux.org.uk

OK, I've fixed the EHLO header and added an SPF record.  Hopefully
gmail will stop listing my emails as spam now.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
