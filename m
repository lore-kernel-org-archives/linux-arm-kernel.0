From: jeffy.chen@rock-chips.com (jeffy)
Date: Thu, 27 Jul 2017 16:43:05 +0800
Subject: [v6,
 2/7] drm/rockchip: vop: move write_relaxed flags to vop register
In-Reply-To: <1501049953-5946-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049953-5946-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <5979A799.1050809@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi mark,

On 07/26/2017 02:19 PM, Mark yao wrote:
> Since the drm atomic framework, only a small part of the vop
> register needs sync write, Currently seems only following registers
> need sync write:
>     cfg_done, standby and interrupt related register.
>
> All ctrl registers are using the sync write method that is
> inefficient, hardcode the write_relaxed flags to vop registers,
> then can only do synchronize write for those actual needed register.
>
> Signed-off-by: Mark Yao<mark.yao@rock-chips.com>
> Tested-by: Heiko Stuebner<heiko@sntech.de>

Reviewed-by: Jeffy Chen <jeffy.chen@rock-chips.com>
