Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38949C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:45:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F692086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ERCcXLwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F692086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FGAnBmb3C+XD38TkscBbWtKoHxSLGP5xWqQ6ieBTwN4=; b=ERCcXLwSEEYf/jvnRCw9D5WSgM
	gSBbwrbWIqU74vqxrvigHSadclvJOnHRG3uSNoJfHQHQRRs29StZhCaQlrDRloCkrvAmqoGSXjvnY
	bJYYwoTxG0/J6+2WzX5n3HLyDMnjUQkFf7n0krRBWUM7aDZHn+lwI4HBwmJsolb1AXMUHOMRAcjDT
	Vp2z/TnooV1dbFteuZi80a+fvUl+7nfalHT1tkVOhQtdLkLV+mnWQKp5ovEZt+TS3MHNdmI/woKBM
	XDLADnMyWUYNUu9Vjj945Uqx/wAAX+hCInCBKB8+9pa3iTFKCfV24Tshm/PsmxkcP1ukN+ZbWOvh/
	NP6AlovA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giIfe-00007X-2A; Sat, 12 Jan 2019 12:45:50 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giIe3-0005sj-K0; Sat, 12 Jan 2019 12:44:15 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N49Qd-1hPmUb47ST-0101Wy; Sat, 12 Jan 2019 13:44:01 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/6] ARM: dts: bcm2835: Fix labels for GPIO 0,1
Date: Sat, 12 Jan 2019 13:43:25 +0100
Message-Id: <1547297008-2740-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
References: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:QJCZ1BJqaup6vHEhzK3pWfsZUAG8j96znb+fC6R3hbojjx4PWx5
 Z6jL6mXzJTtOs3gaL2F5sTuT1mouRrms1+q/sy4YvDuI+b3rTMlTTrDNY0lusedCTF/WB5X
 wxUsCoCchR+9YKiIVE7LibdIa149w6WTQBIz1ok1OnamK4CzAnj4u3TGeGjlJVAUy3xSLwf
 V5O1qaxp4Db2F7NXXjqxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zL4cEz61ssA=:De3HcWXpJsDH3ZFrbhrFaI
 bVIr/ZJy/dQt+7w/A+/+oSJ842N+lmEggXIpODEdEpn0TOhYEEicrCME4OczQ78IH+RLIwTpb
 jfeAG7sH6kU/XSCtULAH3XVVWZ/6c4B8cFcjTVf9qq0Qa9C1/9Z7ZdFQAp/IDAeWnf+TQ1DX3
 5GimZwbwKFAghckAyiUHYQw5FI+3R5PuhZxLdgTHb3BQoY/3C+CZLwr6SedMChZTZ/oAQ6yB1
 6dH8DfYL1KyP3a9MgHaIQg9k14JgvMLKGQGAezJwy6izQTpUtVOStNSeuYtAQD1Y9iQXRmTqW
 sT/z+FANDi8l2GANh055aoj+WFkrR4lM5pXOoa+2+AdDRaMOJbEf+zY8Xmzh6AOQX2mI6lpuX
 BgAV6inaiUdxPHGcdJEW0251Q84o7JLhST1wxF2DouHIkNZBJnpePgXnIo/9er2UyOeedDHq9
 juffppkif/MCGaW35SeUUO9Bk+S+L7euq5xytDJ7BP7EZC9MldSrbl4kj/e+9nhLjIzahBEw1
 1Vue9o55EQ9yEBYF5lIp3yqVAxlX4jz8Ma2wvWximaws5ZtwfEMYMcsvHIcKAMyPCY8XjFCHo
 87ELVJ/NeUId5aAsHrS3PFjMNk7pmbDBUcKaek/G9mG5hnU6M00tFuloRNEn+AdSyDEUWT8qx
 5a4hFcYA/3l9PAv5H/AMlvf0jfBg2URQkdSSTYdwo78Uou8NdzpaXmPCUafhhihGQjGVv8G9o
 JZRk736AaIB6AtHXON0PxjAZRPf9k9ln/+x9MQ5RUqs0sAWcPSrIVUVV9GQ=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_044412_170278_2B8BAEEE 
X-CRM114-Status: GOOD (  14.47  )
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

According to the schematics for all RPis with a 40 pin header,
the GPIOs 0 and 1 are labeled as ID_SD and ID_SC. In order to
clarify that is a I2C bus, append the third letter.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 4 ++--
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 4 ++--
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 4 ++--
 arch/arm/boot/dts/bcm2835-rpi-zero.dts   | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index 2cd9c5e..db8a601 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -31,8 +31,8 @@
 	 * "FOO" = GPIO line named "FOO" on the schematic
 	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
 	 */
-	gpio-line-names = "SDA0",
-			  "SCL0",
+	gpio-line-names = "ID_SDA",
+			  "ID_SCL",
 			  "SDA1",
 			  "SCL1",
 			  "GPIO_GCLK",
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index cfbdaac..1e40d67 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -33,8 +33,8 @@
 	 * "FOO" = GPIO line named "FOO" on the schematic
 	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
 	 */
-	gpio-line-names = "SDA0",
-			  "SCL0",
+	gpio-line-names = "ID_SDA",
+			  "ID_SCL",
 			  "SDA1",
 			  "SCL1",
 			  "GPIO_GCLK",
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
index 644d907..5765d34 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -40,8 +40,8 @@
 	 * "FOO" = GPIO line named "FOO" on the schematic
 	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
 	 */
-	gpio-line-names = "GPIO0",
-			  "GPIO1",
+	gpio-line-names = "ID_SDA",
+			  "ID_SCL",
 			  "SDA1",
 			  "SCL1",
 			  "GPIO_GCLK",
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
index 00323ba..3b35a8a 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
@@ -28,8 +28,8 @@
 	 * "FOO" = GPIO line named "FOO" on the schematic
 	 * "FOO_N" = GPIO line named "FOO" on schematic, active low
 	 */
-	gpio-line-names = "SDA0",
-			  "SCL0",
+	gpio-line-names = "ID_SDA",
+			  "ID_SCL",
 			  "SDA1",
 			  "SCL1",
 			  "GPIO_GCLK",
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
