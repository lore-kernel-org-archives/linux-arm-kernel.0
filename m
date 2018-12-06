Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10178C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36FF20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rbq1hU1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36FF20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cx6xiRfpW4U6clOJeHm6+vCLPgC0GEYkSPu36pk9gh0=; b=rbq1hU1HOojMq2E5d9jNYf+LYc
	szHbXoCTfJ+OFHcq18649PiiSKmXmCBnnd2h+ryGJuZycgRpuZtGOJrrMDQf9n+0PEHqosnDw39Dr
	6LOTAkzFxU1znkh6vlnuWISQksdnquddvgI7vG/ZndYvn7J6yCCSNRKL/npZRvjw532ABk01Y5B71
	nzyoci5so6nknB734y2335sZcoM6U7W1KHZjYV33S5CVdx3yeUm6UFdcZaR8aBCXpFNcVCfrOX7Ra
	EkXRh+YH+dAFXnlt2bHsGL5qr5XNbBx8CCaw6MzETacL1e/nhZTj1DaXxWYNRXaSUGbi8th0gGSf5
	Wy0F19BA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyR0-00088g-6k; Thu, 06 Dec 2018 18:31:38 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyOv-0004ot-IW
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:29:34 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MPK73-1gpXeI31lF-00PcwN; Thu, 06 Dec 2018 19:29:07 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 03/10] staging: bcm2835-camera: Move module info to the end
Date: Thu,  6 Dec 2018 19:28:53 +0100
Message-Id: <1544120940-13716-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
References: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:pB8Hkjk/juzrdGos3gGxmcSj8goktZxtCwcwHwrEiMCAb+WcPN/
 bzmoPOj5mDQdyVbVXxvveLUuNMxtvfwwEHLWSLo1rZTLgaYhmKEThyww3XYh77+bFziJ/Bq
 NKklGn7c1K1WmnwWSI0AjpDq2qDZxYyB6cx+AyeJc9F1XRT9xxcEbJf824N9eeFOgAV8Jxb
 iUvWrpw3YHZSotXUy8+2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TqFJF/GlPs8=:2vt59bXwOKvKABy78nTJ9o
 dCTeTYCpvZLdswC+EQw+jJhBtBZi1oRK2V2OAeYVbm6Wv5Xoa2TSw6slW7XTRvWRR6VrCJtzO
 oQ8mkLvLnfxetimuXHew/S/sQwPYruIii1PqE1WjWpUbS+10ycePfF0EM9eq58e14UzWk25zT
 DAXT0+fGzmOYzQhkGpkO5lLaBTkUgKLcgsIy6bvin9kvt0xemBYMkn8v8BRtnxptz1euxIe7T
 6z6dZaNMezfyiO0DovKNZzQAVaypOqqTuaS83Z47gYgYkogKKi/GMUYYA+4Q6tI4tCCT5ENN3
 Px9vhK7hMwjks7nIXBlodtbPg3ZZ1Z7GPM1t3rKwd2plqjQPFj3g4l6FcSlDbPU6u2s34rvNY
 k3spezMI/HGaedLxg+tVp/X8gmrRjmWF8s7RLGkdscLNfM1dsX4TDE3K4gE2I7m+VQbzU/EHg
 feSdzbadhhktWIcBr+3fQlheLAVahT3f6Eh7k7gJKAs9bbSH8YpoEDyDlXULLKOoZUIs6AW7f
 jj1Ee8TN85U6qrm1TautnlcqNBx+JEiHrna0diVDTZv+B7geyCg01oGyDAvV/fBeyyLundrFb
 9UEjgaiZI1uGclULgdZ9+bcuVkpwfIz4BI5UJY4FmakEEekpHPHbkJc9CF7X5MzLYTAWXvC50
 NhwQxBK7AfVgK9HbnKS024LhYniY38hzTd35Hao9oU3jTJbVVX2FvJ4n6OtiGIExXrA42Nfrq
 zCUjnFOSgp5vwmQgvkQr4hy70Mvu/4rr+0VQU6nk0Tc5kpCAs5QN+btPRwY=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_102929_904367_A64329FD 
X-CRM114-Status: GOOD (  10.74  )
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

In order to have this more consistent between the vc04 services move
the module information to the end of the file.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 7d3222c..cd773eb 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -43,12 +43,6 @@
 
 #define MAX_BCM2835_CAMERAS 2
 
-MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
-MODULE_AUTHOR("Vincent Sanders");
-MODULE_LICENSE("GPL");
-MODULE_VERSION(BM2835_MMAL_VERSION);
-MODULE_ALIAS("platform:bcm2835-camera");
-
 int bcm2835_v4l2_debug;
 module_param_named(debug, bcm2835_v4l2_debug, int, 0644);
 MODULE_PARM_DESC(bcm2835_v4l2_debug, "Debug level 0-2");
@@ -1976,3 +1970,9 @@ static struct platform_driver bcm2835_camera_driver = {
 };
 
 module_platform_driver(bcm2835_camera_driver)
+
+MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
+MODULE_AUTHOR("Vincent Sanders");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(BM2835_MMAL_VERSION);
+MODULE_ALIAS("platform:bcm2835-camera");
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
