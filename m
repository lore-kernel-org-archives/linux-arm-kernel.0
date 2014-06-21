From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 20:41:45 -0400
Subject: [PATCH 5/5] irqchip: irq-armada-370-xp: mask all interrupts
 during initialization
In-Reply-To: <1401481098-23326-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1401481098-23326-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1401481098-23326-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140621004145.GU21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 10:18:18PM +0200, Thomas Petazzoni wrote:
> Until now, the irq-armada-370-xp irqchip driver was not masking all
> interrupts at initialization. While in most cases this is not a
> problem because the bootloader has probably masked all interrupts, it
> becomes a problem when you use kexec: you're in kernel A, with many
> interrupts enabled, and then kexec into kernel B, without going
> through the bootloader. So during the boot process, if an interrupt
> occurs while the corresponding driver has not been loaded, you would
> get spurious interrupts.
> 
> This commit fixes that by ensuring all interrupts are properly masked
> when the irqchip driver is initialized. Note that interrupt masking
> takes place at two level: at the global level (main_int_base) and at
> the per-CPU level (per_cpu_int_base).
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Applied to irqchip/urgent with the Subject line amended as follows:

  "irqchip: armada-370-xp: Mask all interrupts during initialization."

thx,

Jason.
