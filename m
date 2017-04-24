From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 24 Apr 2017 16:00:56 +0800
Subject: [PATCH v2] crypto: arm64/sha: Add constant operand modifier to
 ASM_EXPORT
In-Reply-To: <20170418173401.GA128305@google.com>
References: <20170405183458.193068-1-mka@chromium.org>
 <CAP=VYLpejcYwXUMtCCkXmjXw=T1tBJLn21aVi-9v_VGmEinjRg@mail.gmail.com>
 <CAKv+Gu_DHBT=2YA9h+ao3pZXgEV5KsO9ia+J90wtLuDX=a4+eg@mail.gmail.com>
 <20170418173401.GA128305@google.com>
Message-ID: <20170424080056.GA20285@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 10:34:01AM -0700, Matthias Kaehlcke wrote:
> El Tue, Apr 18, 2017 at 04:35:02PM +0100 Ard Biesheuvel ha dit:
> 
> > On 18 April 2017 at 15:47, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> > > On Wed, Apr 5, 2017 at 2:34 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > >> The operand is an integer constant, make the constness explicit by
> > >> adding the modifier. This is needed for clang to generate valid code
> > >> and also works with gcc.
> > >
> > > Actually it doesn't work with all gcc.  I've got an older arm64 toolchain that I
> > > only use for syntax checking (and hence I don't care if it is the latest and
> > > greatest) and this commit breaks it:
> > >
> > > arch/arm64/crypto/sha1-ce-glue.c:21:2: error: invalid 'asm': invalid
> > > operand prefix '%c'
> > >   asm(".globl " #sym "; .set " #sym ", %c0" :: "i"(val));
> 
> Sorry about that :(

So what's the consensus? Should I revert this patch?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
