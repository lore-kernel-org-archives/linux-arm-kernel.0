From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 12:17:42 +0000
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131217114734.GC32118@arm.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
 <20131216105734.GA8931@e102568-lin.cambridge.arm.com>
 <20131216122948.GF3185@sirena.org.uk>
 <20131216144638.GE8931@e102568-lin.cambridge.arm.com>
 <20131216151232.GH3185@sirena.org.uk>
 <20131217114734.GC32118@arm.com>
Message-ID: <20131217121742.GS3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 11:47:34AM +0000, Catalin Marinas wrote:
> On Mon, Dec 16, 2013 at 03:12:32PM +0000, Mark Brown wrote:

> > Actually now I think about it if we're not going to parse the MPIDR we
> > should probably update the bindings to say that the topology binding is
> > mandatory for any v8 system with more than one core.

> Do we need such information if only a flat topology is needed?

Probably not but it's simpler to specify that rather than saying it's
mandatory only if you need it and it might be useful to know if
everything is a flat collection of threads or a flat collection of
cores, it seems better to get the information in there if we can in case
the DT is fixed.  Single core systems are the only ones where it's
definitely never going to be helpful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/2e597e6b/attachment.sig>
