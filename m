Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F4DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:44:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4432086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EChRrFhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4432086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=iilSd0gcaohejI3xv9TFYwe0Ye5T4Hj2qEiikJ8erjI=; b=EChRrFhS2H8yhVG0YOf3+VLeUo
	29RSvYKWOZh+GcalDJ3UWM/CZEcYtJdwrHaiMenV8qMUYBy6r2iQArOPXLm1GLPJd9zl0/XtazPdH
	Qw94tinCP/IiNDsF2KVGaTOfZXJyCJgErY5mo8rqdDbuLgzUDgQPxdjGohAdXPp0klMnWJvg79+DJ
	gZ0m7loO4VU8h14wdkUL6AhWMBkHPxQ5B27NllGmQZuot6yd2t7XUDb0HeTmIVYmADtPojpiddU61
	8OvJ1Zzty1JBOuT7KygeECCkplQCETwuI8xd/7eazeKY6X2fv7SrmYQ6d+kd+x/bKHf/P1ZsN9q3N
	i2NiAeVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giIeF-00062b-Vz; Sat, 12 Jan 2019 12:44:24 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giIe3-0005sn-Dt; Sat, 12 Jan 2019 12:44:13 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mhl4Q-1hCygq1uFM-00dryz; Sat, 12 Jan 2019 13:44:00 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/6] ARM: dts: bcm2835-rpi: Drop unnecessary
 #address-cells/#size-cells
Date: Sat, 12 Jan 2019 13:43:24 +0100
Message-Id: <1547297008-2740-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
References: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:yDdpCIkPnWlSJ3Z4r2bhobta1joQXPe/STSUoa5WixjWPPfwU4x
 udD1CZJtDZmEvZlnaqaRHT4DqTdIHV792iu+fm+onzk7UvvWYMlb0P2c0Rkzu4pjC7tuuGp
 XUx+e3sR8fSFxWI5TPznbfwdv+dbw1XvVxA5j6lk3lXffzbAdI+a5nwaz+Bt3JdohJuHX5h
 zVUCl3UpS4cdhRe4L9sHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h7oJyWPZWx0=:ewDE/uI7sLXJeiCxFnPOir
 SBRu7BIo3HlO1tRgNHNtWKAuFLULv9iHVzKOznUNe035Cf6xR/YrwiTHACEQoNeSoBIlXTxUx
 LR39u0hBZv/m9/ZW2g/M0IWThJPdatMo5YMuQXtLxf/wZptjgp5ICa0ZD9Uejxs94PfnH9ldX
 qaIM+OZwVwXPVch1T5/ornZkS5sGQEg5vcWXIpxAlszTNI+y8+eWRidIBJdXKVF4Y2EagyhO3
 RjjxHS2byfBHBpNWqDxv6uBkelvLnHoRCp9II5d1B+nqaOdlflZJLEM6+CzEpY2Vu+ISy8etm
 K76fzcfFTT41PTlv5KMqALzQ5DdMmBJaZl7TxIQnByVJMk2GreVnXKmSSj0Z4EoBBKeg/myVt
 aS5IoGVb6yk4AvxNdDZs4cSh/PCUtluvlcFIkOnFwsdmC663NYke1vDZw7X5xf4zQhXjV4/Dz
 vfrNrY0mqcaNQtOa5vNqae2KLOb6bUP6O6topJx1MZH8TdzT7MYY2JoMDVEhoogPMHBIc794S
 4MUklcAgzUDJ3ATmj9ZrRrQXQcPs4U30NGCd5lr4A0RmjDd2IE1VMy287C0Z9h8qlhZ7gMFXu
 RnD6gu7B6jT8XLgSqma+Ic1REknHFxf8MgfDFPml9bNg6/XWRBuckwWtLn2mNcGUBXcu56xs8
 UGaZaTa2CSGDYIzq29gOki3LpY6E96lwi09ufHGz7lY1in7gew+KjMsVYsf7MJFMRE4w/YtYR
 s4vtQDkjmmGMtxENGTxX8vqOWM60Xm5I6ERyJ8dxQjCEeuqmmdYQKKgmddI=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_044411_769709_C6D68194 
X-CRM114-Status: GOOD (  12.95  )
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

Compiling the bcm2835-rpi.dtsi with W=1 leads to the following warning:

Warning (avoid_unnecessary_addr_size): /soc/firmware: unnecessary
 #address-cells/#size-cells without "ranges" or child "reg" property

Fix this by removing these unnecessary properties.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e490f2a..715d50c 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -19,8 +19,6 @@
 	soc {
 		firmware: firmware {
 			compatible = "raspberrypi,bcm2835-firmware", "simple-bus";
-			#address-cells = <0>;
-			#size-cells = <0>;
 			mboxes = <&mailbox>;
 		};
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
