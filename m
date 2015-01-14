From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 14 Jan 2015 14:16:15 -0800
Subject: [RFC PATCH 0/2] clk: rockchip: leave npll for DCLK_VOP0(HDMI) only
In-Reply-To: <3353483.Eif0pChkY5@phil>
References: <1416236138-11010-1-git-send-email-kever.yang@rock-chips.com>
 <3353483.Eif0pChkY5@phil>
Message-ID: <20150114221615.22722.24878@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2015-01-08 14:30:01)
> Hi Kever,
> 
> Am Montag, 17. November 2014, 22:55:36 schrieb Kever Yang:
> > To support all kinds of frequency requirement for HDMI on rk3288,
> > we need a PLL that can change rate at run time.
> > 
> > There are some discussion before at [0], I think we can just leave
> > the npll for HDMI(DCLK_VOP0) used to make it simple.
> > 
> > Comments are welcome.
> 
> I think I said it in private somewhere already, but just so it's also 
> available publically:
> 
> I don't think customizing/limiting the clock usage like this will fly, 
> especially as this would require each and every rk3288 board to use vop0 for 
> hdmi and vop1 for other stuff.
> 
> With the new rk3288 Firefly devboard this concern already becomes reality. 
> There a vga converter is connected to VOP0, which leaves only vop1 for hdmi if 
> one wants to support the vga connection.
> 
> 
> From our discussion about this problem I remember that the missing clock 
> frequencies only affected more esotheric screen resolutions, so personally I'm 
> not this much concerned an would like to wait till we find a better solution to 
> the problem.

Ack. We shouldn't have to limit the possible hardware configurations in
software just to keep things simple. This points to a deficiency in the
clock framework. This is a common concern: how to change a clock
frequency for one user without exploding all of the other users.

Do you think Tomeu's constraints API[0] might be a step in the right
direction for you?

[0] http://lkml.kernel.org/r/<1421071809-17402-3-git-send-email-tomeu.vizoso@collabora.com>

Regards,
Mike

> 
> 
> Heiko
