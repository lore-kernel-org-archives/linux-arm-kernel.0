From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 22 Nov 2011 19:39:57 +0000
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111122193124.GB9581@n2100.arm.linux.org.uk>
References: <20111122192741.GG30583@opensource.wolfsonmicro.com>
 <20111122193124.GB9581@n2100.arm.linux.org.uk>
Message-ID: <20111122193957.GH30583@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 07:31:24PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 22, 2011 at 07:27:41PM +0000, Mark Brown wrote:

> > I've verified that this was introduced in the Russell's for-next, and
> > bisection of that branch tells me that the offending commit is "ARM:
> > vic: device tree binding" though an attempt to revert that in -next
> > failed.  This is especially surprising as I have USE_OF turned off, I'm

> Thanks for the report.  I'll hold off pushing this stuff into the
> devel-stable branch while Jamie looks into this so that we can fix
> it and avoid having a bisection failure in this set of commits.

Thanks.  Note that I'm not 100% sure I believe the bisection result as
reverting didn't fix the issue and I've stared at the code a bit without
seeing anything that set off alarm bells.
