Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D131C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8D220892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iq2yibP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8D220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=t8AxcZJXiEE/fv4kg+RjDSYflMCKSarEpHQSVaPJW8M=; b=Iq2yibP2OuIg57yeIC0ES9g9U3
	MFwuvTxuM7U24Ng1pm5kbnD+CstnCYgIacr2GsFbKmEwR2wg3sKDZuN3AAOhR0nIvCV4m8HGcLZ+6
	WZwcpOM9c7aGhAuT0ptzR70JKCsNHmqqttBHHZKk08/lU+QLSqxq6TNi7zaRxiwCHOkK5mTKNpYsq
	9vA4wwXuAdesjTz38vVxhNtAVoydWUUxDL+MN7WKWZB6IntQ1brU1A6ZXAd9N5r8nnqnCZHL5GLdL
	0O14bSK/xY9JTv5CuTkUhXGPW3cLveDsakvYbbsvGPYJCjJlHvpMGTCovXoBZEnL32uXw85IktHxR
	PkEyqw+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyQW-0007dj-Px; Thu, 06 Dec 2018 18:31:08 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyOv-0004or-8L
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:29:32 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MALql-1gbnsl34oN-00BtfJ; Thu, 06 Dec 2018 19:29:08 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 06/10] staging: bcm2835-audio: Enable compile test
Date: Thu,  6 Dec 2018 19:28:56 +0100
Message-Id: <1544120940-13716-7-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
References: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:LLqfNGFnO7GtEV5Lql0ToaGmIOEyFi63E5C4n1Hl2T/CV2YwiiA
 36OfXjmvShxAfgJ1dK+KN5REqekW9SCxK/6RzeffxivN/q5AztbHgvdR8nGZrloeGwXPLqI
 QO/zaO6lB5jDx/mB3QEklx+XgPisAywq+V0YIIpAmBuy3Hvshkyj2hFITKyRPdH6FXvTk2Y
 0Q2/Zax9U0TfmcigWoNHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:14WjUjnn2Io=:RdpmTU/54bzZTu9KuVl3wl
 4uV3L69bbWJKg/Z2d7Di+cnsZkjnpGnGCHzk5VdjRuap47b3pBkGrvr6t6g3x9nOxnKoT1QCH
 BTDYcA5Cu6cGCAO4dUjqBGfB0P47etAF7Z6//0qyah4ixZbEFcBLUho8Zb0Hbe6YA6jdPUx6V
 0+BX0AkGF4wN2yPum06c9lsL1Rk0SOA5l1Z+uO/i+DX23tPBec6bMRi1AUDPVx0N+2zwx6SqK
 Alla3Kt/v3qwm1HCpkNpLsuxDIh+BHRBG+AUDkBGpJs8x+tcB3ZnwUUaioTo6AmPTfCmevWY2
 w0eL6Gf17C2flEy0uTtMzIj+3Joiv4r9NBeHJOAOVEqhsymU+dUOlUw+E0rxV5PURlCbArcX6
 iDUbRZS+0ZAALEw5V4TbSNpzIPnA0zLuXEqT5hPJ6DJpTUPrEiKadok6rEjcovTEAfjcEHMQT
 MEWuK93kukLcohpHClTgNquw5EJzvhAxfaaz26wrLBUVzFfXfQHizvTCMGXII0VQK+13jr//f
 d0xpc5ZWMs2NcFgU/fA0ArX5a6ryRZm6j2ZluiqbAEywV52U1/XstiyD24KrbAGhEG1eqJvXw
 J5WqRo9YRdjc5MCEG+l/vxc+chBs6ww5omAsdU7JX/iMGtq3D/t3NwhaeRlFGmqex4w+rgsVJ
 OPtLI6EpQRCRpDeWUpB51q8hy7Ec05Wr+l3pevZ+4oMNR/ZPQX4CDFBvayncXctRXeoxmRGZA
 v7SFW9Do/AFdP/jVZHd+a9+9rw+rlmxzW8MA1s3T96AWpy7uicQ72R4xkT0=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_102929_596513_BE927A0A 
X-CRM114-Status: GOOD (  12.25  )
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

Enable the compilation test for bcm2835-audio to gain more build coverage.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/bcm2835-audio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/Kconfig b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
index 9f53653..62c1c8b 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Kconfig
+++ b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
@@ -1,6 +1,6 @@
 config SND_BCM2835
         tristate "BCM2835 Audio"
-        depends on ARCH_BCM2835 && SND
+        depends on (ARCH_BCM2835 || COMPILE_TEST) && SND
         select SND_PCM
         select BCM2835_VCHIQ
         help
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
