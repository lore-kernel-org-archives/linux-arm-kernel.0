From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Sep 2010 11:15:31 +0100
Subject: [PATCH 02/14] omap: Map only available sram memory
In-Reply-To: <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20100917101531.GB27467@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 17, 2010 at 03:17:46PM +0530, Santosh Shilimkar wrote:
> Currently we map 1 MB section while setting up SRAM on OMAPs.
> The actual physcal OCM RAM available on OMAP SOCs is in order

physical

> of KBs. This patch maps only available sram and removes some
> non necessary cpu_is_xxx checks.
> 
> On the newer ARMs with speculation, this is dangerous and can
> result in untraceable aborts.

"this" should be expanded (otherwise it is unclear whether it refers to
the original code or the new code.)
