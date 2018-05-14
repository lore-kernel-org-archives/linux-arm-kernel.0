From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 14 May 2018 11:45:05 +0200
Subject: [PATCH v2 04/13] soc: rockchip: power-domain: Fix wrong value
 when power up pd
In-Reply-To: <1526268578-9361-1-git-send-email-zhangqing@rock-chips.com>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
 <1526268578-9361-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1861053.XlXe5vHN1s@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Montag, 14. Mai 2018, 05:29:38 CEST schrieb Elaine Zhang:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Solve the pd could only ever turn off but never turn them on again,
> If the pd registers have the writemask bits.
> 
> Fix up the code error for commit:
> 	commit 79bb17ce8edb3141339b5882e372d0ec7346217c
> 	Author: Elaine Zhang <zhangqing@rock-chips.com>
> 	Date:   Fri Dec 23 11:47:52 2016 +0800
> 
> 	soc: rockchip: power-domain: Support domain control in hiword-registers
> 
> 	New Rockchips SoCs may have their power-domain control in registers
> 	using a writemask-based access scheme (upper 16bit being the write
> 	mask). So add a DOMAIN_M type and handle this case accordingly.
> 	Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> 	Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

As Gregs automated mail noted, the stable-notice needed some changes.

I've done these changes and applied the result for 4.18.

When you look at [0] you'll see  the two lines "Fixes:..." and "Cc:..."
in the commit message. Greg then has automated scripts running that
extract so marked patches from Linus' tree and queue them for possible
stable-inclusion.

[The other patches need to wait a bit to give Rob a chance to Ack them]

Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=ed726894761c056b3513ce15915af74ce5d7d57b
