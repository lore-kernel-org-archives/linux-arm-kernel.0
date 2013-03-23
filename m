From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 23 Mar 2013 21:56:11 +0800
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Enable touchscreen support
In-Reply-To: <CAOMZO5Ai-msRVeAqQFiRhfAxkb2DMTYJvTcYihBhFt6GMCFwPQ@mail.gmail.com>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
 <20130304031716.GC30431@S2101-09.ap.freescale.net>
 <CAOMZO5Ai-msRVeAqQFiRhfAxkb2DMTYJvTcYihBhFt6GMCFwPQ@mail.gmail.com>
Message-ID: <20130323135608.GG6281@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 03:07:29PM -0300, Fabio Estevam wrote:
> Shawn,
> 
> On Mon, Mar 4, 2013 at 12:17 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > I do not understand why.  But it seems to me that applying the patch on
> > top of v3.9-rc1 results in a silent audio playback on my imx28-evk
> > board.  Can you confirm that on your side?
> 
> Can you please re-try against linux-next 20130322?
> 
Does it even boot for you?  On my side, it stops at the point below.

[    1.600867] ci_hdrc ci_hdrc.0: doesn't support gadget
[    1.606282] ci_hdrc ci_hdrc.0: EHCI Host Controller
[    1.613522] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1

> I tried it here and audio playback is normal with touchscreen enabled.

You must have both patches below applied.

 1) ARM: mxs_defconfig: Build CONFIG_INPUT_EVDEV as built-in
 2) ARM: dts: imx28-evk: Enable touchscreen support

I found that applying either one of the two without applying the other
will result in a broken audio playback.

That said, my mxs/soc branch gets a broken audio playback, and
next-20130322 should be the same case, because both have the second
patch not applied.

I'm going to drop CONFIG_INPUT_EVDEV patch from my mxs/soc branch, and
will not apply either of the two until the root cause of the broken
audio playback gets identified.

Shawn
