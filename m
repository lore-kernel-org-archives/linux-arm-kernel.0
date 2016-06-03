From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jun 2016 11:36:33 +0100
Subject: [PATCH] drm: convert DT component matching to
 component_match_add_release()
In-Reply-To: <20160603094048.GI23566@e106497-lin.cambridge.arm.com>
References: <E1b8jze-00046l-K5@rmk-PC.armlinux.org.uk>
 <20160603094048.GI23566@e106497-lin.cambridge.arm.com>
Message-ID: <20160603103633.GA1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 10:40:48AM +0100, Liviu Dudau wrote:
> On Fri, Jun 03, 2016 at 08:58:10AM +0100, Russell King wrote:
> > Convert DT component matching to use component_match_add_release().
> 
> Hi Russell,
> 
> Any reason for not keeping the component_match_add() calls in the drivers?

Sorry, I don't understand your comment.

If we kept component_match_add() in these drivers, then this patch
would not exist, because there wouldn't be any changes to the drivers.

> Planning to remove it?

Possibly in the longer term, but at the moment there are drivers where
the match data that is passed does not need any release functionality
eg, data allocated with devm_k*alloc(), or

	component_match_add(dev->parent, match, dss_component_compare, dev);

There are some new cases that need converting which have cropped up
during the last merge window, and I expect this to be an on-going
educational point for driver authors, so I'm not too bothered about
capturing all existing cases in this patch.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
