From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 25 Feb 2015 17:24:26 -0800
Subject: [PATCH 0/8] Fix struct clk pointer comparing
In-Reply-To: <54EE33C5.5010701@codeaurora.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <20150225150349.GB8656@n2100.arm.linux.org.uk>
 <20150225175533.421.41831@quantum> <54EE33C5.5010701@codeaurora.org>
Message-ID: <20150226012426.421.62077@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2015-02-25 12:42:45)
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

Probably we can use them. I'll need to spend a few minutes with both
patches and make sure it looks good. clkdev stuff always spins my head
around.

Regards,
Mike

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
