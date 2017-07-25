From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 25 Jul 2017 16:15:02 +0200
Subject: [PATCH v3] irqchip/tango: Don't use incorrect irq_mask_ack
 callback
In-Reply-To: <dddc01e3-b4f0-1f94-db6a-e3d4b31e6f4d@sigmadesigns.com>
References: <20170719190734.18566-1-opendmb@gmail.com>
 <20170719190734.18566-3-opendmb@gmail.com>
 <7a51555f-8191-9ebd-1f30-7c20f6db9d3f@sigmadesigns.com>
 <8d29fec9-35b8-c33b-3091-3e9a51c99ed7@gmail.com>
 <dddc01e3-b4f0-1f94-db6a-e3d4b31e6f4d@sigmadesigns.com>
Message-ID: <2928ba37-6bb9-1004-bc85-0c13ad513a2c@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/2017 15:08, Marc Gonzalez wrote:

> irq_gc_mask_disable_reg_and_ack() is not equivalent to
> irq_gc_mask_disable_reg() and irq_gc_ack_set_bit().
> 
> Leave the irq_mask_ack callback undefined, and let the irqchip
> framework use irq_mask and irq_ack instead.
> 
> Reported-by: Doug Berger <opendmb@gmail.com>
> Fixes: 4bba66899ac6 ("irqchip/tango: Add support for Sigma Designs SMP86xx/SMP87xx interrupt controller")
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> Cc: stable at vger.kernel.org

FWIW, the lockup reported in the thread below disappears
once the patch is applied.

https://lkml.org/lkml/2016/10/21/709

Regards.
