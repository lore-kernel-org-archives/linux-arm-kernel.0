Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D9BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:22:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E1F2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bgyC2D66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E1F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=5jpJY0dNMogGB/TG41KFL8/qFc/3o5qU1W5fZ+d+k5c=; b=bgy
	C2D66fAWA7QSxaVhyRKUD56dPx5o8v602L88aw365RGAzeqj8avfsVPFku8xzyh8aZ3PlGgV4adVz
	6muclyyqs+NCvmUi3EqMcJel0Eea4mOfguzEdyQgaHStpflXgL4jV58sZmP5RXxlFJQ1O5LvWncVi
	f4RikcvVcQ+7DlsRMgVVKCavUOQ3INfGS3WkmkK8gd4/PPm6w08lS1+MgVyQY6KL8s6cQ7oM8nJXU
	Kzv4TRjDbyhlmfkht53jFWm1/FVBOQW7H5zrIcAHXsAaviCn4NGV8cUV6GDxp0nXkhmOe3gt4z8lx
	drQoREJti3KQiHAZ6tVEN7dzIf0UhPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKlM-000822-1Y; Fri, 07 Dec 2018 18:22:08 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKlH-0007xz-1G; Fri, 07 Dec 2018 18:22:04 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M89P1-1gZRM10eh9-005KFE; Fri, 07 Dec 2018 19:21:46 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] soc: bcm2835: sync firmware properties with downstream
Date: Fri,  7 Dec 2018 19:21:10 +0100
Message-Id: <1544206871-15725-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:nfbAXdiOlKT/ZX3I796r8cIOkLs79/cBRb8KQjiUVXUhicWUGAh
 AcCJM7FzihTqc0NE4gsYvttG0wfbGKFjtWK+5s2zq6rgU//YgYzh1rJzPOZGtsRySG+snyU
 MiXBx4Qpawm6TErekjwrs46dPpEV7pX0wnEMf+gpXWh+sE4phUdSC2pVD9xarGlonM+hLVQ
 7fHqgSGzWBKm3ZqdoMPAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KADwGLwISJI=:D6iVA7IdsEnICD5clII3Qf
 Eyr+fUjjprQSYE7d0qetLBi7noe9WrYXwItW7SLToFBsmG0YypUIp4j/g7608M8pRasC5CepJ
 IWAJEkEcDWRvQ3Yxe8CynC81cTllCtD3QZRUFQ8oVwGsPdvEDU/SButS7tW3RT0RmkQrbvMJt
 M9vQ+PSr769FqtIOuFyXBJcTzjd0MfYMXE268UJW/tdeEs4/eEUgHE2EsI9EPq/DDiu1dR11j
 HKg03xPEFIBXmpbpHJRjAhEl5XVZh3PBDDN9pcJb2Y/5enKoTdcpjQ8d/xbhXRcg18hmXCtfG
 KeylXnK8eS8XSK0qdZuGDW1M37mkrdc5B9RSym1mFl2xU+N7caKXMtj9lZBJAwJfp0I2gclG9
 HtOM6m219G8d0DRJt0zS3v8bdmvIbkxtR9GA2+UF2dwnMC4MC78Pkep2njynAdL54iUXR5i96
 UNDJbGaqtt61FbMPSmVx0H15qa5iFxdRWuvvy7k2UEXC87gth702b4JmvjdrYPfaOTO6lvDd6
 CBv3MpMNjznv1vx5q0lIKVT0Xy4P1qCpLxz5iC6iZrI+ZUg29UKJ3qXSBCfPS+HVimfRc26C3
 OM5r56lUrdR3H8OasjiwiJb+L+4Of1EZ2GJn6HMLjszPaVVxTvF22SsN1z/E+whVz7LF/SXFV
 oh+/E9tNYszSnbk+MWUUADRqOvFanQGvTYwwWBhTc3ndehaTZaKaeTBngdQm4PMrdKiGbcjwS
 wiCAnQEU4vqJYT1WsGgQ/f3AH0NINZSFeboXg6rbEfSwEsi7co/drbQ73AI=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_102203_373874_4A588242 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add latest firmware property tags from the latest Raspberry Pi downstream
kernel. This is needed to use the reboot notify in the following
commit.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 include/soc/bcm2835/raspberrypi-firmware.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 4be1aa4..7800e12 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -73,6 +73,8 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_GET_CUSTOMER_OTP =                       0x00030021,
 	RPI_FIRMWARE_GET_DOMAIN_STATE =                       0x00030030,
 	RPI_FIRMWARE_GET_THROTTLED =                          0x00030046,
+	RPI_FIRMWARE_GET_CLOCK_MEASURED =                     0x00030047,
+	RPI_FIRMWARE_NOTIFY_REBOOT =                          0x00030048,
 	RPI_FIRMWARE_SET_CLOCK_STATE =                        0x00038001,
 	RPI_FIRMWARE_SET_CLOCK_RATE =                         0x00038002,
 	RPI_FIRMWARE_SET_VOLTAGE =                            0x00038003,
@@ -86,6 +88,8 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_SET_GPIO_CONFIG =                        0x00038043,
 	RPI_FIRMWARE_GET_PERIPH_REG =                         0x00030045,
 	RPI_FIRMWARE_SET_PERIPH_REG =                         0x00038045,
+	RPI_FIRMWARE_GET_POE_HAT_VAL =                        0x00030049,
+	RPI_FIRMWARE_SET_POE_HAT_VAL =                        0x00030050,
 
 
 	/* Dispmanx TAGS */
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
