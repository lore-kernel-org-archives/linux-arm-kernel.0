Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1089C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E4A20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RdtitsZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E4A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=K2m06hzFsVQA5rkvs4slh0L8Qi13p4h5MT5vroDVvBU=; b=RdtitsZ+2TDa7iNTFwVIZyZrKY
	u3mqwZDT01AsskN/TOemZ6/yNi9Y7dZ+OlYQOn/Mcdc3T5iDY4pIxPtwEIGqhX+IYilsYkAEI8EiD
	5ppUD1r52GayYEaQtAAdXCQ5nwUGEIyOSGqQh4jtKnFK0mFoJHO8pYVC1og5m69ifTDshfnnW+PXl
	pxGpQZ6aqB8gRlQQQhRX9SB9cVApW6VNIPRBTHP1HwyjMvC/W2THVyPu7+7o729pXYnSZtwRxqgMb
	S6ZefQIqtJX4k8M9hlccNUfLmqr6GX8iC/upVDU8IIU+7nasA0m2F1QLFZZwmYnUgvMAV+Kp9erh/
	Xdq5k13w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyQi-0007py-Dg; Thu, 06 Dec 2018 18:31:20 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyOv-0004oq-8A
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:29:34 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQy0N-1gsIXC36UJ-00Nz33; Thu, 06 Dec 2018 19:29:09 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 09/10] staging: bcm2835-camera: Provide more specific probe
 error messages
Date: Thu,  6 Dec 2018 19:28:59 +0100
Message-Id: <1544120940-13716-10-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
References: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:foBtAdjdHW16fFFyLo30gcfAhdS2GSIEQlTliUpkODAm+OBYsOc
 nqYCzY2yBIeH4BB4Uxzrl8ivfocVXM2459vrB2uhwLLZX0dboSNRHYGriym1Y3qLHHurr0N
 UC9r3RD6/WShCjTk6zahF9wq5raNMKzLO371AGX/2CKk0n+o3yn64u35UL2Iyo3OHXmc3Fx
 x+jUCKKTZz23pjCt6RquA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RdQLuEGBtSE=:J5MVcEG2vm8hRT48fvLIr/
 94t9J11n5cczuro7qbHIIs1x5wHnz0iZDDoc//XamjKst7ZSUH2X2TUz8Z50+WzFEr14eCr7E
 y5DJoMzMO5HISHCINF9ZGkey+/1wVCuCeIh80K2YZ94H7EtSajUViQXnTmdM8iDbku+4MaEsp
 srjHpotMcrHVYd5PHaKbLV+yRzBfzovypyUsYHUP6A5X40/iDdG035Yc9GH6eif2z+lrbIhv0
 R28o+vFBen4sLvAYSEzRu3PCA0fcE9HHvXCM1DWqgEqZdBkExvcY9aDown4hhyszJ2ma7MnyO
 LvE2PeHmsn1lUuYuf5+nhGn36IIJL0di0NXl7D1glG5gT4a6z6h9GV0v8+dkyfCXClAT48JYB
 Rw3f7X6vtTJTyRtaQc+AupH6lZbV0YqDeXJr89S5K2/6K8B+WdLG/nrX5LiUUfV47fdOAskmo
 E8Wzhm/P5ETln90NOgi7KeyGdfvtub2pON4MNgAJ88YLwEr4lIYZnVWXF0TFXm9ai4nAl0xz6
 vj3Z6NUUL1ix8yA5Kwtg2D5LgZpkYgR2t3D+YnsgeuPQ98hydstU0z9fsG9QiRGBCqQ8nKp8M
 3fM53rjdtrGukurTQ2Kd8pmhCvSn+E+qCoG23gitqnGzVBFw1aW+yo85GcKaCcihTOVYXzI73
 GbmYRNwm9j2Z6wgXYfkTEfpTP5/vIdazuo5JqiS87UdOJukSRIxFz219ruJnNZyeMF0tBczB6
 k+jGTs2TKECbNLSIxOxQ9oPGNpPADuIsn9MNfEQTXH1YYBCaTXvd/r7rvJ8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_102929_592348_07C295DD 
X-CRM114-Status: GOOD (  16.02  )
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
Cc: devel@driverdev.osuosl.org, Stefan Wahren <stefan.wahren@i2se.com>,
 Takashi Iwai <tiwai@suse.de>, Eric Anholt <eric@anholt.net>,
 linux-arm-kernel@lists.infradead.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently there is only a catch-all info message which print the
relevant error code without any context. So add more specific error
messages in order to narrow down possible issues.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  | 58 +++++++++++++++-------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index cd773eb..611a6ee 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1539,8 +1539,11 @@ static int mmal_init(struct bm2835_mmal_dev *dev)
 	struct vchiq_mmal_component  *camera;
 
 	ret = vchiq_mmal_init(&dev->instance);
