From: b42378@freescale.com (Nicolin Chen)
Date: Fri, 15 Nov 2013 14:40:09 +0800
Subject: [PATCH 1/2] ARM: dts: imx: specify the value of audmux pinctrl
 instead of 0x80000000
In-Reply-To: <20131115064159.GG11014@S2101-09.ap.freescale.net>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
 <1384427230-979-2-git-send-email-b42378@freescale.com>
 <20131115064159.GG11014@S2101-09.ap.freescale.net>
Message-ID: <20131115064009.GD745@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 02:42:01PM +0800, Shawn Guo wrote:
> On Thu, Nov 14, 2013 at 07:07:09PM +0800, Nicolin Chen wrote:
> > We must specify the value of audmux pinctrl if we want to use pinctrl_pm().
> > Thus change bypass value 0x80000000 to what we exactly need.
> > 
> > This patch also seperately unset PUE bit for TXD so that IOMUX won't pull
> > up/down the pin after turning into tristate. When we use SSI normal mode to
> > playback monaural audio via I2S signal, there'd be a pulled curve occur to
> > its signal at the second slot if setting PUE bit for TXD. And it will make
> > the second channel to play a constant noise. So by keeping the signal level
> > in the second slot, we can get a constant high level signal (-1) or a low
> > level one (0).
> > 
> > Signed-off-by: Nicolin Chen <b42378@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> We have moved all pin groups settings into
> arch/arm/boot/dts/imx6qdl-pingrp.h.  I just rebased and applied the
> patch.  Please check my imx/dt branch and ensure I applied the changes
> correctly.

Simply perfect. Thank you.
Nicolin

---
