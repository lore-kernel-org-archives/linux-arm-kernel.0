From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 15:13:07 +0100
Subject: [PATCH 06/19] ARM: mach-at91: remove arch specific special
	handling for ioremap
In-Reply-To: <20110919130703.GG16141@game.jcrosoft.org>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-7-git-send-email-nico@fluxnic.net>
	<20110919130703.GG16141@game.jcrosoft.org>
Message-ID: <20110919141307.GS16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 03:35:47PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 03:07 Fri 16 Sep     , Nicolas Pitre wrote:
> > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > 
> > A generic version should replace this later.
> > 
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Untill the replace will availlable
> 
> do not remove it

This patch series is all about adding that replacement.

But yes, as a general point of principle, the replacement should be
in place before the old stuff is pulled out.  I don't see any reason
why that can't be the case, because __arm_ioremap() can be rigged up
to use the static mappings first, and then the individual platform
interception of ioremap() can be removed afterwards.
