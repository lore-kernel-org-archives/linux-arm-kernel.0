From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 May 2014 12:31:24 -0400
Subject: [PATCH] ARM: mvebu: fix mis-merge in coherency.c
In-Reply-To: <1399299428-30690-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399299428-30690-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399299428-30690-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140508163124.GG12708@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 04:17:08PM +0200, Thomas Petazzoni wrote:
> Commit 31dd716233e066146d651889f7b01e8da9963bd7 lead to a conflict
> between the "Armada 375/38x I/O coherency" patch series and the
> "Armada XP cpuidle" patch series. Unfortunately, the conflict was
> improperly resolved, and leads to incorrect code in the
> coherency_type() function in arch/arm/mach-mvebu/coherency.c.
> 
> This commit fixes this mis-merge by restoring the appropriate code in
> coherency_type().
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/coherency.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)

I've squashed this in to mvebu/soc-cpuidle, please see:

  b41375f71ace ARM: mvebu: ll_set_cpu_coherent always uses the current CPU

I'll let this sit for a night in -next before I send the pull request
for mvebu/soc.  Which includes mvebu/soc-cpuidle now.

thx,

Jason.
