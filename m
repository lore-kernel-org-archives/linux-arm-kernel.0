From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 02 Dec 2015 10:55:29 +0800
Subject: [GIT PULL] drm/rockchip: fixes
Message-ID: <565E5DA1.1070006@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave

Here are some needed fixes for rockchip drm.
There are three patches I had sent you before, I noticed that you don't 
land them, so I rebase to drm-fixes and send you again:
       drm/rockchip: unset pgoff when mmap'ing gems
             drm rockchip can't work without this patch, when test with 
modetest, always get following error:
                   trying to open device 'rockchip'...success.
                   failed to map buffer: Unknown error -6

       drm/rockchip: vop: Correct enabled clocks during setup
             if build drm rockchip as module, we need this patch, system 
would hang if aclk is disabled.

       drm/rockchip: vop: fix window origin calculation
             this patch fix window display, display shift by one pixel 
on screen.

Other new two fixes:
       drm/rockchip: Fix module autoload for OF platform driver
             module autoloading won't work without this patch.

       drm/rockchip: Use CRTC vblank event interface
             Passing -1 as the pipe triggers a WARN_ON at every pageflip 
on multi-screen, that make multi-screen unusable.

I'd like you can land them.

Thanks.

The following changes since commit 
b50a1705b598fa4074a5e5e4f20ca46485d1cd0e:

   Merge tag 'drm-intel-fixes-2015-11-30' of 
git://anongit.freedesktop.org/drm-intel into drm-fixes (2015-12-01 
08:00:33 +1000)

are available in the git repository at:


https://github.com/markyzq/kernel-drm-rockchip.git 
drm-fixes-rockchip-2015-12-02

for you to fetch changes up to c9fbb7f7b5c56752373e4f425d5157815426e233:

   drm/rockchip: Use CRTC vblank event interface (2015-12-02 10:22:21 
+0800)

----------------------------------------------------------------
Daniel Stone (1):
       drm/rockchip: Use CRTC vblank event interface

Dominik Behr (1):
       drm/rockchip: vop: fix window origin calculation

Heiko Stuebner (1):
       drm/rockchip: unset pgoff when mmap'ing gems

Luis de Bethencourt (1):
       drm/rockchip: Fix module autoload for OF platform driver

Sjoerd Simons (1):
       drm/rockchip: vop: Correct enabled clocks during setup

  drivers/gpu/drm/rockchip/rockchip_drm_gem.c |    1 +
  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   43 
+++++++++++----------------
  2 files changed, 19 insertions(+), 25 deletions(-)

-- 
?ark Yao
