From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 May 2015 22:22:07 +0800
Subject: [PATCH v2 0/7] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
In-Reply-To: <CAHrpEqS5gAsu6=ut-mPwZiipqKJb=VicRooCPFhEf324kuhnDQ@mail.gmail.com>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
 <20150520015851.GB1071@dragon>
 <CAHrpEqS5gAsu6=ut-mPwZiipqKJb=VicRooCPFhEf324kuhnDQ@mail.gmail.com>
Message-ID: <20150520142205.GA24844@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 09:44:46PM -0500, Zhi Li wrote:
> On Tue, May 19, 2015 at 8:58 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Wed, May 20, 2015 at 01:04:35AM +0800, Frank.Li at freescale.com wrote:
> >> From: Frank Li <Frank.Li@freescale.com>
> >>
> >> Change from v1 to v2
> >>  - Change simple-bus to simple-mfd
> >>  - RTC remove lock.
> >>  - RTC remove comments "These register offsets are relative to LP (Low Power) range"
> >>  - power off, remove extra space
> >>
> >> SNVS is MPF module.
> >> include rtc, power off, ON/OFF power key
> >>
> >>   arm: imx: power-off: change to syscon to access register
> >>   rtc: arm: imx: snvs: change use syscon to access register
> >> Above two patch change existed power-off and rtc use syscon
> >>
> >>   Document: dt: fsl: snvs: change support syscon
> >>   arm: dts: imx: update snvs to use syscon access register
> >> Update dt file and document
> >>
> >>   input: keyboard: imx: add snvs power key driver
> >>   document: devicetree: input: imx: i.mx snvs power device tree bindings
> >>   arm: dts: imx6sx: enable snvs power key
> >> Added on/off key driver
> >>
> >> Frank Li (6):
> >>   arm: imx: power-off: change to syscon to access register
> >>   rtc: arm: imx: snvs: change use syscon to access register
> >>   Document: dt: fsl: snvs: change support syscon
> >>   arm: dts: imx: update snvs to use syscon access register
> >>   document: devicetree: input: imx: i.mx snvs power device tree bindings
> >>   arm: dts: imx6sx: enable snvs power key
> >
> > So, the series will break existing DTBs for RTC and poweroff, right?
> > If this is unavoidable, should we at least have some warning messages
> > telling users about his breakage?
> 
> How to do that?
> Just added it commit message or need runtime warning?

runtime, so that users can know why their installed DTBs break with the
new kernel.

Shawn
