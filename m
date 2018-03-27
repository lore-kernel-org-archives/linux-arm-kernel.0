From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 28 Mar 2018 00:58:51 +0200
Subject: [RESEND PATCH v2 0/8] Add support for PWM input capture on STM32
In-Reply-To: <20180327225101.GJ28163@mithrandir>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
 <20180327225101.GJ28163@mithrandir>
Message-ID: <20180327225850.GL28163@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2018 at 12:51:02AM +0200, Thierry Reding wrote:
> On Wed, Feb 14, 2018 at 11:04:31AM +0100, Fabrice Gasnier wrote:
> > This series adds support for capture to stm32-pwm driver.
> > Capture is based on DMAs.
> > - First two patches are precursor patches
> > - Subsequent two patches add support for requesting DMAs to MFD core
> > - Next three patches add support for capture to stm32-pwm driver
> > - This has been tested on stm32429i-eval board.
> > 
> > ---
> > Resend v2:
> > - Add collected Acks
> > 
> > Changes in v2:
> > - Abstract DMA handling from child driver: move it to MFD core
> > - Rework pwm capture routines to adopt this change
> > - Comment on optional dma support, beautify DMAs probe
> > 
> > Fabrice Gasnier (8):
> >   pwm: stm32: fix, remove unused struct device
> >   pwm: stm32: protect common prescaler for all channels
> >   dt-bindings: mfd: stm32-timers: add support for dmas
> >   mfd: stm32-timers: add support for dmas
> >   pwm: stm32: add capture support
> >   pwm: stm32: improve capture by tuning counter prescaler
> >   pwm: stm32: use input prescaler to improve period capture
> >   ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval
> > 
> >  .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
> >  arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
> >  drivers/mfd/stm32-timers.c                         | 215 +++++++++++++++-
> >  drivers/pwm/pwm-stm32.c                            | 276 ++++++++++++++++++++-
> >  include/linux/mfd/stm32-timers.h                   |  39 +++
> >  5 files changed, 547 insertions(+), 6 deletions(-)
> 
> I can't apply patches 1-2 and 5-6 since they depend on patches 3-4 for
> which I'd need an Acked-by: from Lee if I'm to pick them up. Same goes
> for patch 7.
> 
> By the looks of it there are minor conflicts with the MFD tree, but no
> major ones. Perhaps it'd be better for Lee to pick up 3-4 for v4.17-rc1
> and ack patch 7, then I can take the rest after v4.17-rc1?

I can pick up 1-2 which are separate from the capture changes and have
no dependencies.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/a95d9d0d/attachment.sig>
