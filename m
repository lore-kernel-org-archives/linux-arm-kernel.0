From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 14 Oct 2013 20:47:00 +0800
Subject: [PATCH v3 3/3] ARM: add support for bit sliced AES using NEON
 instructions
In-Reply-To: <20131014121926.GN25034@n2100.arm.linux.org.uk>
References: <CAKv+Gu8gzRjOMhKoydR3DqMqHqREDC7ZHNn9AZcdxGOWE_N9Vw@mail.gmail.com>
 <20131013111457.GB25034@n2100.arm.linux.org.uk>
 <CAKv+Gu81Bb8jzVUgyS_=meJNLQaxydLLRR-5n5gY8b-reofzUQ@mail.gmail.com>
 <20131013112239.GD25034@n2100.arm.linux.org.uk>
 <CAKv+Gu--TmG3FxAHSYN_RG2FiLabFRCdp4vn1nrMOdOdfzgMwA@mail.gmail.com>
 <20131013113049.GE25034@n2100.arm.linux.org.uk>
 <20131014112921.GA15084@gondor.apana.org.au>
 <20131014120837.GM25034@n2100.arm.linux.org.uk>
 <20131014121021.GA15351@gondor.apana.org.au>
 <20131014121926.GN25034@n2100.arm.linux.org.uk>
Message-ID: <20131014124700.GA15660@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 01:19:26PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 14, 2013 at 08:10:21PM +0800, Herbert Xu wrote:
> > On Mon, Oct 14, 2013 at 01:08:37PM +0100, Russell King - ARM Linux wrote:
> > > On Mon, Oct 14, 2013 at 07:29:21PM +0800, Herbert Xu wrote:
> > > > On Sun, Oct 13, 2013 at 12:30:49PM +0100, Russell King - ARM Linux wrote:
> > > > > Herbert,
> > > > > 
> > > > > Could I have a git URL to pull the above commit please?
> > > > 
> > > > Russell, do you want me to revert this patch from cryptodev?
> > > > Otherwise I'm not quite sure what you want me to do here.
> > > 
> > > I'd like to pull a branch from you containing this commit to solve the
> > > build error I'm getting with my tree, so I can continue testing my tree.
> > > At the moment, this is an additional unnecessary cause of randconfig
> > > build failures.
> > 
> > I don't have a branch that contains just this patch so perhaps it
> > would be easiest if I just reverted it?
> 
> Well, I don't have it either.

Oh you were talking about the ablk_helper patch, and not some ARM
patch that sneaked into the crypto tree.

As it's a crypto driver that's being added then it should go
through the crypto tree.  If it depends on some ARM bits that's
only in linux-next then I could try to merge that, assuming the
underlying ARM tree is stable.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
