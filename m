From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Dec 2013 17:09:54 +0000
Subject: [PATCH v5 1/3] ARM: Introduce atomic MMIO modify
In-Reply-To: <20131210170025.GA4360@n2100.arm.linux.org.uk>
References: <1386686497-20335-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1386686497-20335-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131210164907.GA11468@sirena.org.uk>
 <20131210170025.GA4360@n2100.arm.linux.org.uk>
Message-ID: <20131210170954.GD11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 05:00:25PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 10, 2013 at 04:49:07PM +0000, Mark Brown wrote:

> > > +EXPORT_SYMBOL(atomic_io_modify_relaxed);

> > This looks quite generic - why is it in architecture specific code?

> because the _relaxed IO operators don't exist on other architectures, and
> there's been some discussion around whether they should with no conclusions
> being reached.

Oh, that's depressing.  I guess the non-relaxed version could be made
generic but meh.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/97105f31/attachment.sig>
