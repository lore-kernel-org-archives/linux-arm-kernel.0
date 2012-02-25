From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 25 Feb 2012 12:12:17 +0000
Subject: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
In-Reply-To: <20120225114414.GC3167@opensource.wolfsonmicro.com>
References: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <20120224140200.GH5450@opensource.wolfsonmicro.com>
 <20120224142342.GA16659@S2101-09.ap.freescale.net>
 <20120224141705.GJ5450@opensource.wolfsonmicro.com>
 <20120224232148.GA24268@S2101-09.ap.freescale.net>
 <4F4819C4.5040709@freescale.com>
 <20120225000319.GC24268@S2101-09.ap.freescale.net>
 <4F483BB8.7030706@freescale.com>
 <20120225101758.GJ22562@n2100.arm.linux.org.uk>
 <20120225114414.GC3167@opensource.wolfsonmicro.com>
Message-ID: <20120225121217.GK22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2012 at 11:44:15AM +0000, Mark Brown wrote:
> On Sat, Feb 25, 2012 at 10:17:58AM +0000, Russell King - ARM Linux wrote:
> > On Sat, Feb 25, 2012 at 01:39:05AM +0000, Tabi Timur-B04825 wrote:
> 
> > > That's not what Mark is talking about.  You somehow posted patch 0/6 as a 
> > > reply to the *previous* patchset, so the two patchsets were merged into 
> > > one email thread.
> 
> > Sorry, you and Mark are not listening to Shawn.  Even worse, you're
> > telling Shawn that what he's trying to explain to you is not the point
> > when it is actually the whole point.
> 
> > The "[PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl" was posted as a
> > follow-up to "[PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ".
> 
> > So, the "*previous* patchset" _was_ "[PATCH 1/4] ASoC: imx: let
> > SND_MXC_SOC_FIQ select FIQ" and not some other random patch set.  That
> > is a fundamental fact, which can't be argued.  Anyone can verify it, and
> > it can be verified by checking the email headers.
> 
> No, I get that it's a new version of the same patch set rather than a
> totally unrelated patch set that was followed up to - I'd still rather
> it weren't posted like that as the threading ends up being less helpful
> than is desirable.

Take a look at the diffstat, and you'll see that there's no way that it's
a "new version of the same patch set".  Tell me, how can the set of six
patches be a new version of the previous set of four patches when the
previous set of four patches moves a bunch of files and the following set
of six patches does not?

And if you bother to read Shawn's reply to your question, you'll see that
the whole reason he grouped the two together is because they follow on
from each other.

Here's the diffstats from his emails from the interlinked thread:

[PATCH 1/4] ASoC: imx: add an explicit Kconfig option for imx-ssi driver
 sound/soc/imx/Kconfig  |    7 +++++++
 sound/soc/imx/Makefile |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

[PATCH 2/4] ASoC: fsl: separate SSI and DMA Kconfig options
 sound/soc/fsl/Kconfig  |   15 +++++++++------
 sound/soc/fsl/Makefile |    3 ++-
 2 files changed, 11 insertions(+), 7 deletions(-)

[PATCH 3/4] ASoC: imx: merge sound/soc/imx into sound/soc/fsl
 sound/soc/Kconfig                        |    1 -
 sound/soc/Makefile                       |    1 -
 sound/soc/fsl/Kconfig                    |   84 ++++++++++++++++++++++++++++++
 sound/soc/fsl/Makefile                   |   19 +++++++
 sound/soc/{imx => fsl}/eukrea-tlv320.c   |    2 +-
 sound/soc/{imx => fsl}/imx-pcm-dma-mx2.c |    0
 sound/soc/{imx => fsl}/imx-pcm-fiq.c     |    0
 sound/soc/{imx => fsl}/imx-pcm.c         |    0
 sound/soc/{imx => fsl}/imx-pcm.h         |    0
 sound/soc/{imx => fsl}/imx-ssi.c         |    2 +-
 sound/soc/{imx => fsl}/imx-ssi.h         |    0
 sound/soc/{imx => fsl}/mx27vis-aic32x4.c |    0
 sound/soc/{imx => fsl}/imx-ssi.h         |    0
 sound/soc/{imx => fsl}/mx27vis-aic32x4.c |    0
 sound/soc/{imx => fsl}/phycore-ac97.c    |    0
 sound/soc/{imx => fsl}/wm1133-ev1.c      |    0
 sound/soc/imx/Kconfig                    |   71 -------------------------
 sound/soc/imx/Makefile                   |   19 -------
 16 files changed, 105 insertions(+), 94 deletions(-)

[PATCH 4/4] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
 sound/soc/fsl/fsl_ssi.c |   75 ++++++++++++++++++++++++++++------------------

[PATCH 1/6] ASoC: fsl: correct get_dma_channel parameter name
 sound/soc/fsl/mpc8610_hpcd.c |    4 ++--
 sound/soc/fsl/p1022_ds.c     |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

[PATCH 2/6] ASoC: fsl: align mpc8610_hpcd with p1022_ds on getting codec node
 sound/soc/fsl/mpc8610_hpcd.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

[PATCH 3/6] ASoC: Remove unnecessary -codec from cs4270 driver name
 sound/soc/codecs/cs4270.c    |    2 +-
 sound/soc/fsl/mpc8610_hpcd.c |    4 ++--
 sound/soc/pxa/raumfeld.c     |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

[PATCH 4/6] ASoC: fsl: create fsl_utils to accommodate the common functions
 sound/soc/fsl/Kconfig        |    5 ++
 sound/soc/fsl/Makefile       |    2 +
 sound/soc/fsl/fsl_utils.c    |  153 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_utils.h    |   29 ++++++++
 sound/soc/fsl/mpc8610_hpcd.c |  157 +++---------------------------------------
 sound/soc/fsl/p1022_ds.c     |  149 +++-------------------------------------
 6 files changed, 209 insertions(+), 286 deletions(-)

[PATCH 5/6] ASoC: fsl: use platform_device_id table to match p1022_ds device
 sound/soc/fsl/p1022_ds.c |   36 +++++++++---------------------------
 1 files changed, 9 insertions(+), 27 deletions(-)

[PATCH 6/6] ASoC: fsl: check property 'compatible' for the machine name
 sound/soc/fsl/fsl_ssi.c      |    6 +++---
 sound/soc/fsl/mpc8610_hpcd.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

See - not the 6 patch patchset is IN NO WAY a new version of the 4 patch
patchset like you're trying to say it is.

So my point that you're not listening stands.
