From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Feb 2014 10:42:48 +0000
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <201401281148.10670.arnd@arndb.de>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <52E700F0.7040708@gmail.com>
 <CAPDyKFpOhQtiyCmzie3=sfg42Vv5_rReRNgUf8kALoE6TBe2cw@mail.gmail.com>
 <201401281148.10670.arnd@arndb.de>
Message-ID: <20140213104248.GU26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 11:48:10AM +0100, Arnd Bergmann wrote:
> I think there is another option, which does have its own pros and cons:
> We could move all the power handling back into the sdio function driver
> if we allow a secondary detection path using DT rather than the probing
> of the SDIO bus.

No thanks.

What if we have a platform where things subtly change, like for instance,
the wiring on the SD slot to fix a problem with UHS-1 cards, which means
you don't have UHS-1 support for some platforms but do for others.

What if you have a platform which uses a brcm4329 chip for Wifi, but then
later in the production run switch to using a different Wifi chipset?

With this information encoded into DT, the number of DT files quickly
increases, and then this presents its own problem - how do users get to
know which DT file should be used for their platform when all they see
externally is "a product of type A"?

Let's say that the board folk were kind enough to set some kind of
identifing feature for the first but not the second (why would they,
it's probe-able, damn it).

The "we can do it in DT" approach just makes things unnecessarily more
difficult from the _user_ and _hardware_ point of view.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
