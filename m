From: keiichiw@chromium.org (Keiichi Watanabe)
Date: Wed, 30 May 2018 16:16:11 +0900
Subject: [PATCH v2 0/2] Add control for VP9 profile
Message-ID: <20180530071613.125768-1-keiichiw@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds a new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE
for VP9 profile.
This control can be used to select a desired profile for VP9 encoder.
In addition, it is also used to query for supported profiles by an
encoder or a decoder.

Patch 1 adds this control.
By patch 2, this control is added to MediaTek decoder's driver, which
supports VP9 profile 0.


Version 2 changes:
- Support this control in MediaTek decoder's driver

Keiichi Watanabe (2):
  media: v4l2-ctrl: Add control for VP9 profile
  media: mtk-vcodec: Support VP9 profile in decoder

 .../media/uapi/v4l/extended-controls.rst      | 26 +++++++++++++++++++
 .../platform/mtk-vcodec/mtk_vcodec_dec.c      |  6 +++++
 drivers/media/v4l2-core/v4l2-ctrls.c          | 12 +++++++++
 include/uapi/linux/v4l2-controls.h            |  8 ++++++
 4 files changed, 52 insertions(+)

--
2.17.0.921.gf22659ad46-goog
