Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F47C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:22:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8AA21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="alhaAGgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8AA21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=d6AyqRs+tRK/fschmfAdF+Ujjrm/vJZBIeGWaRWEq4w=; b=alhaAGgnR7tHkpzdThJe7a1l3l
	0fpO5qTxQqtGmenykUyLGdSmYgVJeHwrHCnNUjZhPyN8MxAnFU6Q+o6sey7ID3ZRukmg3tpwtOxNl
	cbKUqUTEY3arXc6ZWE/d+iU+5cvvZ2HIVknLcJJKgIpQi7txjm+VopPbHLAF9muO6fYNQdJnps6FS
	CX1LgvXMkYqwmGQHdWIK8kX1+ejaundewN/urUxpAQSvY0IE6gMd0ReP9TAoInPrJdGkKHcM9JN+R
	1L4rxwVqdoD39cpfwUA+APFZbOrhfNP7h5KjpVycwM0FbaxEe6PMU1OMxgqER/0De346gXX7hJqbV
	e/qshyOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbw1j-00009O-Cw; Tue, 25 Dec 2018 23:22:19 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbw0p-0007al-0p; Tue, 25 Dec 2018 23:21:25 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N6KMR-1hQg0y0aML-016blo; Wed, 26 Dec 2018 00:21:01 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH V4 3/3] arm64: dts: broadcom: Add reference to RPi 3 A+
Date: Wed, 26 Dec 2018 00:20:08 +0100
Message-Id: <1545780008-22271-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545780008-22271-1-git-send-email-stefan.wahren@i2se.com>
References: <1545780008-22271-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:iPfLmWSJdR2Hy7vJihu/aN9xuu2B8QRztOAaZsCRvRZlSdpu1w4
 y/0b3QnlXCCIAXZJUnojoHhYfQVVCdNmxDKlaepB0bsL/ETUcKp3SQfHfM1D5lD9MA4kIHz
 9PNHC202S37pkGgT/h3cy9XZ9sxOvH9uGJU8xuht6eQY/Fu4Lsiz0KYoZim7QRWI0bZGBL0
 9qzfoy8/vnhsWBvSNxSpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:coT9+Ts47h4=:M/EIP6AuQWjv0yjoV+X/aO
 vtk4de2yTqWcBaBXIqJAT7uU9LpX5PY3gkBk7kw8O4ZUrRJ3bVLpAV8u4604aZferBU/nyNI/
 eZbWaWpL+qG3g/hzPAuGU6s0aacRN47B+IJG9Oo5pR+RqvjzcZJyAuG/uP6B2YigsG9tDk6tZ
 tf+ROvG4c/IDELx67SvcG3oiokiMIRKitw1bCWOHCUfGA8JD790snRwHRC/YPkvgGYdMxWUP8
 nQQuQMuNC9FCHy1yELnKOhHyrEDyCpl/bxRLod4ddzkR2UOcumoPhA6CaJK/JDRN57C2wQGjP
 IS+3RifioeRUxlYSgMiB1UuWzMWHMLrPBL98Ef3RldHk1R8eOjJ0ORcCo0qrLVdCZAVoX0prA
 zph6j20cRHNkmHqp8tjiyBCFC9NbotEKoEfkDIvnSEWcVj6/pUuC/lwkl18eW1no1syiFjrOX
 8+FLlfx47xl/l7pooISiHF5PnhAaZOc692OdaHYPKyyrWxODpv5I7wDx3Wr3KyhN0IadV7sT6
 7s34WgsUKUf2iMG42swD43ODZbhY2lcYArkVJaMt0IZl/dE8zipvaIsadfG9CHzH3dS89omXs
 /IWPnDa4dEhSnKxbDjC++FWPI2LZfB4bBgqaOHwILYCeMwkfO9udgyO6+nPhkSe0sJnFSH9v1
 IfATrORC4NwiNyM0d6Do91J9K0Ry/s6DyR//EAGQdNGe8/ixjzhslSfzP++x2ddqgkOhALIS4
 mlo8kGItvMdIgkWN+8gzH4WyNkfSf7mwMVk3L1o8Nbbg31WobQ6+PtEfhwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_152123_360949_243A3930 
X-CRM114-Status: GOOD (  16.63  )
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
 Phil Elwell <phil@raspberrypi.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds a reference to the dts of the Raspberry Pi 3 A+,
so we don't need to maintain the content in arm64.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 arch/arm64/boot/dts/broadcom/Makefile                 | 3 ++-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 667ca98..d1d31cc 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb \
+dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-a-plus.dtb \
+			      bcm2837-rpi-3-b.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
 			      bcm2837-rpi-cm3-io3.dtb
 
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
new file mode 100644
index 0000000..f0ec56a
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arm/bcm2837-rpi-3-a-plus.dts"
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
