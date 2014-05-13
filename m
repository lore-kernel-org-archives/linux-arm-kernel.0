From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 May 2014 11:22:33 -0400
Subject: [PATCH 5/7] irqchip: s3c24xx: fix function type for
 IRQCHIP_OF_DECLARE
In-Reply-To: <1399940993-1773-6-git-send-email-robherring2@gmail.com>
References: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
 <1399940993-1773-6-git-send-email-robherring2@gmail.com>
Message-ID: <20140513152233.GB27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On Mon, May 12, 2014 at 07:29:51PM -0500, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Adding function type checking to IRQCHIP_OF_DECLARE found a type mismatch
> with s3c2410_init_intc_of and s3c2416_init_intc_of. The function only takes
> the 1st 2 parameters.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/irqchip/irq-s3c24xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thomas has asked me to give him a hand with the patches for
drivers/irqchip.  When you add these two to your tree, could you amend
the subject line to conform with the other patches in that directory?

eg (note the capitalization on 'Fix'):

  irqchip: s3c24xx: Fix function type for IRQCHIP_OF_DECLARE
  irqchip: mxs: Fix function type for IRQCHIP_OF_DECLARE

With that change,

Acked-by: Jason Cooper <jason@lakedaemon.net>

Or, if you like, I can apply these two to the branch I'm staging for
Thomas.  Either is fine with me.

thx,

Jason.
