From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Jan 2017 08:26:50 +0100
Subject: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <CAOAejn1HAU5spQeXmYPH4XH0L5bGuoFgguozwMp=uLKcXDEPEw@mail.gmail.com>
References: <20170111082208.vzu7xgpd4eakyldl@pengutronix.de>
 <CAOAejn2eOy2sn1VkE979ne23Sj9L6+kaQDNpL1EUKb2m=6sGXw@mail.gmail.com>
 <20170111153940.dtxzvtdici3r7l54@pengutronix.de>
 <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
 <20170112120309.fmrt2lwz3vklqmti@pengutronix.de>
 <CAOAejn289GLOSP-nPJnO_VpXLpyhTsF1bWQ7Ns9OfgPQCa8YTw@mail.gmail.com>
 <20170112174902.j52foglkdouyz36n@pengutronix.de>
 <CAOAejn3tPi0fjy+t-UhMTvAq7LfdKJJdbcLw2su1-YAGDZMxew@mail.gmail.com>
 <20170112211004.z3wylc7vrubulc3x@pengutronix.de>
 <CAOAejn1HAU5spQeXmYPH4XH0L5bGuoFgguozwMp=uLKcXDEPEw@mail.gmail.com>
Message-ID: <20170113072650.orx6vl2orqfakcuk@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jan 12, 2017 at 10:28:20PM +0100, M'boumba Cedric Madianga wrote:
> Please see below a quote from datasheet that clearly described how to handle
> For 2-byte reception:
> ? Wait until ADDR = 1 (SCL stretched low until the ADDR flag is cleared)
> ? Set ACK low, set POS high
> ? Clear ADDR flag
> ? Wait until BTF = 1 (Data 1 in DR, Data2 in shift register, SCL
> stretched low until a data1 is read)
> ? Set STOP high
> ? Read data 1 and 2

The problem is that you only know that you have a 2 byte transfer after
you read the first byte (and it's a 1). (But note that this is
irrelevant for the patch as the driver doesn't claim to support this
kind of transfer.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
