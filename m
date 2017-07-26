From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 27 Jul 2017 00:46:59 +0200
Subject: [PATCH v6 2/7] drm/rockchip: vop: move write_relaxed flags to vop
 register
In-Reply-To: <1501049953-5946-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
 <1501049953-5946-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <2941261.MXxzaYlBrM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 26. Juli 2017, 14:19:12 CEST schrieb Mark Yao:
> Since the drm atomic framework, only a small part of the vop
> register needs sync write, Currently seems only following registers
> need sync write:
>    cfg_done, standby and interrupt related register.
> 
> All ctrl registers are using the sync write method that is
> inefficient, hardcode the write_relaxed flags to vop registers,
> then can only do synchronize write for those actual needed register.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>

on rk3036 and rk3288
Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko
