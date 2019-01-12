Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29124C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:44:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58B2213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kQDEHsgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58B2213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vjpemGuYHiTwY3lVr27MSE3qk08LTPB+mT7fxWRn4kk=; b=kQDEHsgOyJYgwJoAIsqszUvTNK
	qDNRRDkkpoSybUM4JebCvCTuHfU9vch79LwwmNP2XY2oOn/P+0vAeX+CqH/dB/ivpqzT4vN+/WRV6
	yl/jqKMBUhmg9vpmpYT1cVaAO812RSYdkr6AK346aTF4EA6Ix2UdEIFyzpHBgRVPGOF79ugqLGfgN
	hw7EZBRfHzDAsEI8a4AkRvVgXsEgPR+FGFXMfRIvBiBumDQwfpkGYhR1mbWPZNt2q9WRzpiHKp6dR
	obJ9eQ3M4evkHqGhkCOkS/CJj1qYVCBts21DMfPy0kGig2XuNEg3mCwMG5X/CWhrRlTOAJgyR8dyv
	CpgI8j1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giIe7-0005us-Pm; Sat, 12 Jan 2019 12:44:15 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giIe3-0005si-Ja; Sat, 12 Jan 2019 12:44:13 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MOzjW-1guMPe0AXs-00PLsD; Sat, 12 Jan 2019 13:44:02 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 5/6] ARM: dts: bcm2837-rpi-3-b-plus: Clarify label for
 STATUS_LED
Date: Sat, 12 Jan 2019 13:43:27 +0100
Message-Id: <1547297008-2740-6-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
References: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:ha5xbI1IFxAJffKbcOahHfvrF1YkGngXGFBvP1qHThi9L3znK41
 E3LIo+wciXqmmRcYNbIp/2j/SNPQwFoXVhFkoUbZvc3mwUpiwETqSHUbDZ0QXMT5k/r0izg
 3J1u6jTflVY67onCtbdQC4Dwi0Ecn7tkZkSQAugY528VUkkX42Mjh3nuqLA63Q41Bohhk8w
 t2t4ZLSQ2KAjRiqaYjZlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ah6l+wHVNhI=:BcR+alMAbkzIsVnA5m9fL7
 ZLSaFsl76Bc/sVrAJ7k5qiKcJYKwjUZF3rnl1efNJCMVTs4iz2r0Im/hIqGOzig19CUcnLbYD
 a6qwh4EqKBn70gaj6hwip7e3L/HiMMpIHUq6RG0iKCvdiWrB1Z/JA22FHe2CrKoQqfT/2LcpC
 F4cbkXW8WRwUgJQW27Gd2zbJoG0//01ZvDocBrxWpsDo55cIcZe2GWXIANvdLxSpT93lp5SAE
 kUWmL3FuOMFWtAt8RjeuZOu3cAyrelKhpg20IdsUbvJEieU1Kd1lMB2Ezt2wpLHxdfgb2JGqh
 azGGsFJ2EfqRJUhMZw84sPP5p7liFyWitRj8H7UWI4GT+4f9vP0DS5njWPuMaqTK1sbfZPty5
 VKbAVVrqWIEJNIsntaUkrdZ/cB6Pb6GEVtkaVeEo3GGLNVmdXPAeTJ6hYa3LWV52HJTUUhhpe
 256fPIWxk+SzIACj6tORxDBO/FQUBwuX7s9BSx1N+edo7XS/LNugJdPULMocafrG0Vz03LA5f
 rRivPe+nrX5zJVg9xCKSMr9i7xshNxy4U0/bEWvHodMyA9pEhaOKg0Ly5D5Ch8WGEW/Y3S+X6
 //S8bjEzpdjFpVwrmr3D3+amyLRTeURFMfrR6ZaSOsWHN/iFvAu6Y03MZIK7jH9pyXhJ90T7a
 Niw/yA3UsmGkMMlY+4jyzhtEwMNNp3ky1610mCQiM5F54+pkD14wlR7NupK5Ia4f+rYuitzve
 zh3V6W8d2v1Edk6UifFIf8fiWs72bTYvkjzcnlNsGnTKuktbrXp4nnJTnmU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_044412_167464_BDCA8B07 
X-CRM114-Status: GOOD (  15.71  )
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
Cc: Gottfried Haider <gottfried.haider@gmail.com>, devicetree@vger.kernel.org,
 Stefan Wahren <stefan.wahren@i2se.com>, Phil Elwell <phil@raspberrypi.org>,
 bcm-kernel-feedback-list@broadcom.com, Peter Robinson <pbrobinson@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The RPI 3 B+ provides control to both LEDs (PWR and ACT). So append
the first letter of the LED color (like in the schematics) in order
to clarify this.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
index 7d65013..d3ec6cd 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
@@ -42,7 +42,7 @@
 		#gpio-cells = <2>;
 		gpio-line-names = "BT_ON",
 				  "WL_ON",
-				  "STATUS_LED",
+				  "STATUS_LED_R",
 				  "LAN_RUN",
 				  "",
 				  "CAM_GPIO0",
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
