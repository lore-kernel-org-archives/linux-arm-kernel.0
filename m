From: tony@atomide.com (Tony Lindgren)
Date: Thu, 1 Dec 2011 10:22:54 -0800
Subject: [PATCH 2a/5 v2] ARM: OMAP1: select clock rate by CPU type
In-Reply-To: <201112011110.11476.jkrzyszt@tis.icnet.pl>
References: <20111128174508.GO31337@atomide.com>
 <1322686675-26855-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <20111130222837.GR31337@atomide.com>
 <201112011110.11476.jkrzyszt@tis.icnet.pl>
Message-ID: <20111201182254.GU31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111201 01:35]:
> On Wednesday 30 of November 2011 at 23:28:38, Tony Lindgren wrote:
> > 
> > We should also now be able to remove all the CONFIG_OMAP_ARM_XXXMHZ options
> > too, right?
> 
> Right, but then, perhaps the initial version of patch 2a/5, which 
> already started removing them, from omap1_defconfig for now, then going 
> into the right direction while unblocking another regression fix (3/5), 
> _is_ a good candidate for an rc fix?

But we did not allow dpll1 reprogramming earlier either, so we should
not need to make all these changes during the -rc cycle. I'm suspecting
that we've had this same behaviour for a really long time, and we just
have not seen it as omap1_defconfig had OMAP_CLOCKS_SET_BY_BOOTLOADER
option set.

So I'm baffled how your board would be booting at a different rate
compared to v3.1, it seems that the logic has not changed there. Or
else we have some simple bug somewhere.

Care to try to verify at what point your system started booting at
60MHz rate?

Regards,

Tony
