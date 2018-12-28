Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40E1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:10:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90414217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hz5bw2af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90414217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9YXmQmVpeNIA1dn9vFLAu8XofCZip28sezbIlyVbp3w=; b=hz5bw2afbe+RoWavpDk7NsyY/4
	bPitKId+VtXVv9keLKn8N/9HrekaiWz/y8gRMI6gQngD2Ps0caWU52jKQkQNZnF3lmeoq0TDsMujD
	/CDn1SwnBvNSsEOJ9uqjv9BZ7lzplWvi3obDbZu2alDYhqBnO2vTie5zMGFrjC4fUoyEGoQ/trxHo
	AYFrhEqbpDEGjhlP7XwOtCvArJgblk/uzTOqerC843jB7KBVfyotVYsHp7GJfiHhj47/lyYp4pdpt
	ncg8q/6OALbXGjGeQinw0b9HaFV2+IJEJUH+OV7CWtuvGWNdz9AiVnQaqmVR8IjDan5aBtDixSRq6
	OHP8Qbxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd0LC-00011H-Jx; Fri, 28 Dec 2018 22:10:50 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd0L8-0000zu-OM; Fri, 28 Dec 2018 22:10:48 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MlfCm-1h2kRk3ODq-00im9T; Fri, 28 Dec 2018 23:10:26 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH V5 1/3] dt-bindings: bcm: Add Raspberry Pi 3 A+
Date: Fri, 28 Dec 2018 23:09:25 +0100
Message-Id: <1546034967-2427-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546034967-2427-1-git-send-email-stefan.wahren@i2se.com>
References: <1546034967-2427-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:tTikEC8OImMZ2BvxB0SUyXWxzTmrpt/+wBeHWsE2638aJ7Xcm8V
 y4AeCpJ/tGUWzZdS6isxEWGxiiVY0BMrMabWQkK8VyMtL0rMba6+5PEaz3acQMe+zsnaQfc
 pm2w6wM5mNMAL/jh+GybWFva2eVyBGFaO6qWhFa5NkWXLQ4Dnv4lFaMjCgy43nbueEUB6GG
 TphJKAYNdbDHMcEere/rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vKgvvGbSUnw=:6GsJ8XSYuY0wd8VYKFIUS9
 9/F7lD+0wZyRX983rYwnqoksN8yOYqyOOTt0wxt50V8hwXnj74eNQmdOtGtGGPyFD0b/t9GHc
 LGIeRpOZ0T9RSMo7azI1ETYJ9mYtoELveBOrMWCO5g4PqeHx9JdaQyR6SvPdyq+2GkKGgcNG0
 ggu+Q0imCiqiFv4U3rlmUzEx9lsT0pKgKhVf6WcitnWWjl07W5i4IgT/i03DWGXHM1m+6nZ1+
 cidn3LSuZA1xXAtdkrG66YNLY4YtLEUNClyXk7Bw3cPo4RygJ2rmmmyuto251sPgjh4gBStHT
 kdqT2WztqMRuRyjkRfngo6wmki90xWASAV28VXC894wTnOPj4dxfeb0jaDeZ4HVsAvt/VKGIa
 OaTFnbySc6OI6KKL3O5H4XZlk2U92Oh64S6coC2jncq3jUdaVdqH3pQpPZbHKkgmzCRVRt0FW
 GHbcAHCzKY3OBv+yYr7CcqzPBJ+0GQL29Sp9a/3U7NfXMxcvkT739s6q9R35+FKfS6NULP9jK
 qEKbjIyjRSAnmOlmQe37TrA+eI3Ry0gTVubylCC3PCUrqjGevCgNYN4JppfKupDFZprwfp2zN
 YRc97IQ2qwPFzrG9YYxQx6HC47vBwkviP3gXrfYWWjgDBVUg947kJ1T2jhSo00D3rQtlktyRo
 rWxDRoonBKNJAHIjliIG20tBCTviZHyN184Q0oVyelQYM0b+wSXJTX4WVt21AvC8MFiaTgxm6
 Tz5+eFyljhAXn3cgq2kMni6LS8A73Aj1G3S0YrR/LRDR/wyhw7+V4xl+2tg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_141047_101463_FA4895CE 
X-CRM114-Status: GOOD (  12.14  )
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

This adds the root properties for the Raspberry Pi 3 A+ .

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
index 0dcc3ea..245328f 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
@@ -30,6 +30,10 @@ Raspberry Pi 2 Model B
 Required root node properties:
 compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
 
+Raspberry Pi 3 Model A+
+Required root node properties:
+compatible = "raspberrypi,3-model-a-plus", "brcm,bcm2837";
+
 Raspberry Pi 3 Model B
 Required root node properties:
 compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
