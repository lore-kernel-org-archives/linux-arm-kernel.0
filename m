From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 17 Oct 2016 18:54:21 +0300
Subject: [PATCH v2] ARM: dts: exynos: Add entries for sound support on
 Odroid-XU board
In-Reply-To: <20160922184036.GA10000@kozik-lap>
References: <CGME20160916112217eucas1p1694395dda2a1e8cdf562007ed8141542@eucas1p1.samsung.com>
 <1474024920-32744-1-git-send-email-s.nawrocki@samsung.com>
 <f4d204d8-b6b8-5173-c530-bfea1ec9ed7d@samsung.com>
 <71286ef8-4b7f-cfde-7bb9-9f3bd2289527@samsung.com>
 <20160917200017.GA13666@kozik-lap>
 <5fef2bec-adcf-0230-cd00-7fc29cbbcd32@samsung.com>
 <20160922184036.GA10000@kozik-lap>
Message-ID: <20161017155421.GA11689@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 08:40:36PM +0200, Krzysztof Kozlowski wrote:
> On Mon, Sep 19, 2016 at 10:47:46AM +0200, Sylwester Nawrocki wrote:
> > On 09/17/2016 10:00 PM, Krzysztof Kozlowski wrote:
> > > On Fri, Sep 16, 2016 at 01:58:32PM +0200, Krzysztof Kozlowski wrote:
> > >> > On 09/16/2016 01:25 PM, Sylwester Nawrocki wrote:
> > >>> > > On 09/16/2016 01:22 PM, Sylwester Nawrocki wrote:
> > >>>> > >> This patch adds device nodes for the AUDSS clock controller,
> > >>>> > >> peripheral DMA 0/1 controllers and the Audio Subsystem I2S controller.
> > >>>> > >> These entries are required for sound support on Odroid-XU board.
> > >>>> > >>
> > >>>> > >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > >>>> > >> ---
> > >>>> > >> This patch depends on a patch adding clock ID macro definitions.
> > >>>> > >> I'm going to provide a topic branch containing required changes.
> > >>>> > >>
> > >>>> > >> Changes since v1:
> > >>>> > >>  - GIC_SPI, IRQ_TYPE_NONE used in the PDMA and max98080 interrupt
> > >>>> > >>    specifiers,
> > >>>> > >>  - assigned-clock-* properties moved to respective controller
> > >>>> > >>    nodes.
> > >>> > > 
> > >>> > > And here is a pull request containing clk dependency patches:
> > >>> > > 
> > >>> > > The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
> > >>> > > 
> > >>> > >   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
> > >>> > > 
> > >>> > > are available in the git repository at:
> > >>> > > 
> > >>> > >   git://linuxtv.org/snawrocki/samsung.git tags/clk-v4.9-exynos54x0-dt
> > >>> > > 
> > >>> > > for you to fetch changes up to 58d6506f327e3d192998ba03632f546da221b8d8:
> > >>> > > 
> > >>> > >   clk: samsung: exynos5410: Add clock IDs for PDMA and EPLL clocks (2016-09-09
> > >>> > > 10:13:02 +0200)
> > >>> > > 
> > >> > 
> > >> > Pulled and applied, thanks!
> > >
> > > This does not boot...
> > > http://www.krzk.eu/builders/boot-odroid-xu-exynos/builds/216
> > > http://www.krzk.eu/builders/boot-odroid-xu-multi_v7/builds/195
> > > 
> > > I am going to send pull request this weekend (or Monday) so probably this
> > > won't be included. If by any chance you prepare a fix soon, then it
> > > will save me from rebasing the branch.
> > 
> > Oops, indeed, I didn't test with just that part of clk changes applied.
> > The only resolution here I can see is to pull my whole clk branch,
> > it has already been pulled to the upstream clk tree.
> 
> Hmmmm, why the clock implementation is needed? Usually it should work
> without it. The driver will just handle ENODEV or DEFER... Maybe there
> is similar issue to the serial: e51e4d8a185d ("serial: samsung: Fix ERR
> pointer dereference on deferred probe")?
> 
> Anyway, the patch will wait till next window opens. I hope it will work
> then. :)
>

I re-applied the patch. However I do not have Odroid XU board anymore
(Samsung R&D Institute Poland was kind enough to provide XU and U3
boards to me this year... but I had to give it back :( ) so I cannot
verify that it works... If it does not, then Sylwester you owe me
another bottle of good whisky!


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
