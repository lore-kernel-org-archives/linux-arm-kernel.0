From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 27 Oct 2012 22:46:44 +0100
Subject: [PATCH] spi/pl022: Activate resourses before deactivate them in
 suspend
In-Reply-To: <1349423012-18048-1-git-send-email-ulf.hansson@stericsson.com>
References: <1349423012-18048-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121027214642.GH4564@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2012 at 09:43:32AM +0200, Ulf Hansson wrote:

> To be able to deactivate resourses in suspend, the resourses must
> first be surely active. This is done with a pm_runtime_get_sync.
> Once the resourses are restored to active state again in resume,
> the runtime pm usage count can be decreased with a pm_runtime_put.

The PM core will ensure devices are runtime resumed before we enter
suspend precisely due to this sort of issue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121027/e3ecc64f/attachment.sig>
