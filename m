From: keiichiw@chromium.org (Keiichi Watanabe)
Date: Mon, 18 Jun 2018 16:58:51 +0900
Subject: [PATCH v4 0/3] Add controls for VP8/VP9 profile
Message-ID: <20180618075854.12881-1-keiichiw@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is the 4th revision of the patch set that adds controls for VP8/VP9
profiles. Please see v3 cover letter for more details.
<https://lkml.org/lkml/2018/6/14/132>

In this version, I changed the contents that pointed out by Stanimir and Hans.

Changelog
----------

Version 4 changes:
- Remove unnecessary changes in venus drivers.
- Remove unnecessary blank lines in documentations.
- Fix typo and grammar mistakes.

Version 3 changes:
- Add V4L2_CID_MPEG_VIDEO_VP8_PROFILE in v4l2-controls.
- Make V4L2_CID_MPEG_VIDEO_VPX_PROFILE to be an alias of
  V4L2_CID_MPEG_VIDEO_VP8_PROFILE.
- Fix the use of V4L2_CID_MPEG_VIDEO_VPX_PROFILE in venus/s5p_mfc drivers.
- Small fix in mtk_vcodec_dec.

Version 2 changes:
- Support V4L2_CID_MPEG_VIDEO_VP9_PROFILE in MediaTek decoder's driver.

Version 1 changes:
- Add V4L2_CID_MPEG_VIDEO_VP9_PROFILE in v4l2-controls.

Keiichi Watanabe (3):
  media: v4l2-ctrl: Change control for VP8 profile to menu control
  media: v4l2-ctrl: Add control for VP9 profile
  media: mtk-vcodec: Support VP9 profile in decoder

 .../media/uapi/v4l/extended-controls.rst      | 48 +++++++++++++++++--
 .../platform/mtk-vcodec/mtk_vcodec_dec.c      |  5 ++
 .../media/platform/qcom/venus/vdec_ctrls.c    | 10 ++--
 drivers/media/platform/qcom/venus/venc.c      |  4 +-
 .../media/platform/qcom/venus/venc_ctrls.c    | 10 ++--
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  | 15 +++---
 drivers/media/v4l2-core/v4l2-ctrls.c          | 23 ++++++++-
 include/uapi/linux/v4l2-controls.h            | 18 ++++++-
 8 files changed, 110 insertions(+), 23 deletions(-)

--
2.18.0.rc1.244.gcf134e6275-goog
