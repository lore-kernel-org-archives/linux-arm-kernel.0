From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Thu, 21 Apr 2016 19:40:42 +0200
Subject: [PATCH v5] irqchip, gicv3-its, numa: Enable workaround for
 Cavium thunderx erratum 23144
In-Reply-To: <1460748606-28390-1-git-send-email-rrichter@caviumnetworks.com>
References: <1460748606-28390-1-git-send-email-rrichter@caviumnetworks.com>
Message-ID: <20160421174042.GD24726@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.04.16 21:30:05, Robert Richter wrote:
> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> 
> The erratum fixes the hang of ITS SYNC command by avoiding inter node
> io and collections/cpu mapping on thunderx dual-socket platform.
> 
> This fix is only applicable for Cavium's ThunderX dual-socket platform.
> 
> This is based on NUMA v16 series.
> Message-Id: <1460155828-8690-1-git-send-email-ddaney.cavm@gmail.com>

Will, Catalin,

after NUMA base patches went into linux-next (many thanks), please
consider this pass 1.x errata workaround for inclusion too.

Thanks,

-Robert

> 
> v5 (by Robert Richter):
> fixed use of cpumask_of_node() only for (node >= 0)
> minor style fixes
> 
> v4:
> updated silicon-errata.txt
> updated as per Robert Richter review comment.
> 
> v3:
> updatated as per Marc Zyngier's review comments.
> http://www.spinics.net/lists/arm-kernel/msg443462.html
> 
> v2:
> updatated as per Marc Zyngier's review comments.
> 
> Reviewed-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  Documentation/arm64/silicon-errata.txt |  1 +
>  arch/arm64/Kconfig                     |  9 +++++++
>  drivers/irqchip/irq-gic-v3-its.c       | 49 ++++++++++++++++++++++++++++++++--
>  3 files changed, 57 insertions(+), 2 deletions(-)
