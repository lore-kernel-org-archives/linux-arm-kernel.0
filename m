From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Dec 2013 18:00:51 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131218173941.GA17594@e102568-lin.cambridge.arm.com>
References: <1387212565-12668-1-git-send-email-broonie@kernel.org>
 <20131217170625.GB9831@e102568-lin.cambridge.arm.com>
 <20131217195519.GD28455@sirena.org.uk>
 <20131218173941.GA17594@e102568-lin.cambridge.arm.com>
Message-ID: <20131218180051.GD31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 05:39:42PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Dec 17, 2013 at 07:55:19PM +0000, Mark Brown wrote:

> > I do think it's useful to to have the function there partly just as a
> > hook but more for the warning it generates if we manage to boot a core
> > that we didn't hook up with the topology information.  This seems like

> I think you have a point, the question is whether we need that function
> to run the check you mention or not, we can run the check for all possible
> cpus after completing the topology parsing. Actually, we might be

Yeah, it should be possible to do it elsewhere but then since the SMP
code is already enumerating all the cores it's going to boot it seemed
sensible to keep piggybacking on that and not duplicate the logic.

> building topology for cores that do not come online as well, I do not think
> this is a problem, but I have to cast a proper look into that before
> jumping to conclusions, thanks for pointing that out.

I'd expect that could reasonably happen if cores are administratively
disabled for some reason - that's one of the reasons for the status
marking in DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/8d42ba70/attachment.sig>
