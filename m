From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Oct 2015 23:40:06 -0700
Subject: [PATCH] ARM: OMAP2+: Fixed inverted OMAP_OFFOUT_EN
In-Reply-To: <1444308486-16204-1-git-send-email-benjamint@bsquare.com>
References: <1444308486-16204-1-git-send-email-benjamint@bsquare.com>
Message-ID: <20151009064005.GA23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ben Tucker <benjamint@bsquare.com> [151008 06:09]:
> The OFFOUTENABLE bit of the omap PADCONF registers is active low.
> The mux code assumed that it was active high and this patch fixes this
> problem.
> 
> Tested on an AM37x device.

Hmm what are the test cases you're using to validate this so
I can try to reproduce?

AFAIK because of erratum 1.158 for GPIO pins needing to be
muxed temporarly for input + pull + safe mode for off mode,
so I'm wondering in which cases the OFFOUTENABLE can be used.

I have a patch in works for 1.158 using gpio-ranges, and the
test case I'm using is the reset of WLAN that happens in off
mode as the enable GPIO glitches when returning from off mode.

Also.. I'm wondring why this has not been caught earlier?
Maybe because 1.158 is needed on omap3?

Regrds,

Tony
