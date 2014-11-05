From: horms@verge.net.au (Simon Horman)
Date: Wed, 5 Nov 2014 13:04:16 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Clocks Updates for v3.19
In-Reply-To: <20141104223054.GB5908@quad.lixom.net>
References: <cover.1414558424.git.horms+renesas@verge.net.au>
 <20141104223054.GB5908@quad.lixom.net>
Message-ID: <20141105040416.GH32470@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 02:30:54PM -0800, Olof Johansson wrote:
> On Wed, Oct 29, 2014 at 01:58:17PM +0900, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC clocks updates for v3.19.
> > 
> > 
> > The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> > 
> >   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clocks-for-v3.19
> > 
> > for you to fetch changes up to 2b02b8020fad6ed505ff9cfb1b418c4b59f102a5:
> > 
> >   ARM: shmobile: r8a7740 legacy: Add missing INTCA clock for irqpin module (2014-10-24 10:30:50 +0900)
> > 
> > ----------------------------------------------------------------
> > Renesas ARM Based SoC Clocks Updates for v3.19
> > 
> > * Add missing INTCA clock for irqpin module on r8a7740
> > 
> > ----------------------------------------------------------------
> > Geert Uytterhoeven (1):
> >       ARM: shmobile: r8a7740 legacy: Add missing INTCA clock for irqpin module
> 
> Hi,
> 
> I'm trying to categorize this patch and it's hard. Is it a fix for a
> bug? Support for new firmware that doesn't enable this clock? How does
> the breakage show itself, and in what circumstances? Essentially, the
> patch description doesn't describe why it's needed and what it fixes.
> 
> Which means I don't know where to merge it to.

I believe that this fixes a problem that doesn't manifest.

It ensures that the clock required for the irqpin controller is available.
But as it is in practice the boot loader appears to make the clock
available and its been working due to that for several years. And I'm not
aware of anyone for whom it is not working without this patch.

My personal feeling is that you should just queue it up as a regular
non-bug-fix patch. Sorry for not making that clearer in the first place.
