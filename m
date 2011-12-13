From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Tue, 13 Dec 2011 01:15:31 +0100
Subject: [PATCH 01/10] GPIO: gpio-generic: Move initialization up to
 postcore
In-Reply-To: <20111212235544.GM32251@atomide.com>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <201112130044.02007.jkrzyszt@tis.icnet.pl>
 <20111212235544.GM32251@atomide.com>
Message-ID: <201112130115.31927.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 of December 2011 at 00:55:44, Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111212 15:13]:
> > On Tuesday 13 of December 2011 at 00:15:20, Tony Lindgren wrote:
> > > 
> > > Might be worth checking if some board specific __initcall helps here
> > > too?
> > 
> > If I only knew how I could insert a board specific __initcall between 
> > two points from where the generic-gpio first, then the 8250 driver, are 
> > called.
> > 
> > Any hints?
> 
> Hmm, can't you do all that in the order you want in
> ams_delta_modem_init()?  Or make that into a late_initcall so
> you have generic-gpio available?
> 
> It seems that the pieces of code you're talking about don't need
> to be initialized early, just needs to be done in the right
> order to get things working.

I think I've got it, thanks!
Janusz
