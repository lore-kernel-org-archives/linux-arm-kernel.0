From: stigge@antcom.de (Roland Stigge)
Date: Sun, 11 Mar 2012 11:16:43 +0100
Subject: [PATCH v5 3/3] USB: ohci-nxp: Support for LPC32xx
In-Reply-To: <20120311074323.GA30894@pengutronix.de>
References: <1331408166-11607-1-git-send-email-stigge@antcom.de>
 <1331408166-11607-4-git-send-email-stigge@antcom.de>
 <20120310204955.GA14564@pengutronix.de> <4F5BD5BE.3000808@antcom.de>
 <20120311074323.GA30894@pengutronix.de>
Message-ID: <4F5C7B8B.7050508@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/03/12 08:43, Wolfram Sang wrote:
>>> And while we are at it: Could you also try replacing
>>> i2c_write() with i2c_smbus_write_byte_data(isp1301_i2c_client,
>>> reg, val)?
>> 
>> Interestingly now, replacing i2c_write() calls with 
>> i2c_smbus_write_byte_data() did _not_ work (hardware
>> initialization failure). I guess this is due to the differences
>> between i2c and smbus, and the hardware only handles the former
>> correctly?
> 
> Did you take into consideration that the smbus-call has (client,
> reg, val) as arguments while i2c_write has (val, reg), that is you
> have to swap the arguments?

Yes, that's it! :-)

I'll update my patch to not use i2c_write() anymore.

For the remaining i2c_write() in the current kernel driver, I will
include an additional patch to remove it completely in favour of
i2c_smbus_write_byte_data().

Thanks,

Roland
