From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Apr 2014 22:31:14 +0100
Subject: [PATCH v3 0/2] change ARM linux memory layout to support 32 CPUs
In-Reply-To: <1397559967-26050-1-git-send-email-sdu.liu@huawei.com>
References: <1397559967-26050-1-git-send-email-sdu.liu@huawei.com>
Message-ID: <20140422213114.GA24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 07:06:05PM +0800, Liu Hua wrote:
> This patch series change fixmap mapping region to suppport 32 CPUs.
> Because the "top_pmd" covers 0xfffe0000 - 0xffffffff(2M). And part 
> is used by vector table. So I move this region down to 0xffc00000
>  - 0xffdffff. 

Can you explain why you have submitted these patches to my patch tracker
with a copy to stable at vger.kernel.org ?

What makes these qualify for stable tree inclusion?  What regression are
they fixing?

We don't put patches into the stable tree for things that /never/ worked
in the past.  We've never supported 32 CPUs so I don't think these
qualify.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
