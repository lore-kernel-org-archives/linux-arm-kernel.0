From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Wed, 23 Nov 2011 15:34:42 +0100
Subject: [PATCH v5 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <D99582E5322435468A77E74BB0039E7B1D1655C047@SRV02.hamburg.garz-fricke.de>
References: <D99582E5322435468A77E74BB0039E7B1D1655BF4D@SRV02.hamburg.garz-fricke.de>
 <EF2E73589CA71846A15D0B2CDF79505D087B40D16B@wm021.weinmann.com>
 <D99582E5322435468A77E74BB0039E7B1D1655BFBB@SRV02.hamburg.garz-fricke.de>
 <EF2E73589CA71846A15D0B2CDF79505D087B40D349@wm021.weinmann.com>
 <D99582E5322435468A77E74BB0039E7B1D1655C047@SRV02.hamburg.garz-fricke.de>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B44FC83@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carsten,

Carsten Behling wrote on 2011-11-23:
> I think it must be:
> 
> +		for (i = 0; i < msg->len; ++i) {
> +			internal_address |= ((unsigned)msg->buf[msg->len-1-i]) << (8 * i);
> +			int_addr_flag += AT91_TWI_IADRSZ_1;
> +		}
> +		at91_twi_write(dev, AT91_TWI_IADR, internal_address);

yes, I think you're right. I tested only with 8 bit addresses
(msg->len = 1), so I haven't seen this error.

I will modify the patch and post it later today.

Thanks for this feedback,
Niko
