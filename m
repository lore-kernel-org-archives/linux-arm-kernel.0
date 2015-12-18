From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 10:06:48 +0100
Subject: I2C eeprom compatibles? (was Re: [PATCH/RFC 03/19] ARM: shmobile:
 gose: add i2c2 bus to device tree)
In-Reply-To: <20151218073531.GA1517@katana>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <20151218030239.GB10973@verge.net.au> <20151218073531.GA1517@katana>
Message-ID: <1839177.77Qt0RnI3v@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 December 2015 08:35:32 Wolfram Sang wrote:
> > 
> > It seems to me that we have some consensus around:
> > 
> >       compatible = "renesas,r1ex24002", "24c02";
> 
> Thinking again, "generic,24c02" or "generic-24c02" could also be an
> option.
> 
> > Should this be added to Documentation/devicetree/bindings/eeprom/eeprom.txt ?
> > Or documented elsewhere?
> 
> Probably we need a DT maintainers advice here? I don't mind vendor
> specific compatibles being documented, but I'm reluctant to add all
> these compatibles for the myriads of I2C eeproms to the at24 driver. 99%
> are covered by the generic case.
> 
> Adding DT to CC.

I'd rather use some vendor string in addition to 24c02. Isn't this originally
an Atmel part? In that case, using "atmel,24c02" as the most generic string
would be appropriate, and IIRC the i2c framework will just match that with
the "24c02" entry in the i2c_device_id list.

	Arnd
