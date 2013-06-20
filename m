From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 20 Jun 2013 08:16:44 -0400
Subject: [PATCH] arm: mvebu: fix coherency_late_init() for multiplatform
In-Reply-To: <1371714326-25971-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371714326-25971-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130620121644.GM31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 09:45:26AM +0200, Thomas Petazzoni wrote:
> As noticed by Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>, commit
> 865e0527d2d7 ('arm: mvebu: avoid hardcoded virtual address in
> coherency code') added a postcore_initcall() to register the bus
> notifier that the mvebu code needs to apply correct DMA operations on
> its platform devices breaks the multiplatform boot on other platforms,
> because the bus notifier registration is unconditional.
> 
> This commit fixes that by registering the bus notifier only if we have
> the mvebu coherency unit described in the Device Tree. The conditional
> used is exactly the same in which the bus_register_notifier() call was
> originally enclosed before 865e0527d2d7 ('arm: mvebu: avoid hardcoded
> virtual address in coherency code').
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reported-by: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
> ---
> This fix has been reported by Arnaud to fix the boot on his OMAP4
> PandaBoard, and it continues to work well on Marvell Armada XP GP.
> 
> This commit is based on jcooper/mvebu/regmap.
> ---
>  arch/arm/mach-mvebu/coherency.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to mvebu/regmap

thx,

Jason.
