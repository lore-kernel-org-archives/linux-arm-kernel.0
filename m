From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jun 2015 13:00:05 +0100
Subject: [PATCH V3 2/2] tee: add OP-TEE driver
In-Reply-To: <20150520121648.GA9819@ermac>
References: <1431671667-11219-1-git-send-email-jens.wiklander@linaro.org>
 <1431671667-11219-3-git-send-email-jens.wiklander@linaro.org>
 <20150518131850.GA7064@leverpostej> <20150520121648.GA9819@ermac>
Message-ID: <20150604120005.GA10283@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 02:16:48PM +0200, Jens Wiklander wrote:

> > > +#define OPTEE_SMC_SHM_NONCACHED                0ULL
> > > +#define OPTEE_SMC_SHM_CACHED           1ULL

> > What precise set of memory attributes do these imply?

...

> OP-TEE is more or less always compiled for a specific platform so if the
> kernel uses some other mapping for a particular platform we'll change the
> OP-TEE settings to be compatible with the kernel on that platform.

I'm not convinced that's a realistic assumption going forwards - I
certainly hope it isn't.  Currently TEE code tends to be only built for
verticial systems because of this lack of standardiation (and the fact
that so much is proprietary at the minute) but hopefully one of the
results of having a reusable solution in the standard kernel with an
open platform for the secure side will be that people will be more able
to use this, perhaps in applications where things like single kernel
support are much more important than they are for the environments where
TEEs are currently deployed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150604/da1dc07b/attachment-0001.sig>
