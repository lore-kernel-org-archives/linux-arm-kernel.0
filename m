From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Dec 2013 15:12:32 +0000
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131216144638.GE8931@e102568-lin.cambridge.arm.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
 <20131216105734.GA8931@e102568-lin.cambridge.arm.com>
 <20131216122948.GF3185@sirena.org.uk>
 <20131216144638.GE8931@e102568-lin.cambridge.arm.com>
Message-ID: <20131216151232.GH3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 02:46:38PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Dec 16, 2013 at 12:29:48PM +0000, Mark Brown wrote:

> > Well, we need to consider the possibility of ACPI or whatever as well.

> That's a fair point, I will have a look at v2.

Probably best to wait until the v4 or whatever that I'm going to post
shortly (need to do a few more checks locally before I post).  I'll CC
you.

[MPIDR parsing]
> > Again, this is gone from the current version.  Like I said to Catalin it
> > does feel like this is making more work for systems that have done the
> > right thing with their MPIDRs which doesn't seem ideal (and note that
> > all the DTs that you guys are publishing for your models lack any
> > topology information at present).

> This is an age-old question and the problem has always been that the
> "right thing" is recommended, not enforced. I do not want to turn this into
> bikeshedding, as long as cpu-map node takes priority if present, fine by me.

I already dropped that code, though I could resurrect it (perhaps as a
separate patch).  The way the code was written was as you describe as a
last resort - MPIDR would only be considered if the explict topology
binding was not present, it was done as a last step before reporting if
no other topology information was discovered.

Actually now I think about it if we're not going to parse the MPIDR we
should probably update the bindings to say that the topology binding is
mandatory for any v8 system with more than one core.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/9a8ff959/attachment.sig>
