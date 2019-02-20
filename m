Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063C2C10F0B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:17:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE81420880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LJ5S8K9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE81420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iXmrnW35oooW690XS4OVSapTUWjHpO0urvG884SmpwI=; b=LJ5S8K9SUXXGao
	BKOsV9xG2kmo9o8koGvO4TpL6xY+/d6kJDvznpXYa3C8JbJ7sE9oGXLC9yH1cz9FlHUNk2KENyWO6
	RPE1BUOTXFao+jtMbUVK7UoN7cwgn3IE+XCV4HfS7mnAelHnhPdxgmLDqVbwbYMsFyEirgfiYRd6X
	ktAdKDa+eiLlNQHFrjidyBk/cDDa2Z9gxF0OXkp7YIR5c1SC0FnEuYhgrJZlUR91hLXuHk32FzyHP
	x7dBt/msnj/xXnzXjuDROkofo/BUmcZ+fUDLymOhRNaYYDsfrNAmF1Xqpmel0IlAx3q7twXijwxLS
	r4vRkzlVeBBajyhcr54Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSh8-0001MW-9G; Wed, 20 Feb 2019 14:17:54 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSh4-0001L2-7E
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:17:52 +0000
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 38AC310000D;
 Wed, 20 Feb 2019 14:17:37 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: hans.verkuil@cisco.com, acourbot@chromium.org,
 sakari.ailus@linux.intel.com,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v4 0/2] media: cedrus: Add H264 decoding support
Date: Wed, 20 Feb 2019 15:17:32 +0100
Message-Id: <cover.1862a43851950ddee041d53669f8979aba863c38.1550672228.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_061750_551647_3F0648C9 
X-CRM114-Status: GOOD (  17.03  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: jonas@kwiboo.se, Maxime Ripard <maxime.ripard@bootlin.com>,
 jenskuske@gmail.com, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com, tfiga@chromium.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, posciak@chromium.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 nicolas.dufresne@collabora.com, ezequiel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Here is a new version of the H264 decoding support in the cedrus
driver.

As you might already know, the cedrus driver relies on the Request
API, and is a reverse engineered driver for the video decoding engine
found on the Allwinner SoCs.

This work has been possible thanks to the work done by the people
behind libvdpau-sunxi found here:
https://github.com/linux-sunxi/libvdpau-sunxi/

I've tested the various ABI using this gdb script:
http://code.bulix.org/jl4se4-505620?raw

And this test script:
http://code.bulix.org/8zle4s-505623?raw

The application compiled is quite trivial:
http://code.bulix.org/e34zp8-505624?raw

The output is:
arm:	builds/arm-test-v4l2-h264-structures
	SHA1: fd15b30328765c2caac877e8ea8452c829b2b1d8
x86:	builds/x86-test-v4l2-h264-structures
	SHA1: fd15b30328765c2caac877e8ea8452c829b2b1d8
x64:	builds/x64-test-v4l2-h264-structures
	SHA1: fd15b30328765c2caac877e8ea8452c829b2b1d8
arm64:	builds/arm64-test-v4l2-h264-structures
	SHA1: fd15b30328765c2caac877e8ea8452c829b2b1d8

Let me know if there's any flaw using that test setup, or if you have
any comments on the patches.

Maxime

Changes from v3:
  - Reintroduced long term reference flag and documented it
  - Reintroduced ref_pic_list_p0/b0/b1 and documented it
  - Documented the DPB flags
  - Treat the scaling matrix as optional in the driver, as documented
  - Free the neighbor buffer
  - Increase the control IDs by a large margin to be safe of collisions
  - Reorder the fields documentation according to the structure layout
  - Change the tag documentation by the timestamp
  - Convert the sram array to size_t
  - Simplify the buffer retrieval from timestamp
  - Rebase

Changes from v2:
  - Simplified _cedrus_write_ref_list as suggested by Jernej
  - Set whether the frame is used as reference using nal_ref_idc
  - Respect chroma_format_idc
  - Fixes for the scaling list and prediction tables
  - Wrote the documentation for the flags
  - Added a bunch of defines to the driver bit fields
  - Reworded the controls and data format descriptions as suggested
    by Hans
  - Reworked the controls' structure field size to avoid padding
  - Removed the long term reference flag
  - Reintroduced the neighbor info buffer
  - Removed the ref_pic_list_p0/b0/b1 arrays that are redundant with the
    one in the DPB
  - used the timestamps instead of tags
  - Rebased on 5.0-rc1

Changes from v1:
  - Rebased on 4.20
  - Did the documentation for the userspace API
  - Used the tags instead of buffer IDs
  - Added a comment to explain why we still needed the swdec trigger
  - Reworked the MV col buffer in order to have one slot per frame
  - Removed the unused neighbor info buffer
  - Made sure to have the same structure offset and alignments across
    32 bits and 64 bits architecture

Maxime Ripard (1):
  media: cedrus: Add H264 decoding support

Pawel Osciak (1):
  media: uapi: Add H264 low-level decoder API compound controls.

 Documentation/media/uapi/v4l/biblio.rst            |   9 +-
 Documentation/media/uapi/v4l/extended-controls.rst | 547 +++++++++++++-
 Documentation/media/uapi/v4l/pixfmt-compressed.rst |  20 +-
 Documentation/media/uapi/v4l/vidioc-queryctrl.rst  |  30 +-
 Documentation/media/videodev2.h.rst.exceptions     |   5 +-
 drivers/media/v4l2-core/v4l2-ctrls.c               |  42 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +-
 drivers/staging/media/sunxi/cedrus/Makefile        |   3 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c        |  30 +-
 drivers/staging/media/sunxi/cedrus/cedrus.h        |  38 +-
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c    |  13 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c   | 584 ++++++++++++++-
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c     |   4 +-
 drivers/staging/media/sunxi/cedrus/cedrus_regs.h   |  91 ++-
 drivers/staging/media/sunxi/cedrus/cedrus_video.c  |   9 +-
 include/media/h264-ctrls.h                         | 190 +++++-
 include/media/v4l2-ctrls.h                         |  13 +-
 include/uapi/linux/videodev2.h                     |   1 +-
 18 files changed, 1627 insertions(+), 3 deletions(-)
 create mode 100644 drivers/staging/media/sunxi/cedrus/cedrus_h264.c
 create mode 100644 include/media/h264-ctrls.h

base-commit: aa89b613a1c52cfd25076acfbbf6266c4b6f411b
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
