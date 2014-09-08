From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Sep 2014 12:35:47 +0100
Subject: [PATCH 1/2] gpio: Add driver for AXM55xx SSP chip selects
In-Reply-To: <CAE0=X_2q1Z+pGuh6OY9Si5jbrF9HkczNFUqUgK_8xBekNvMeyQ@mail.gmail.com>
References: <1409576021-24828-1-git-send-email-anders.berg@avagotech.com>
 <1409576021-24828-2-git-send-email-anders.berg@avagotech.com>
 <CACRpkdby4H-fivNn_kG2uL0EjsCGAc+t6OyFi0+VcNGf2Z9NQA@mail.gmail.com>
 <20140904170630.GL29327@sirena.org.uk>
 <CACRpkdZEoBan=Lqr1T-iY41U9NfMA_MCLX3LA=juw7X4pmRvSQ@mail.gmail.com>
 <CAE0=X_3QO5p26M=FS7joKS3zD6LAM_moFutHNcyE1-CjauL3Rw@mail.gmail.com>
 <20140906135308.GC2601@sirena.org.uk>
 <CAE0=X_2q1Z+pGuh6OY9Si5jbrF9HkczNFUqUgK_8xBekNvMeyQ@mail.gmail.com>
Message-ID: <20140908113547.GJ4015@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 01:02:32PM +0200, Anders Berg wrote:
> On Sat, Sep 6, 2014 at 3:53 PM, Mark Brown <broonie@kernel.org> wrote:

> > Would it not be more straightforward to just register it as a platform
> > device in this case, or use a separate OF ID in the DT?  We appear to
> > specify a compatible string when registering AMBA devices even if we are
> > capable of identifying using the ID registers.

> I'll drop this gpio patch for now and submit a patch on the pl022
> driver instead. I read the arm,primecell binding and learned that
> there is a property (arm,primecell-periphid) that can be used to
> override the HW PrimeCell ID. Seems like something to use here, right?

Possibly, though if there's no hardware ID to override to that might not
be the best option.  You could always define a property that's specific
to the pl022 driver flagging that it's got these extra chip selects though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140908/27fa5806/attachment.sig>
