From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 08 Jan 2015 23:30:01 +0100
Subject: [RFC PATCH 0/2] clk: rockchip: leave npll for DCLK_VOP0(HDMI) only
In-Reply-To: <1416236138-11010-1-git-send-email-kever.yang@rock-chips.com>
References: <1416236138-11010-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <3353483.Eif0pChkY5@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kever,

Am Montag, 17. November 2014, 22:55:36 schrieb Kever Yang:
> To support all kinds of frequency requirement for HDMI on rk3288,
> we need a PLL that can change rate at run time.
> 
> There are some discussion before at [0], I think we can just leave
> the npll for HDMI(DCLK_VOP0) used to make it simple.
> 
> Comments are welcome.

I think I said it in private somewhere already, but just so it's also 
available publically:

I don't think customizing/limiting the clock usage like this will fly, 
especially as this would require each and every rk3288 board to use vop0 for 
hdmi and vop1 for other stuff.

With the new rk3288 Firefly devboard this concern already becomes reality. 
There a vga converter is connected to VOP0, which leaves only vop1 for hdmi if 
one wants to support the vga connection.


>From our discussion about this problem I remember that the missing clock 
frequencies only affected more esotheric screen resolutions, so personally I'm 
not this much concerned an would like to wait till we find a better solution to 
the problem.


Heiko
