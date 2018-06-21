From: ayaka@soulik.info (Randy Li)
Date: Fri, 22 Jun 2018 00:47:35 +0800
Subject: [PATCH v3 0/2] Add support for a YUV 10bits pixel format
Message-ID: <20180621164737.23611-1-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the last time, I got some feedback and not a clear guide on what
I should do. So just give more comment on describing this 10bits format.
Whether I should add bpp instead cpp in drm_format_info and update a
numbers of functions is up to you guys.

And I don't any other driver would request 10bits yuv format support,
so I can't add the pixel format they don't use as I did a year ago.
You would ignore those patches.

v3:
I put a code comment in a wrong commit in the previous commit,
move it back.
v2:
add more comment to describe this pixel format

Randy Li (2):
  drm/fourcc: add a 10bits fully packed variant of NV12
  drm/rockchip: Support 10 bits yuv format in vop

 drivers/gpu/drm/drm_fourcc.c                |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 27 +++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  2 ++
 include/uapi/drm/drm_fourcc.h               |  8 ++++++++
 5 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.14.4
