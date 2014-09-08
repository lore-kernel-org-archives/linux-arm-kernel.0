From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 8 Sep 2014 11:26:42 +0200
Subject: [GIT PULL] at91: drivers for 3.18 #2
In-Reply-To: <201409052325.11709.arnd@arndb.de>
References: <1409934969-11584-1-git-send-email-nicolas.ferre@atmel.com>
 <201409052325.11709.arnd@arndb.de>
Message-ID: <20140908092642.GB20883@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Sep 05, 2014 at 11:25:11PM +0200, Arnd Bergmann wrote:
> On Friday 05 September 2014, Nicolas Ferre wrote:
> > Arnd, Olof, Kevin,
> > 
> > This pull-request is focused on the work that Maxime did for migrating our timer
> > (PIT) to the clocksource sub-system. A big cleanup happened which allows us to
> > be even closer to the point when we have only the bare minimum in our formerly
> > crowded mach-at91 directory.
> > 
> > This pull-request goes on top of the "drivers" one already sent to you on Sept.
> > 01st.
> 
> Hmm, I'm not too happy to see more uses of early_platform_*, I was hoping
> we could kill that off in the long run. This is only used for the legacy
> board files, not for DT, right?

Yes, the DT uses the usual CLOCKSOURCE_OF_DECLARE mechanism.

I wasn't aware that early_platform drivers were in the killzone, but
I'm definitely aware that global custom exported functions are, hence
why I went this way.

> Do you have a timeline for getting rid of the board files completely?

I don't, but it would be great if we could kill these in the next
couple releases.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140908/5a2806c9/attachment.sig>
