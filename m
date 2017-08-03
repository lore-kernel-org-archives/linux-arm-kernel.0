From: peda@axentia.se (Peter Rosin)
Date: Thu, 3 Aug 2017 16:22:33 +0200
Subject: Compatibles for i2c muxes nxp,pca954x and ti,tca954x
In-Reply-To: <20170803134401.GG15018@lunn.ch>
References: <62519d0b-0b7b-9124-8481-9ef8de24eaf6@axentia.se>
 <20170803134401.GG15018@lunn.ch>
Message-ID: <0103c2cc-ca1d-a2c1-347a-dd64f2492112@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-08-03 15:44, Andrew Lunn wrote:
> On Thu, Aug 03, 2017 at 12:00:27PM +0200, Peter Rosin wrote:
>> Hi!
>>
>> Texas has apparently made copies for some of the NXP devices
>> handled by the drivers/i2c/muxes/i2c-mux-pca954x.c driver.
> 
> This happens a lot in the i2c space. Look at all the at24 EEPROM
> clones. Yet they all use the same compatible string.

Errhm, no they don't. Hint, try

$ git grep 'compatible.*,24c'

There are all sorts of manufacturers in use.

atmel, microchip, onsemi, st, etc.

There are also "bad" manufacturers such as 'at,24c64' and "bad"
parts such as 'atmel,at24c16'. It's a mess.

Anyway, the only reason that ever works is because of loose
matching by the i2c core (it falls back to ignoring the
manufacturer or something like that, but I'm not sure about
the exact details). IIUC there is ongoing work to get rid of
that loose matching, and adding more of it is not the way
forward.

Cheers,
peda
