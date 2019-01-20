Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1F2C7113C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:07:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437052084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q0bKks89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437052084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=z7vvzsau4u3db6Kqp0k2cpUE+P21Vbm7ozsHS4xJajE=; b=q0b
	Kks89WSKOm3MdsAJpdzjPimqZM0ed5HebhC+FM8GOIDlf7UPkxtumuXJRhFuIXUuwv5TVIJt1ZxQr
	AW2M3qisifV7H9Wmh4a3r+6RJkc3XdrWWpTXYB6JGLj7K9R1n5b4x2vSEdm8fqaQdPQKzB+1UHpy5
	m1lSTSlueZSjSeJ+8aRzsMEYHV1jzl06sCsSpTJF7E9XZikQKc8qTbUVzBUHeYOlIe0Bo59rTWSTP
	CoQB26lxCFuP3yqXYHVrQn+bG7P8q38OKmO1ViZxkOzcMXFCVV1B0oMKXjc+7M4KHJJcghFYW0TV4
	gYnoUCzKuWZkGQglUds4qcGA0E3v9eA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glGYh-0005f0-9k; Sun, 20 Jan 2019 17:06:55 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glGYa-0005eS-Uq; Sun, 20 Jan 2019 17:06:53 +0000
Received: from localhost.localdomain ([37.4.249.120]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MOiLv-1ga4YN1i2x-00Q95c; Sun, 20 Jan 2019 18:06:36 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH] ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl
Date: Sun, 20 Jan 2019 18:06:00 +0100
Message-Id: <1548003960-4807-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:WgD2iDpFuNdK7oTt7lY4p5oLL6JyG2rIWFvJbNx59VEMcDtW/mt
 +YcA0A2x5/CYTzrVPzZrX3irIojdbsj9yxbh1DM5G8wacFvf3LD7k5nOTT/VK4oUHZ/sVYz
 mE34IaFh5VJo/t5bpFNd6/eVwSpkcrMX40kNN8kyCUhTXjbJF0aj2Fd7T2dWFxtR/MYFCCg
 hqWVL06b2KSrL0Ysn8AtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9LzhaZyf9Vg=:eiYVWaMmoQD59rPoL0z9zj
 /Umb10kmSoPHRB+fkOm2SqK37bywt2mT4WHZTjNM2i6W9OpbYMvGbw3hAe8uqKGJ9+svSebO8
 CYCkUdkTBzB5BR7omCJnXRBngbqzmdwU1BT0UwJURhsIVnoA2ciSwFtFLSW5iURUSjrR2YUYq
 ZE7K1HtviAZWT5rZBrXY5RyX9Fx32E/jjJEW2YOChfJ+xyw21uCkthxHgsOjnQbPPr+jerTed
 TvaSf742NsyrNVeeotUkhQsG5ph3qiRS6D1oKLUDC6HG7GsW9FRUdAnxXRqsa4wGWa+P6A+HQ
 /n8DHqPUxg6mFlDCFn7Sjp5snllHG+VPA9EJqA1ezzmGp2Y+sgn2HZ8buDcKM/6VaWk/vpLpg
 imeDPRurl4k8KWRYgag1AGHportz8iN3bmh0X1jYrhla27HNgQrzQ660n7vr30o/0hE18nM2u
 ThY5afouXsJQP0OjsqF9vVk0t9OBZCMWeVmIUR+H6rXUwamhDRlJrBogSqQWqNXXyCc99rA9B
 W3cI4Zk8DV1+dpdblyTMKOqKPEezH1nCZBkc43kVpVxUqtesPTv9wntl+p7qKjjeR4v0WxEFk
 zzBlSCizlfz1W2k74iUYWTKkfTLRI0jIG9rqt+3TEMR21fh1BGVsV4pOF0okPqiXwWYhkAvNf
 gdNUAP7vHviezruZPRg1AM951NIo9xLQ4tN3GoZWDvI53/crvXe1K+lqR4N9D0poFQ7Be67zO
 8hpZGevG39Seq7GiVfLU19EpAbjx7iV6gsApXkszZsvsT1l6v7TkaRl3PrE=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_090649_293472_103B0569 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There is no need to specify a pinctrl for the reset GPIO. So we better
remove this avoid a potential conflict between pinctrl and pwrseq
after the pinmux driver has been changed to strict:

pinctrl-bcm2835 20200000.gpio: pin gpio41 already requested by wifi-pwrseq;
cannot claim for pinctrl-bcm2835:499
pinctrl-bcm2835 20200000.gpio: pin-41 (pinctrl-bcm2835:499) status -22
pwrseq_simple: probe of wifi-pwrseq failed with error -22

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
index 644d907..6071213 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -25,8 +25,6 @@
 
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wl_on>;
 		reset-gpios = <&gpio 41 GPIO_ACTIVE_LOW>;
 	};
 };
@@ -98,11 +96,6 @@
 			  "SD_DATA3_R";
 
 	pinctrl-0 = <&gpioout &alt0>;
-
-	wl_on: wl-on {
-		brcm,pins = <41>;
-		brcm,function = <BCM2835_FSEL_GPIO_OUT>;
-	};
 };
 
 &hdmi {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
