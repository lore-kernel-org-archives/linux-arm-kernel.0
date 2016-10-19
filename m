From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Oct 2016 09:46:07 +0100
Subject: [PATCH v2 0/8] crypto: ARM/arm64 - big endian fixes
In-Reply-To: <20161019030333.GA1269@gondor.apana.org.au>
References: <1476209720-21114-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161018114932.GG10115@e104818-lin.cambridge.arm.com>
 <CAKv+Gu9wuXnrq77a3Zk0GnHgnkpURh=EegwgP+vAwMC=rdm3qA@mail.gmail.com>
 <20161019030333.GA1269@gondor.apana.org.au>
Message-ID: <20161019084607.GB9193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 11:03:33AM +0800, Herbert Xu wrote:
> On Tue, Oct 18, 2016 at 01:14:38PM +0100, Ard Biesheuvel wrote:
> > On 18 October 2016 at 12:49, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Tue, Oct 11, 2016 at 07:15:12PM +0100, Ard Biesheuvel wrote:
> > >> As it turns out, none of the accelerated crypto routines under arch/arm64/crypto
> > >> currently work, or have ever worked correctly when built for big endian. So this
> > >> series fixes all of them. This v2 now includes a similar fix for 32-bit ARM as
> > >> well, and an additional fix for XTS which escaped my attention before.
> > >>
> > >> Each of these patches carries a fixes tag, and could be backported to stable.
> > >> However, for patches #1 and #5, the fixes tag denotes the oldest commit that the
> > >> fix is compatible with, not the patch that introduced the algorithm.
> > >
> > > I think for future reference, the Fixes tag should denote the commit
> > > that introduced the issue. An explicit Cc: stable tag would state how
> > > far back it should be applied.
> > >
> > 
> > OK, that sounds reasonable.
> > 
> > >> Ard Biesheuvel (8):
> > >>   crypto: arm64/aes-ce - fix for big endian
> > >>   crypto: arm64/ghash-ce - fix for big endian
> > >>   crypto: arm64/sha1-ce - fix for big endian
> > >>   crypto: arm64/sha2-ce - fix for big endian
> > >>   crypto: arm64/aes-ccm-ce: fix for big endian
> > >>   crypto: arm64/aes-neon - fix for big endian
> > >>   crypto: arm64/aes-xts-ce: fix for big endian
> > >>   crypto: arm/aes-ce - fix for big endian
> > >
> > > The changes look fine to me but I can't claim I fully understand these
> > > algorithms. FWIW:
> > >
> > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > >
> > > (Will may pick them up for 4.9-rcX)
> > 
> > Thanks, although I was kind of expecting Herbert to pick these up,
> > given that #8 affects ARM not arm64.
> > 
> > But if you (or Will) can pick up #1 to #7, that is also fine, then I
> > can drop #8 into rmk's patch database.
> 
> I was planning merging these for 4.10.  But I'm fine with them
> going through the arm tree.  Let me know what you guys want to
> do.

I assumed you'd take them through crypto, as per usual, so I didn't
queue anything in the arm64 tree.

Ard -- were you planning to get these in for 4.9?

Will
