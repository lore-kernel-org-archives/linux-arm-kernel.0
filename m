From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 28 Jul 2017 15:06:39 +0200
Subject: [PATCH v6 7/7] drm/rockchip: vop: rk3328: fix overlay abnormal
In-Reply-To: <1501049980-6239-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
 <1501049980-6239-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <7730838.UedTk5eOxO@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 26. Juli 2017, 14:19:39 CEST schrieb Mark Yao:
> It's a hardware bug, all window's overlay channel reset
> value is same, hardware overlay would be die.
> 
> so we must initial difference id for each overlay channel.
> 
> The Channel register is supported on all vop will full design.
> Following is the details for this register
> VOP_WIN0_CTRL2
>   bit[7:4] win_rid_win0_cbr
>        axi read id of win0 cbr channel
>   bit[3:0] win_rid_win0_yrgb
>        axi read id of win0 yrgb channel
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>

rk3036 and rk3288 are not negatively affected by this, so
on rk3036 and rk3288
Tested-by: Heiko Stuebner <heiko@sntech.de>
