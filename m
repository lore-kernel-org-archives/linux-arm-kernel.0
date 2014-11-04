From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 4 Nov 2014 16:16:46 +0800
Subject: [PATCH] ARM: imx: Explicitly select CONFIG_SPI
In-Reply-To: <CAOMZO5AB8khWKYmeOQWd0_jT4Ho0ogAkUX+=3mfhqEVhhxeqGQ@mail.gmail.com>
References: <1414617568-27615-1-git-send-email-festevam@gmail.com>
 <20141103062606.GF10821@tiger>
 <CAOMZO5AB8khWKYmeOQWd0_jT4Ho0ogAkUX+=3mfhqEVhhxeqGQ@mail.gmail.com>
Message-ID: <20141104081645.GJ10821@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 10:45:20AM -0200, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Mon, Nov 3, 2014 at 4:26 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Wed, Oct 29, 2014 at 07:19:28PM -0200, Fabio Estevam wrote:
> >> From: Fabio Estevam <fabio.estevam@freescale.com>
> >>
> >> Since 3.18-rc1 CONFIG_SPI is no longer automatically selected for
> >> imx_v4_v5_defconfig and imx_v6_v7_defconfig, so in order to keep the same
> >> behaviour as previous kernel versions and avoid regressions, let's explicitly
> >> select CONFIG_SPI.
> >>
> >> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >> ---
> >> Shawn,
> >>
> >> If possible, please apply this as a bug fix for 3.18.
> >
> > Can you please mention the commit that introduced the regression in the
> > commit log?
> 
> The problem is that 'git bisect' did not produce a valid result for
> me. It says that:
> 
> commit cf377ad7d42c566356d79049536d9cb37499cb77
> Merge: 212fe84 d8f0faa
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Oct 8 17:13:04 2014 -0400
> 
>     Merge tag 'soc-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> 
> 
> , is the first bad commit, but this does not look correct, so I was
> not able to really identify the commit that caused this regression.
> 
> Here is my procedure (starting at 3.18-rc1):
> 
> git bisect start
> git bisect bad
> git bisect good v3.17
> make imx_v6_v7_defconfig
> cat .config | grep CONFIG_SPI=y
> 
> Then I add "git bisect good or bad" depending on the output of the
> 'cat' command.
> 
> Any ideas?

The CONFIG_SPI was removed by your commit 64546e9fe3a5 (ARM:
imx_v6_v7_defconfig updates), which cames from savedefconfig, I assume.
That said, in the code base that your patch was generated, option
CONFIG_SPI is redundant, But it's not the case on mainline.

Shawn
