From: tony@atomide.com (Tony Lindgren)
Date: Tue, 25 Sep 2012 16:46:16 -0700
Subject: [RFC PATCH 0/3] ARM: use C pre-processor with dtc
In-Reply-To: <50620B5B.5020904@wwwdotorg.org>
References: <1348599998-2729-1-git-send-email-swarren@wwwdotorg.org>
 <1348601746.5565.18@snotra> <50620B5B.5020904@wwwdotorg.org>
Message-ID: <20120925234616.GE4840@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [120925 12:53]:
> On 09/25/2012 01:35 PM, Scott Wood wrote:
> > 
> > Do you have an example of where you'd actually benefit from this?  I'd
> > think most things could either be done reasonably well with what's built
> > into DTC (see what we've done in arch/powerpc/boot/dts/fsl), or would
> > need math expression support in DTC (or has that been added?).
> 
> Yes, support for basic integer math in cell values has indeed been
> recently added to upstream dtc. I don't believe this has been ported
> into the in-kernel dtc yet though.
> 
> The primary motivation here is probably naming constants and associated
> readability. For example, instead of:
> 
> nvidia,phy-reset-gpio = <&gpio 169 0>; /* gpio PV1 */
> 
> You could write:
> 
> nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO_PV1 0>;
> 
> No more opaque numbers!

This would be nice indeed.

Regards,

Tony
