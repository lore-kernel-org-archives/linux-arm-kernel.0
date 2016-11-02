From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 Nov 2016 14:15:50 +0100
Subject: [PATCH 1/3] ipmi/bt-bmc: change compatible node to 'aspeed,
 ast2400-ibt-bmc'
In-Reply-To: <1478073426-3714-2-git-send-email-clg@kaod.org>
References: <1478073426-3714-1-git-send-email-clg@kaod.org>
 <1478073426-3714-2-git-send-email-clg@kaod.org>
Message-ID: <201611021415.51081.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 November 2016, C?dric Le Goater wrote:
> The Aspeed SoCs have two BT interfaces : one is IPMI compliant and the
> other is H8S/2168 compliant.
> 
> The current ipmi/bt-bmc driver implements the IPMI version and we
> should reflect its nature in the compatible node name using
> 'aspeed,ast2400-ibt-bmc' instead of 'aspeed,ast2400-bt-bmc'. The
> latter should be used for a H8S interface driver if it is implemented
> one day.
> 
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

We generally try to avoid changing the compatible strings after the
fact, but it's probably ok in this case.

I don't understand who decides which of the two interfaces is used:
is it the same register set that can be driven by either one or the
other driver, or do you expect to have two drivers that can both
be active in the same system and talk to different hardware once
you get there?

If the first one of these is true, it seems a little awkward to
use the DT compatible string to decide which driver to use rather
than making the decision in the OS.

	Arnd
