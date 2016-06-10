From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 10 Jun 2016 16:22:10 +0200
Subject: [PATCH] ARM: tegra: fix missing include <soc/tegra/cpuidle.h>
In-Reply-To: <1465404897-16654-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465404897-16654-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160610142210.GN27142@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 05:54:57PM +0100, Ben Dooks wrote:
> The prototype of tegra_cpuidle_pcie_irqs_in_use() is missing
> from the cpuidle.c file, it is defined in <soc/tegra/cpuidle.h>
> so add that include to avoid the following warning:
> 
> arch/arm/mach-tegra/cpuidle.c:51:6: warning: symbol 'tegra_cpuidle_pcie_irqs_in_use' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-tegra at vger.kernel.org
> ---
>  arch/arm/mach-tegra/cpuidle.c | 1 +
>  1 file changed, 1 insertion(+)

I've been carrying a set of patches to fix these, and a couple of other
sparse warnings, in my tree locally, but never sent them out because
they were so trivial. I probably should've to avoid the duplication of
effort. Sorry about that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/ffcc37ab/attachment.sig>
