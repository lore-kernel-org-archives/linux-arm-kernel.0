From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2012 21:16:06 +0000
Subject: [PATCH 6/6] ARM: at91: add Shutdown Controller (SHDWC) DT support
In-Reply-To: <4F57BD04.5090002@gmail.com>
References: <20120302192844.GB21255@game.jcrosoft.org>
 <201203071849.36867.arnd@arndb.de> <4F57BD04.5090002@gmail.com>
Message-ID: <201203072116.07109.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012, Rob Herring wrote:
> > 
> > I still don't understand: Doesn't the property already give the information?
> > In general, you should try to encode these things in specific properties instead of
> > checking the compatible property.
> > 
> 
> Or vice-versa, the compatible properties distinguish things enough that
> the property is not needed. If it is fixed in the SOC design, then you
> should distinguish things with the compatible property.

Well, one of the two, basically. I would suggest using special properties
in order to be prepared when other SOCs have the same requirement. If you
know for certain that each one will only ever be needed in one specific
SOC, then the compatible property is enough, but if it's likely that others
will have the same requirement in the future, I think it's much better
to have just a single check rather than a list of SOCs.

	Arnd
