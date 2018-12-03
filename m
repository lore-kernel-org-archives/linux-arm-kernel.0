Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B6FC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:38:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BAF20848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rDGSACxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BAF20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=fD0YXZJDb+qgysA+UtRtrqNK4RsDAMs3U8JZrW6moPk=; b=rDG
	SACxfefcx44xfX6YSsiWhTUbuPgeZrEFxdY280/h2DEm6tj1eA5+/Ej2v7HjVSYCZIK/2xDQV4OKN
	IPTS9wtb0DkkvFXY/a6lrtzaNHQFj2ph5BB9AOKpzUq99gg6O7y5XsI0VjkJ7WZisluFZdXlJvw0h
	o3xY0X9NjnBxMCiWjYuf1/MJ2oV2JTwPEePgmPhCYnqtHZaC3dRikUDsPuwhEEEIHg987jjE4B9S0
	s+lXQMHDyIQSnmEUnii/vAMfBbHnqcq/KLNz/bHiw9YDT3tWSxK5ndrU9NsLdFXVN5a+vRDhZcP55
	YVwlfcKxYh5fBYyEt4IEz38jp0pmU5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt6l-0001Ur-Gc; Mon, 03 Dec 2018 18:38:15 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt6h-0001Tc-Dg; Mon, 03 Dec 2018 18:38:13 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhlCa-1h7bZ70wVc-00dppR; Mon, 03 Dec 2018 19:37:49 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, gregkh@linuxfoundation.org
Subject: [PATCH] ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs
Date: Mon,  3 Dec 2018 19:37:08 +0100
Message-Id: <1543862228-3863-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:IFarleWyvuYSpg3vta6vePFKwfgi6pkEoMpZlK3f3NpfmftDLnv
 Dw2/ZTQwURfZ+05n3Qn/mGoZu6nysNgoozCvA9v75WTQWiza6afiOrOsMiUEIWrp+gWiDbQ
 Mr6+3VXYexF9xvjCpmkC/iw5CZ+atWAvddqLWrNE8S6rIL76a/cGJ3Vu7nA4XKPSgBmu9BL
 QMIryM5KOTwvHWSb6x5Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xl0jsqqORW8=:Be2UZA5BV8vnhw8McOi/ga
 sJ6r8IHKYJ9PEyASQqEPt8h1oUc4JwhnnHaNDTOtBd/kF4FyuMMm5Y9+NCKZjp0n0RStq7YfE
 CU3PP3eDmslWML98WegswA51aFnwhLRgoTNeez6xlyaY9FPreutlhyV26xtDWmoabkHk803v7
 b7MC2TrmfDMDvRGcDQ+yF40JTw+u2m8WYHEm3y7NWOFbWRXkKVBienmggv55Ev3G6G8wB98NL
 QDnP5bbdvYMBMsWC6RwcuENfv4Le6WqJIm9qFEzucDqe5BjHyphXZa5TZtR5r+y/W63Uq/Nyy
 0DThISJ2eioYamvflOklJlUtdjVUrY+81nfEP1XKNcNW6QeWK6T8GwV7Scs/GMxuRkyTAg00k
 NFdoyKh/pClPfR9R5MooUHFVR3Pe69olDjC2/cHt2jheCFyWfBJc/DtJK87jgGaR8s3ybkCZQ
 61aRoLw/f+me/IzKEc1wYYcjIzcCrIbSiRpNIji0dB/KlijaHeQGKBqGxJNjpd4fkxMx4Ah2Y
 M6MEVXwA7q8s/SxY0QdB2Xq32sz00zIrLyYdNovK3HSJBi5/xtKW5BJ6DL8IwSuMM37zcC3Yh
 Yfdjm2/x71FKN6lvAaof/IDqTKv3qGr0FPJMoNiXg2WDcCdfxFf9JR262D+6GbgSuEmw1SnQd
 MsGRkUVqfWkIP1I5ILFY8HJbKeWkdl38Ox3ME1ZvHl/t21xGSmGy53UMBp3k2GMgutX3obVQH
 7blndPH9YVRjWKYdzKQ+UJ5nxwldsaoFuZd7uhW+vEBYg7AvNbKUjJrx1VM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_103811_767010_36D81338 
X-CRM114-Status: GOOD (  15.48  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, stable@vger.kernel.org,
 arm@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The commit b1b8f45b3130 ("ARM: dts: bcm2837: Add missing GPIOs of Expander")
introduced a wifi power sequence. Unfortunately the polarity of the reset
GPIOs were wrong and broke the wifi support on Raspberry Pi 3 B and
later in 3 B+. This wasn't discovered before since the power sequence
takes only effect in case the relevant MMC driver is compiled as a module.

Fixes: b1b8f45b3130 ("ARM: dts: bcm2837: Add missing GPIOs of Expander")
Cc: stable@vger.kernel.org
Reported-by: Matthias Lueschner <lueschem@gmail.com>
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911443
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---

Hi, i like to have this included in 4.20 if possible.

Stefan

 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
index 4adb85e..9376224 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
@@ -31,7 +31,7 @@
 
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&expgpio 1 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index c318bcb..89e6fd5 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -26,7 +26,7 @@
 
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&expgpio 1 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
