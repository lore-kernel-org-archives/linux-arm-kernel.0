From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 15 Dec 2010 07:53:30 -0700 (MST)
Subject: [PATCH] OMAP: omap_device: use pdev as parameter to get rt_va
In-Reply-To: <20101215085646.GA5222@n2100.arm.linux.org.uk>
References: <1292024742-27319-1-git-send-email-omar.ramirez@ti.com>
	<4D05D586.6090408@ti.com>
	<AANLkTik667cW19eCVNNLf3_dc9efFYms0H2z-fGU24Ob@mail.gmail.com>
	<alpine.DEB.2.00.1012141710260.15971@utopia.booyaka.com>
	<20101215085646.GA5222@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1012150750460.15971@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Dec 2010, Russell King - ARM Linux wrote:

> No it doesn't - this is not a valid reason to bugger about with drivers
> to make them non-standard.
> 
> omap_ioremap() can be improved to retain its re-use of static mappings
> by having some kind of tree structure or something like that - ioremap
> is after all not a performance critical path.  There's no need to start
> passing virtual addresses to drivers.

OK, that's the approach we'll take then, when or if that needs to happen.

Omar, please ignore my earlier post and just call ioremap() directly from 
your driver code.


- Paul
