From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 24 Mar 2013 22:18:00 +0800
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Enable touchscreen support
In-Reply-To: <CAOMZO5BvT3CUhPECTQZQq_Q2YEqMJzmXPL5pj-3Qmq35jnvm1A@mail.gmail.com>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
 <20130304031716.GC30431@S2101-09.ap.freescale.net>
 <CAOMZO5Ai-msRVeAqQFiRhfAxkb2DMTYJvTcYihBhFt6GMCFwPQ@mail.gmail.com>
 <20130323135608.GG6281@S2101-09.ap.freescale.net>
 <CAOMZO5BvT3CUhPECTQZQq_Q2YEqMJzmXPL5pj-3Qmq35jnvm1A@mail.gmail.com>
Message-ID: <20130324141758.GH6281@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 03:09:52PM -0300, Fabio Estevam wrote:
> On Sat, Mar 23, 2013 at 10:56 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Fri, Mar 22, 2013 at 03:07:29PM -0300, Fabio Estevam wrote:
> >> Shawn,
> >>
> >> On Mon, Mar 4, 2013 at 12:17 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> >>
> >> > I do not understand why.  But it seems to me that applying the patch on
> >> > top of v3.9-rc1 results in a silent audio playback on my imx28-evk
> >> > board.  Can you confirm that on your side?
> >>
> >> Can you please re-try against linux-next 20130322?
> >>
> > Does it even boot for you?  On my side, it stops at the point below.
> >
> > [    1.600867] ci_hdrc ci_hdrc.0: doesn't support gadget
> > [    1.606282] ci_hdrc ci_hdrc.0: EHCI Host Controller
> > [    1.613522] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
> 
> Same here. I forgot to mention I had to disable USB in order to
> complete the boot. This USB issue should be addressed separately
> though.
> 
Just figured it out that the problem is caused by usb phy Kconfig symbol
shuffling.  Just posted fixes.

> >
> >> I tried it here and audio playback is normal with touchscreen enabled.
> >
> > You must have both patches below applied.
> >
> >  1) ARM: mxs_defconfig: Build CONFIG_INPUT_EVDEV as built-in
> >  2) ARM: dts: imx28-evk: Enable touchscreen support
> >
> > I found that applying either one of the two without applying the other
> > will result in a broken audio playback.
> 
> With the USB support disabled, I don't see audio playback failure.

Yes, when testing on next-20130322, it seems audio playback works.  But
since when the patch gets applied on my mxs/dt branch, it breaks audio
there, I still can not apply it.

Shawn
