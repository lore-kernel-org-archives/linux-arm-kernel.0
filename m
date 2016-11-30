From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 30 Nov 2016 16:49:38 +0100
Subject: [PATCH v6 1/4] i2c: pxa: Add definition of fast and high speed
 modes via the regs layout
In-Reply-To: <20161130140017.26307-2-romain.perier@free-electrons.com>
References: <20161130140017.26307-1-romain.perier@free-electrons.com>
 <20161130140017.26307-2-romain.perier@free-electrons.com>
Message-ID: <20161130164938.32ba768f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 30 Nov 2016 15:00:14 +0100, Romain Perier wrote:

>  #ifdef CONFIG_I2C_PXA_SLAVE
>  	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
> @@ -1234,6 +1238,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  	i2c->reg_idbr = i2c->reg_base + pxa_reg_layout[i2c_type].idbr;
>  	i2c->reg_icr = i2c->reg_base + pxa_reg_layout[i2c_type].icr;
>  	i2c->reg_isr = i2c->reg_base + pxa_reg_layout[i2c_type].isr;
> +	i2c->fm_mask = pxa_reg_layout[i2c_type].fm ? pxa_reg_layout[i2c_type].fm : ICR_FM;
> +	i2c->hs_mask = pxa_reg_layout[i2c_type].hs ? pxa_reg_layout[i2c_type].hs : ICR_HS;

These lines are too long according to checkpatch. What about using what
Wolfram originally suggested, i.e:

	i2c->fm_mask = pxa_reg_layout[i2c_type].fm ?: ICR_FM;

which does exactly the same, but fits within 80 characters ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
