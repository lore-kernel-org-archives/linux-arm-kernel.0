From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 10 Jul 2017 08:53:55 -0700
Subject: [PATCH 4/6] irqchip: brcmstb-l2: Remove some processing from the
 handler
In-Reply-To: <20170707192016.13001-5-opendmb@gmail.com>
References: <20170707192016.13001-1-opendmb@gmail.com>
 <20170707192016.13001-5-opendmb@gmail.com>
Message-ID: <3a27d1b1-23ca-3237-92ba-d91299448f33@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2017 12:20 PM, Doug Berger wrote:
> Saving the generic chip pointer in the brcmstb_l2_intc_data prevents
> the need to call irq_get_domain_generic_chip().  Also don't need to
> save parent_irq and base there since local variables in the
> brcmstb_l2_intc_of_init() function are just as good.
> 
> The handle_edge_irq flow or chained_irq_enter takes care of the
> acknowledgement of the interrupt so it is redundant to clear it in
> brcmstb_l2_intc_irq_handle().
> 
> irq_linear_revmap() is a fast path equivalent of irq_find_mapping()
> that is appropriate to use for domain controllers of this type.
> 
> Defining irq_mask_ack is slightly more efficient than just
> implementing irq_mask and irq_ack seperately.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
