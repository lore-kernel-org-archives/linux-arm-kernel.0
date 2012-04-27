From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Fri, 27 Apr 2012 10:04:32 +0200
Subject: [PATCH v10 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <D99582E5322435468A77E74BB0039E7B1D22784E8B@SRV02.hamburg.garz-fricke.de>
References: <D99582E5322435468A77E74BB0039E7B1D22784CF0@SRV02.hamburg.garz-fricke.de>
 <alpine.DEB.2.00.1204261035060.16439@gatekeeper.vosshq.de>
 <D99582E5322435468A77E74BB0039E7B1D22784E8B@SRV02.hamburg.garz-fricke.de>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D0905E0994A@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carsten,

Carsten Behling wrote on 2012-04-27:
>>  	INIT_COMPLETION(dev->cmd_complete);
>> +	dev->transfer_status = 0;
>>  	if (dev->msg->flags & I2C_M_RD) {
>>  		unsigned start_flags = AT91_TWI_START;
> 
> this patch will not work, because you reset 'dev->transfer_status'
> before it is evaluated on errors (AT91_TWI_NACK, AT91_TWI_OVRE). 

it should, because transfer_status is updated by the ISR between
wait_for_completion_interruptible_timeout() and the error evaluation.
Please try it out.

> > P.S. Are you using a RM9200? Seems that this SOC has some problems...
> 
> Yes, our ECO920 uses the RM9200, but we support it with an very old kernel
> (2.6.21). I remember there were many problems with I2C.

Ok, but good to hear the driver basically works with the RM9200.

Niko
