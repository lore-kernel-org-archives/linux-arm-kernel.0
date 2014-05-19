From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 May 2014 13:14:33 +0100
Subject: [PATCH 4/6] arm64: topology: add MPIDR-based detection
In-Reply-To: <5379D594.2000200@arm.com>
References: <1399063112-16917-1-git-send-email-broonie@kernel.org>
 <1399063112-16917-5-git-send-email-broonie@kernel.org>
 <53763DFC.8070309@arm.com> <20140516183915.GP22111@sirena.org.uk>
 <5379D594.2000200@arm.com>
Message-ID: <20140519121433.GT12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 10:57:40AM +0100, Sudeep Holla wrote:
> On 16/05/14 19:39, Mark Brown wrote:
> >On Fri, May 16, 2014 at 05:34:04PM +0100, Sudeep Holla wrote:

> >>Take a simple example of system with 2 Quad core clusters.
> >>The mpidr_hash.shift_aff[1] will be 6 as you need minimum 2 bits to represent
> >>aff[0]. So you will end up with second cluster with id = 4 instead of 1.

> >This isn't a problem, the clusters can have any numbers so long as they
> >are distinct.  There is no other requirement.

> IIUC these topology information is exposed via sysfs. So it's good to have
> uniformity though they can have any number. As mentioned in the example, if the
> linearisation depend on aff[0], then this factor will not be uniform.

So your concern is that the width of aff[0] will vary?  That's
reasonable.  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/4aa2344e/attachment.sig>
