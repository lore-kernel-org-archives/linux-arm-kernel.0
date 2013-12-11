From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 16:13:52 +0000
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131211144924.GG596@darko.cambridge.arm.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
 <20131211141224.GG26730@mudshark.cambridge.arm.com>
 <20131211141503.GX11468@sirena.org.uk>
 <20131211142431.GD596@darko.cambridge.arm.com>
 <20131211143018.GZ11468@sirena.org.uk>
 <20131211144924.GG596@darko.cambridge.arm.com>
Message-ID: <20131211161352.GC11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 02:49:24PM +0000, Catalin Marinas wrote:
> On Wed, Dec 11, 2013 at 02:30:18PM +0000, Mark Brown wrote:

> > For clarity the current code only uses DT information, the MPIDR values
> > it uses are those in the CPU nodes in the DT which are used by the SMP
> > code and are not read from the hardware.

> But these must match the hardware MPIDR to be useful on SMP. So whether
> you read them from hardware or DT, they are still the same.

OK.  To be honest it does seem a bit unehelpful to just ignore the
values; systems with bogus MPIDRs can always use the topology binding to
set something sensible so we end up making work for people who did the
right thing.  That said...

> > We can drop that bit of code
> > easily enough but it seemed useful for getting the scaffolding in place
> > separately to the binding parsing and for general robustness, perhaps
> > adding a patch at the end of the series to drop the code handling MPIDR
> > would deal with the application issues?

> Can we have the topology infrastructure with a flat initial topology and
> the actual building in a separate patch?

That would be the effect of just dropping that hunk completely, the
default values we initialise if we don't do anything have that effect.
I'll do that when I repost.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/85cf2894/attachment.sig>
