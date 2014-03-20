From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Mar 2014 17:52:53 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140320171930.GA28238@arm.com>
References: <1395252139-16239-1-git-send-email-broonie@kernel.org>
 <20140320112650.GA1408@red-moon>
 <20140320134357.GE11706@sirena.org.uk>
 <20140320171930.GA28238@arm.com>
Message-ID: <20140320175253.GH11706@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 05:19:32PM +0000, Catalin Marinas wrote:
> On Thu, Mar 20, 2014 at 01:43:57PM +0000, Mark Brown wrote:

> > To be honest at this point I think what I want to do is go back to the
> > original approach of layering DT on top of MPIDR.  MPIDR is smaller and
> > simpler code so seems more likely to make progress.  I really do expect
> > that for a very large proportion of systems it'll be sufficient.

> Do you mean the physical MPIDR_EL1 or the DT representation of
> MPIDR_EL1?

Well, the affinities need to be the same anyway (so we can tie the
hardware to the description in DT) though we need to use the physical
register to get the MT bit since the binding requires that this be
omitted from the value stored in DT.  Lorenzo was keen on paying
attention to the MT bit which does seem like a reasonable thing to do.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140320/366f8a28/attachment.sig>
