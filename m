From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jan 2014 19:16:46 +0000
Subject: [PATCH v10 4/4] arm64: topology: Provide relative power numbers
 for cores
In-Reply-To: <20140114134310.GF15567@sirena.org.uk>
References: <1389287106-29979-1-git-send-email-broonie@kernel.org>
 <1389287106-29979-5-git-send-email-broonie@kernel.org>
 <52D48FF9.1070501@nvidia.com>
 <20140114134310.GF15567@sirena.org.uk>
Message-ID: <20140114191646.GV15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 01:43:10PM +0000, Mark Brown wrote:

> The other option here is runtime tunables via sysfs or whatever which
> avoids baking numbers into the DT in the same way, though that is partly
> just a punt of the same problem to userspace.  That's probably also more
> helpful to people doing the tuning since it can be tweaked dynamically.

One other thing on this which occurred to me later on: if we do want to
make these values directly tunable we probably want to do that from the
scheduler rather than individual architectures.  These are scheduler
interfaces and the issues which make tuning desirable are essentially
architecture neutral ones.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/ce351e7a/attachment.sig>
