Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A4EC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:30:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E9820892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wuwhatd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E9820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=q6NB4GeeocILbB27l+COwLYQpAzf8MEBT+W+weZ3IJI=; b=Wuwhatd0kTtgQ0RdQClO98E/is
	gYCnrGCPEJ9VrVip26lR8otXVCFn6y/+NwUIvtRZ1T+3TkKSiB7Px2V0bJKPYKGhGl9ztcJn3rQVT
	5kskFkxVpuEdSuK2hS+Hc1Dsrdr1crb1G5MLsUip0spQ6J8Wk5+mDZVHXDrJLR5kvxjPp+qLub/+Y
	NbhzSU3ippl6Z7YXwV4k1vQckNFZ/fv4IOhBzUvMur3ImbWw9Klb1Yy5wl96Oeritm+oJMbGYvdEw
	1GT6vOcZ5EZt2K6opz9h2FTA1Fg2gb6TZ0EDPwlbTHxwtVEsmTaevE8lFF0cgsf+wKwqUfl5n4H8e
	UGw11Ckw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyQE-0007MR-TS; Thu, 06 Dec 2018 18:30:50 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyOu-0004ok-Pl
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:29:32 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N5lvf-1hX5OZ1hM3-017B9Z; Thu, 06 Dec 2018 19:29:08 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 05/10] staging: vchiq_arm: Register a platform device for audio
Date: Thu,  6 Dec 2018 19:28:55 +0100
Message-Id: <1544120940-13716-6-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
References: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:ylzcCtmw+CSH+rNx4OFjaz4plOoBT8YxU8DNeUuIn/bm5vP8juS
 y3e/sF5qP8xw7aG1FpVd3OfQasPfzMZfz0s4tBrs/qpaYEwTFqocbuhRGTjMCVckf+YIJ2d
 rUzdRPSjHrzkcRDmbX64wi/drOqSBHD+lzixcfthOTElJ8835rK724uqA9JNjHxHo6Sy6iS
 53BLjiB9l1+uHEa0Jg/0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i1LfEnlFtzY=:S5Kadg/ZJ6FKJ3b5KuOoVD
 ynpiwHRgN/ckerh4bO+xv74/4gvSmdJEHIqNTuiuuy7qdli1lSb3F51tvBIPxmI/pNlHMyKzz
 LY697phoTa0i0dSwegc4h55cPmV0lCNbsbRDM8ecblTGdFuPkBqlz3n+SFLKVrFHGPcpfm+XY
 FjB4GEdDKTwcFQao95DX+p4nCTpGoaD7angDo4flwPofJb1E1Y0mcjWjG96Qp0PqieuKzXoRt
 T55W4c2GtohnSezYM4zH+pqIC15RoYGjc/PiNEgCpvt9rr/JI1xk2FsA8kI9/+64oayTrNcv0
 XCSskvYrJJmAEKigVnrT+HS5wO5GZtamrLuVo/Ys9XlJ66JEZxNGDcxgZVmrmiwYvbVtrxcXH
 LPUgWCh8yWL8Ce3A+vF3uwvvmNMNwerU3IJlBacAsqwWlYCxxnMGxrF2M8aXlRy6boS7xv6wd
 t0uacFHqjRYDlE+8ZuH8fFzpH26qKNbjUd9B290ShVENPwefDOi2PutzZW0fssV4mGpAeGwIn
 8xkV6J0qV4yBybCLCZHJfZZx9NDuiIj3ZgoLHf+Wmfk4g1CuFdGzFwZReJqh7OlafF9KdueuU
 iAmdqMJcd7nC52dC4EAvMifI0oupMoJa8SIw5kxkrKFH5I9lxeocHTO3YEM4xF/jeyBvoHqK+
 6cs2JqX5QVAF4HMa29fnVBlMJz74hjIu8oA9GsmQAsASVTN/0D69Pm64CiA59mPm4B2a/Gm/y
 lBH2PLJasCDYhB106O8aWRhuYb14NA9kj6MBa9z+vkmyTPa+JdMgofuw1I4=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_102929_173202_84AE9AA8 
X-CRM114-Status: GOOD (  11.93  )
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

Following Eric's commit 37b7b3087a2f ("staging/vc04_services: Register a
platform device for the camera driver.") this register the audio driver as
a platform device, too.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index f2c1dcd..b6cd0ed 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -167,6 +167,7 @@ static VCHIQ_STATE_T g_state;
 static struct class  *vchiq_class;
 static DEFINE_SPINLOCK(msg_queue_spinlock);
 static struct platform_device *bcm2835_camera;
+static struct platform_device *bcm2835_audio;
 
 static struct vchiq_drvdata bcm2835_drvdata = {
 	.cache_line_size = 32,
@@ -3553,6 +3554,7 @@ static int vchiq_probe(struct platform_device *pdev)
 		MAJOR(vchiq_devid), MINOR(vchiq_devid));
 
 	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
+	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
 
 	return 0;
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
