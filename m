From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 18:02:52 +0000
Subject: [PATCH 3/4] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20140107175641.GA14603@e102568-lin.cambridge.arm.com>
References: <1387483575-11430-1-git-send-email-broonie@kernel.org>
 <1387483575-11430-4-git-send-email-broonie@kernel.org>
 <20140107130540.GA8090@e102568-lin.cambridge.arm.com>
 <20140107133829.GF31886@sirena.org.uk>
 <20140107142929.GB8090@e102568-lin.cambridge.arm.com>
 <20140107150631.GJ31886@sirena.org.uk>
 <20140107175641.GA14603@e102568-lin.cambridge.arm.com>
Message-ID: <20140107180252.GJ31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 05:56:42PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Jan 07, 2014 at 03:06:31PM +0000, Mark Brown wrote:

> > At the very least that means hot unplugged, and it seems reasonable to
> > read that as being stronger than that.  The current ARM implementation
> > is more conservative since it doesn't provide any way to put the core on
> > line but it does seem more likely to match what a system integrator
> > would be trying to achieve and it also matches the standard meaning of
> > disabled.

> What do you mean by ARM implementation ? The status property is currently
> ignored on ARM. I'd agree with what you are saying but that should be
> specified in DT bindings.

The 32 bit ARM implementation.  That code was supposed to be just
cut'n'pasted from there, though I see now it wasn't...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/59c818df/attachment.sig>
