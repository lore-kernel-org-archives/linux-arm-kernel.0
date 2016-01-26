From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Jan 2016 16:41:28 +0100
Subject: [PATCH 2/4] irqchip: irq-armada-370-xp: use the generic MSI
 infrastructure
In-Reply-To: <87si2te6pk.fsf@free-electrons.com>
References: <1450707546-15060-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1450707546-15060-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <87si2te6pk.fsf@free-electrons.com>
Message-ID: <20160126164128.68d007f8@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

On Wed, 23 Dec 2015 12:37:43 +0100, Gregory CLEMENT wrote:

> > -	mutex_unlock(&msi_used_lock);
> > +	msg->address_lo = lower_32_bits(msi_doorbell_addr);
> > +	msg->address_hi = upper_32_bits(msi_doorbell_addr);
> > +	msg->data = 0xf00 | (data->hwirq + PCI_MSI_DOORBELL_START);
> 
> So here instead of using the 16 value you use PCI_MSI_DOORBELL_START
> which seems better. What about using it also in
> armada_370_xp_handle_msi_irq?

Good idea, I've fixed this. Since it's not related to the conversion to
the generic MSI infrastructure, I made this change as part of a
separate commit (this one is already quite difficult to read as a
patch, as you noted).

Thanks for the feedback!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