-	if (ret < 0)
+	if (ret < 0) {
+		v4l2_err(&dev->v4l2_dev, "%s: vchiq mmal init failed %d\n",
+			 __func__, ret);
 		return ret;
+	}
 
 	/* get the camera component ready */
 	ret = vchiq_mmal_component_init(dev->instance, "ril.camera",
@@ -1549,7 +1552,9 @@ static int mmal_init(struct bm2835_mmal_dev *dev)
 		goto unreg_mmal;
 
 	camera = dev->component[MMAL_COMPONENT_CAMERA];
-	if (camera->outputs <  MMAL_CAMERA_PORT_COUNT) {
+	if (camera->outputs < MMAL_CAMERA_PORT_COUNT) {
+		v4l2_err(&dev->v4l2_dev, "%s: too few camera outputs %d needed %d\n",
+			 __func__, camera->outputs, MMAL_CAMERA_PORT_COUNT);
 		ret = -EINVAL;
 		goto unreg_camera;
 	}
@@ -1557,8 +1562,11 @@ static int mmal_init(struct bm2835_mmal_dev *dev)
 	ret = set_camera_parameters(dev->instance,
 				    camera,
 				    dev);
-	if (ret < 0)
+	if (ret < 0) {
+		v4l2_err(&dev->v4l2_dev, "%s: unable to set camera parameters: %d\n",
+			 __func__, ret);
 		goto unreg_camera;
+	}
 
 	/* There was an error in the firmware that meant the camera component
 	 * produced BGR instead of RGB.
@@ -1647,8 +1655,8 @@ static int mmal_init(struct bm2835_mmal_dev *dev)
 
 	if (dev->component[MMAL_COMPONENT_PREVIEW]->inputs < 1) {
 		ret = -EINVAL;
-		pr_debug("too few input ports %d needed %d\n",
-			 dev->component[MMAL_COMPONENT_PREVIEW]->inputs, 1);
+		v4l2_err(&dev->v4l2_dev, "%s: too few input ports %d needed %d\n",
+			 __func__, dev->component[MMAL_COMPONENT_PREVIEW]->inputs, 1);
 		goto unreg_preview;
 	}
 
@@ -1661,8 +1669,8 @@ static int mmal_init(struct bm2835_mmal_dev *dev)
 
 	if (dev->component[MMAL_COMPONENT_IMAGE_ENCODE]->inputs < 1) {
 		ret = -EINVAL;
-		v4l2_err(&dev->v4l2_dev, "too few input ports %d needed %d\n",
-			 dev->component[MMAL_COMPONENT_IMAGE_ENCODE]->inputs,
+		v4l2_err(&dev->v4l2_dev, "%s: too few input ports %d needed %d\n",
+			 __func__, dev->component[MMAL_COMPONENT_IMAGE_ENCODE]->inputs,
 			 1);
 		goto unreg_image_encoder;
 	}
@@ -1676,8 +1684,8 @@ static int mmal_init(struct bm2835_mmal_dev *dev)
 
 	if (dev->component[MMAL_COMPONENT_VIDEO_ENCODE]->inputs < 1) {
 		ret = -EINVAL;
-		v4l2_err(&dev->v4l2_dev, "too few input ports %d needed %d\n",
-			 dev->component[MMAL_COMPONENT_VIDEO_ENCODE]->inputs,
+		v4l2_err(&dev->v4l2_dev, "%s: too few input ports %d needed %d\n",
+			 __func__, dev->component[MMAL_COMPONENT_VIDEO_ENCODE]->inputs,
 			 1);
 		goto unreg_vid_encoder;
 	}
@@ -1706,8 +1714,11 @@ static int mmal_init(struct bm2835_mmal_dev *dev)
 					      sizeof(enable));
 	}
 	ret = bm2835_mmal_set_all_camera_controls(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		v4l2_err(&dev->v4l2_dev, "%s: failed to set all camera controls: %d\n",
+			 __func__, ret);
 		goto unreg_vid_encoder;
+	}
 
 	return 0;
 
@@ -1873,21 +1884,29 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 		snprintf(dev->v4l2_dev.name, sizeof(dev->v4l2_dev.name),
 			 "%s", BM2835_MMAL_MODULE_NAME);
 		ret = v4l2_device_register(NULL, &dev->v4l2_dev);
-		if (ret)
+		if (ret) {
+			dev_err(&pdev->dev, "%s: could not register V4L2 device: %d\n",
+				__func__, ret);
 			goto free_dev;
+		}
 
 		/* setup v4l controls */
 		ret = bm2835_mmal_init_controls(dev, &dev->ctrl_handler);
-		if (ret < 0)
+		if (ret < 0) {
+			v4l2_err(&dev->v4l2_dev, "%s: could not init controls: %d\n",
+				 __func__, ret);
 			goto unreg_dev;
+		}
 		dev->v4l2_dev.ctrl_handler = &dev->ctrl_handler;
 
 		/* mmal init */
 		dev->instance = instance;
 		ret = mmal_init(dev);
-		if (ret < 0)
+		if (ret < 0) {
+			v4l2_err(&dev->v4l2_dev, "%s: mmal init failed: %d\n",
+				 __func__, ret);
 			goto unreg_dev;
-
+		}
 		/* initialize queue */
 		q = &dev->capture.vb_vidq;
 		memset(q, 0, sizeof(*q));
@@ -1905,16 +1924,19 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 
 		/* initialise video devices */
 		ret = bm2835_mmal_init_device(dev, &dev->vdev);
-		if (ret < 0)
+		if (ret < 0) {
+			v4l2_err(&dev->v4l2_dev, "%s: could not init device: %d\n",
+				 __func__, ret);
 			goto unreg_dev;
+		}
 
 		/* Really want to call vidioc_s_fmt_vid_cap with the default
 		 * format, but currently the APIs don't join up.
 		 */
 		ret = mmal_setup_components(dev, &default_v4l2_format);
 		if (ret < 0) {
-			v4l2_err(&dev->v4l2_dev,
-				 "%s: could not setup components\n", __func__);
+			v4l2_err(&dev->v4l2_dev, "%s: could not setup components: %d\n",
+				 __func__, ret);
 			goto unreg_dev;
 		}
 
@@ -1938,8 +1960,6 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 		bcm2835_cleanup_instance(gdev[i]);
 		gdev[i] = NULL;
 	}
-	pr_info("%s: error %d while loading driver\n",
-		BM2835_MMAL_MODULE_NAME, ret);
 
 cleanup_mmal:
 	vchiq_mmal_finalise(instance);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
