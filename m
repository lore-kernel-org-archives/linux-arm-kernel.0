From: Ben.Whitten@lairdtech.com (Ben Whitten)
Date: Wed, 4 Jul 2018 13:41:42 +0000
Subject: [RFC net-next 15/15] net: lora: Add Semtech SX1301
In-Reply-To: <20180704114355.GB11693@sirena.org.uk>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
 <20180703153137.GB13744@sirena.org.uk>
 <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
 <20180704114355.GB11693@sirena.org.uk>
Message-ID: <BY1PR02MB1114BC0F12654B1E7C614108E7410@BY1PR02MB1114.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
> 
> On Tue, Jul 03, 2018 at 06:40:41PM +0200, Andreas F?rber wrote:
> 
> > Do you have an alternative solution for abstraction? A regmap would seem
> > to require putting everything into a monolithic SX1301 driver despite
> > those connected chipsets actually being regular, external SPI chips that
> > could also be attached to non-SX1301 SPI masters.
> 
> I'm suggesting a regmap for those external SPI chips.  It doesn't matter
> what the host uses.

Currently in my testing drivers I have used regmap for both the SX1301 and the downstream SX1257.
In my SX1257 driver currently the regmap is backed via SPI with devm_regmap_init_spi, please correct me if I am wrong but if I understand correctly this could be split out to regmap backed by SPI in the case of a direct host connection, and a regmap backed by the SX1301's regmapped strobing register interface, regmap_bus?
Is there a precedent to this I can examine?
