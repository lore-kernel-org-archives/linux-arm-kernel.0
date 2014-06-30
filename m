From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jun 2014 12:35:39 +0100
Subject: [PATCH v5 05/14] clk: Add generic driver for Maxim PMIC clocks
In-Reply-To: <53B142F1.1050407@collabora.co.uk>
References: <1403806546-31122-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403806546-31122-6-git-send-email-javier.martinez@collabora.co.uk>
 <CAKew6eU5X=WxhECtwUUwbXe_fCRU4bD6B7caWiA2dwcBfThd-g@mail.gmail.com>
 <53B142F1.1050407@collabora.co.uk>
Message-ID: <20140630113539.GX32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 12:58:57PM +0200, Javier Martinez Canillas wrote:
> >> +       if (!max_gen->lookup)
> >> +               return ERR_PTR(-ENOMEM);
> >> +
> >> +       max_gen->lookup->con_id = hw->init->name;
> > 
> > Also IMO,  init->name should be over-written if name is provided in DT,
> > otherwise generic "clock-output-names" property will go futile,
> > perhaps it should be done before clk_register.
> > 
> 
> Even though Documentation/devicetree/bindings/clock/clock-bindings.txt says that
> the "clock-output-names" property is optional I agree with you that will be
> better to support it. So I'll add it on the next version as well.

However, remember that con_id is the _DEVICE_ specific connection name,
not the _CLOCK_ name.  You will get a NAK from me if you violate this
rule.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
