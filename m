From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Sep 2014 08:52:22 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Soc Updates for
 v3.18
In-Reply-To: <4196537.hvL3OIMxQq@wuerfel>
References: <cover.1410235571.git.horms+renesas@verge.net.au>
 <4196537.hvL3OIMxQq@wuerfel>
Message-ID: <20140909235222.GC16682@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 05:20:11PM +0200, Arnd Bergmann wrote:
> On Tuesday 09 September 2014 13:22:17 Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these third round of Renesas ARM based SoC soc updates for v3.18.
> > 
> > This pull request is based on the previous round of
> > such requests, tagged as renesas-soc2-for-v3.18,
> > which you have already pulled.
> > 
> > This pull-request has a minor conflict with
> > "[GIT PULL] Renesas ARM Based SoC Kconfig Cleanups for v3.18",
> > tagged as renesas-kconfig-cleanups-for-v3.18, which you
> > have previously pulled.
> 
> Pulled into next/soc as well. One detail I noticed for the first time is
> that the setup-*.c file hides the machine descriptor inside of #ifdef
> CONFIG_USE_OF, which makes no sense since the file is only compiled
> when ARCH_MULTIPLATFORM is set, and that does 'select USE_OF'.
> It would be better not to add that #ifdef for new files, and you
> could perhaps remove the existing ones after the conversion to
> multiplatform is complete.

Thanks Arnd, you make a good point.
I'll see about cleaning that up.
