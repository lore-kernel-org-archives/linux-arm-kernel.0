From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Sep 2011 11:12:45 -0400 (EDT)
Subject: [PATCH 06/19] ARM: mach-at91: remove arch specific special
	handling for ioremap
In-Reply-To: <20110919141307.GS16381@n2100.arm.linux.org.uk>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-7-git-send-email-nico@fluxnic.net>
	<20110919130703.GG16141@game.jcrosoft.org>
	<20110919141307.GS16381@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1109191109330.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Sep 2011, Russell King - ARM Linux wrote:

> On Mon, Sep 19, 2011 at 03:35:47PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 03:07 Fri 16 Sep     , Nicolas Pitre wrote:
> > > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > 
> > > A generic version should replace this later.
> > > 
> > > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Untill the replace will availlable
> > 
> > do not remove it
> 
> This patch series is all about adding that replacement.
> 
> But yes, as a general point of principle, the replacement should be
> in place before the old stuff is pulled out.  I don't see any reason
> why that can't be the case, because __arm_ioremap() can be rigged up
> to use the static mappings first, and then the individual platform
> interception of ioremap() can be removed afterwards.

Some of them were using IOREMAP_END assuming it was below the static 
mappings, so it was easier to simply remove those first before the 
IOREMAP_END was redefined.  And then it looks strange to remove some of 
them before, then some others after.  Hence I opted for removing them 
all first.  And as I said, this doesn't create any functional 
regression to have this optimization removed temporarily.


Nicolas
