From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 11:55:39 +0200
Subject: [PATCH v15 06/12] document: dt: add the binding on HiP04 clock
In-Reply-To: <CAD6h2NS4GqxyFBE0+nq6Phxy0j6J74M5+N5DOEPSOYfB4+7Wxg@mail.gmail.com>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <20140728175418.GD2576@leverpostej>
 <CAD6h2NS4GqxyFBE0+nq6Phxy0j6J74M5+N5DOEPSOYfB4+7Wxg@mail.gmail.com>
Message-ID: <2049238.Bp7AxcFkea@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 July 2014 10:25:49 Haojian Zhuang wrote:
> On 29 July 2014 01:54, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Jul 28, 2014 at 02:57:50PM +0100, Haojian Zhuang wrote:
> >> The DT binding for Hisilicon HiP04 clock driver.
> >>
> >> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> >> ---
> >>  .../devicetree/bindings/clock/hip04-clock.txt        | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/hip04-clock.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/hip04-clock.txt b/Documentation/devicetree/bindings/clock/hip04-clock.txt
> >> new file mode 100644
> >> index 0000000..4d31ae3
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/hip04-clock.txt
> >> @@ -0,0 +1,20 @@
> >> +* Hisilicon HiP04 Clock Controller
> >> +
> >> +The HiP04 clock controller generates and supplies clock to various
> >> +controllers within the HiP04 SoC.
> >> +
> >> +Required Properties:
> >> +
> >> +- compatible: should be one of the following.
> >> +  - "hisilicon,hip04-clock" - controller compatible with HiP04 SoC.
> >
> > There's only one clock controller on-board and it's custom for HiP04?
> >
> 
> Since all those PLL settings are configured in bootloader, kernel
> don't need to configure it again.
> 
> By the way, I don't have the manual to configure those PLLs. All the clocks
> are defined as fixed in kernel side.
> 

If all the clocks are fixed-rate, you don't actually need a driver
for them, just use the regular fixed-rate clock and define one
node per clock.

	Arnd
