From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Tue, 5 Sep 2017 08:11:34 +0200
Subject: [PATCH v2] clk: at91: utmi: set the mainck rate
In-Reply-To: <cc938b2c-1cb7-f7ad-1336-dbb01b2aec9c@gmx.de>
References: <20170904095226.29336-1-ludovic.desroches@microchip.com>
 <cc938b2c-1cb7-f7ad-1336-dbb01b2aec9c@gmx.de>
Message-ID: <20170905061134.f6n6jtvz57ycqd2f@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 04, 2017 at 07:53:57PM +0200, Ingo van Lil wrote:
> On 09/04/2017 11:52 AM, Ludovic Desroches wrote:
> 
> > +	/* SFR node missing is not necessarily an issue. */
> > +	regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
> > +	if (IS_ERR(regmap_sfr))
> > +		regmap_sfr = NULL;
> 
> What about SAMA5D3? That chip has an UTMICKTRIM register, too (SAMA5D4
> doesn't, though).

Oh Yes. I'll look for atmel,sama5d3-sfr too. Maybe there is a smarter
solution but I don't have it in mind.

> 
> Otherwise the patch looks good and works fine on both my boards (SAMA5D2
> 16MHz and SAMA5D3 12MHz).

Thanks for testing.

Regards

Ludovic
