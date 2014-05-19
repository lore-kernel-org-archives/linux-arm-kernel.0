From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 May 2014 19:39:53 +0100
Subject: [PATCH 4/6] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140519171511.GA5240@e102568-lin.cambridge.arm.com>
References: <1399063112-16917-1-git-send-email-broonie@kernel.org>
 <1399063112-16917-5-git-send-email-broonie@kernel.org>
 <53763DFC.8070309@arm.com> <20140516183915.GP22111@sirena.org.uk>
 <5379D594.2000200@arm.com>
 <20140519105405.GC5935@e102568-lin.cambridge.arm.com>
 <20140519123314.GU12304@sirena.org.uk>
 <20140519141323.GA2917@e102568-lin.cambridge.arm.com>
 <20140519161217.GX12304@sirena.org.uk>
 <20140519171511.GA5240@e102568-lin.cambridge.arm.com>
Message-ID: <20140519183953.GI12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 06:15:11PM +0100, Lorenzo Pieralisi wrote:
> On Mon, May 19, 2014 at 05:12:17PM +0100, Mark Brown wrote:

> > This would leave the MPIDR support worse than DT which seems retrograde
> > especially given that it's so simple to differentiate the clusters.  The
> > only issue with that appears to be about precisely how to make up the
> > cluster numbers which is a cosmetic one.

> That's the reason why I said you should not bother. If you want to use
> 4 affinity levels, I do not see the point in using the hash for that though,
> since all we need is a unique id which can be easily created without
> resorting to hashing.

Right, OK.  I personally wouldn't have used anything non-trivial either
but equally well I didn't see any strong reason not to do it either and
it's what Zi Shen sent.  I suspect this is based on the review comments
the first time around.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/88426375/attachment.sig>
