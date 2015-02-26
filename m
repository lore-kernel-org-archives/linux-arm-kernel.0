From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Feb 2015 09:21:39 +0800
Subject: [PATCH 0/8] Fix struct clk pointer comparing
In-Reply-To: <54EE33C5.5010701@codeaurora.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <20150225150349.GB8656@n2100.arm.linux.org.uk>
 <20150225175533.421.41831@quantum>
 <54EE33C5.5010701@codeaurora.org>
Message-ID: <20150226012121.GC20028@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 12:42:45PM -0800, Stephen Boyd wrote:
> On 02/25/15 09:55, Mike Turquette wrote:
> > Quoting Russell King - ARM Linux (2015-02-25 07:03:49)
> >> Case 1 applies in places like the Kirkwood I2S driver, and the iMX6
> >> ethernet code, and it's these cases which need to be fixed.
> >>
> >> Case 2 applies in the Armada DRM driver, and these cases need not be
> >> "fixed".
> >>
> >> To put it a different way: case 1 is when you're testing to see whether
> >> two clocks refer to the same clock.  case 2 is when you're testing
> >> whether the cached clk cookie is the same.
> > It looks like patches 2, 7 and 8 are correct in this series. I'll apply
> > them towards -rc2 if nobody objects.
> >
> >
> 
> For patch 8 can't we use the alternative patch that I came up with
> before? I have a patch for sound/soc/fsl/fsl_esai.c and
> drivers/pwm/pwm-atmel-hlcdc.c which I can send shortly.

This beats the idea of clk_is_match() helper.  I prefer to fix this
generic problem in a generic way, i.e. using clk_is_match(), which
should be much easier and safer during -rc cycle.

Shawn
