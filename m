From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Jun 2014 14:54:31 +0100
Subject: [PATCH] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140604130114.GB10775@e102568-lin.cambridge.arm.com>
References: <1401644249-23792-1-git-send-email-broonie@kernel.org>
 <20140603173103.GA18004@red-moon>
 <20140603210424.GJ31751@sirena.org.uk>
 <20140604093452.GA8057@e102568-lin.cambridge.arm.com>
 <20140604115751.GH2520@sirena.org.uk>
 <20140604130114.GB10775@e102568-lin.cambridge.arm.com>
Message-ID: <20140604135431.GL2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 02:01:14PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Jun 04, 2014 at 12:57:51PM +0100, Mark Brown wrote:

> > > All I am saying is, let's wait and see, there is no compelling need to
> > > use aff3 (and aff2 on non-SMT systems) on current systems for the

> > That's still a kernel patch or having to write DT to get things working
> > which for the sake of avoiding a couple of shift and or statements just
> > seems unhelpful.  If it was just going to give poor performance that'd
> > be one thing but it's actively broken.

> What's broken ? Please provide me with an example and I will update the
> patch.

If some system we encounter in the future is for example a SMT system
which does use aff3 then until someone actively goes and fixes it by
writing the DT/ACPI or updating the kernel if there's two threads
0,0,0,0 and 0,0,0,1 we'll tell the scheduler they're both 0,0,0 which
we're not supposed to do.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/fcea0077/attachment.sig>
