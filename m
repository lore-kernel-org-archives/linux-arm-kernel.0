From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 07 Mar 2018 15:23:30 +0100
Subject: [PATCH] mtd: nand: marvell: Fix clock resource by adding a
 register clock
In-Reply-To: <20180306134311.7bbf8ce7@bbrezillon> (Boris Brezillon's message
 of "Tue, 6 Mar 2018 13:43:11 +0100")
References: <20180228143553.12485-1-gregory.clement@bootlin.com>
 <20180301183520.4251439a@bbrezillon> <874llt5ut2.fsf@bootlin.com>
 <20180306134311.7bbf8ce7@bbrezillon>
Message-ID: <87woyo3qxp.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,
 
 On mar., mars 06 2018, Boris Brezillon <boris.brezillon@bootlin.com> wrote:

>> >
>> > Another solution would be to retrieve the reg clk only on platforms
>> > that need it (based on the compatible). This way you won't have to test
>> > for -ENOENT and could simply propagate the error to the upper layer.  
>> 
>> We can't do this because we need to be bacwkard compatible.
>
> I don't get it. If the clock is missing in the DT, the NAND is
> already not working on these platforms, right? How could we break
> something that is already broken?

As you probably know this patch have been tested on an Armada 7K based
board, so it more or less works.

But it works because the second clock used by the nand controller is
also used by other IP and already setup by the drivers of these IP. So
today it is only if you boot a kernel without crypto, i2c, spi and uart
support that the nand won't work.

Then the current representation is wrong, but it is still usable in most
of the case. So that's why we still need to support the case where we
have only one clock in the device tree.

Gregory


>
> Regards,
>
> Boris
>
> -- 
> Boris Brezillon, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
