From: broonie@kernel.org (Mark Brown)
Date: Sat, 6 Sep 2014 14:53:08 +0100
Subject: [PATCH 1/2] gpio: Add driver for AXM55xx SSP chip selects
In-Reply-To: <CAE0=X_3QO5p26M=FS7joKS3zD6LAM_moFutHNcyE1-CjauL3Rw@mail.gmail.com>
References: <1409576021-24828-1-git-send-email-anders.berg@avagotech.com>
 <1409576021-24828-2-git-send-email-anders.berg@avagotech.com>
 <CACRpkdby4H-fivNn_kG2uL0EjsCGAc+t6OyFi0+VcNGf2Z9NQA@mail.gmail.com>
 <20140904170630.GL29327@sirena.org.uk>
 <CACRpkdZEoBan=Lqr1T-iY41U9NfMA_MCLX3LA=juw7X4pmRvSQ@mail.gmail.com>
 <CAE0=X_3QO5p26M=FS7joKS3zD6LAM_moFutHNcyE1-CjauL3Rw@mail.gmail.com>
Message-ID: <20140906135308.GC2601@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 11:05:37AM +0200, Anders Berg wrote:

> Well, the problem with adding this to the spi-pl022 driver (as a
> vendor specific extension) is that this IP block unfortunately isn't
> distinguishable from the standard ARM PL022 implementation (same
> values in the PrimeCell identification registers). That's why I went
> down the GPIO path...

Would it not be more straightforward to just register it as a platform
device in this case, or use a separate OF ID in the DT?  We appear to
specify a compatible string when registering AMBA devices even if we are
capable of identifying using the ID registers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140906/80437134/attachment.sig>
