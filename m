From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 11 Feb 2015 19:11:42 +0100
Subject: [PATCHv6 2/2] INPUT: Introduce generic trigger/LED pairs to
 input LEDs
In-Reply-To: <20150210221105.GC26472@dtor-ws>
References: <20150123122814.GB18514@type.bordeaux.inria.fr>
 <20150210221105.GC26472@dtor-ws>
Message-ID: <20150211181142.GA29636@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2015-02-10 14:11:05, Dmitry Torokhov wrote:
> Hi Samuel,
> 
> On Fri, Jan 23, 2015 at 01:28:14PM +0100, Samuel Thibault wrote:
> > This permits to reassign input LEDs to something else than keyboard "leds"
> > state, by adding a trigger and a led for each input leds, the former being
> > triggered by EV_LED events, and the latter being by default triggered by the
> > former. The user can then make the LED use another trigger, including other LED
> > triggers of the same keyboard.
> > 
> > The hardware LEDs are now not actioned from the EV_LED event any more, but from
> > the per-device LED layer.
> > 
> > [ebroder at mokafive.com: Rebased to 3.2-rc1 or so, cleaned up some includes, and fixed some constants]
> > [akpm at linux-foundation.org: remove unneeded `extern', fix comment layout]
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > Signed-off-by: Evan Broder <evan@ebroder.net>
> > Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> > Signed-off-by: John Crispin <blogic@openwrt.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > Changed in this version:
> > - use drvdata instead of platform_data
> > - dropped CONFIG_INPUT_LEDS option
> > - compacted leds and triggers array allocation
> > - handle registration failure
> 
> This did not make the first batch, but I will try to get it into the
> 2nd.
> 
> Pavel, have you tried this version?

Not really, busy with other stuff, sorry. I promise to test -next once
it hits it :-).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
