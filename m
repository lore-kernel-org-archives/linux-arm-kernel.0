From: b42378@freescale.com (Nicolin Chen)
Date: Fri, 15 Nov 2013 10:59:57 +0800
Subject: [PATCH 0/2] Add monaural audio support for fsl_ssi.c
In-Reply-To: <20131115030247.GC11014@S2101-09.ap.freescale.net>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
 <20131115030247.GC11014@S2101-09.ap.freescale.net>
Message-ID: <20131115025956.GA745@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,
   
On Fri, Nov 15, 2013 at 11:02:49AM +0800, Shawn Guo wrote:
> On Thu, Nov 14, 2013 at 07:07:08PM +0800, Nicolin Chen wrote:
> > This series of patches need to be applied into one single tree because
> > the second patch depends on the first one. Without it, SSI would playback
> > constant noise to the right channel when playback monaural audio files on
> > i.MX6 Series board.
> 
> Let me try to understand if the dependency is true.
> 
> Saying I apply the DTS patch on IMX tree while Mark apply the fsl_ssi
> patch on his tree, will there be any regression on either IMX tree or
> Mark's tree?  The monaural playback on imx6qdl never worked, so it's not
> a regression.  If there is no regression on either tree, there is no
> dependency to maintain.

It's fair enough to understand in this way. It looks like I misunderstood
the dependency here.

Do I need to resend them separately?

Thank you.

> 
> Shawn
> 
> > 
> > We might also need to apply the iomux change to the other i.MX platforms,
> > just currently I don't have those boards so I drop their changes for now.
> > 
> > Nicolin Chen (2):
> >   ARM: dts: imx: specify the value of audmux pinctrl instead of
> >     0x80000000
> >   ASoC: fsl_ssi: Add monaural audio support for non-ac97 interface
> > 
> >  arch/arm/boot/dts/imx6qdl.dtsi | 22 +++++++++++-----------
> >  sound/soc/fsl/fsl_ssi.c        | 22 +++++++++++++++++++---
> >  2 files changed, 30 insertions(+), 14 deletions(-)
> > 
> > -- 
> > 1.8.4
> > 
> > 
