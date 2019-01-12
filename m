Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5E5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:45:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CBF2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VaiRyY8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CBF2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=pMqfB8+/Dg31NExFEdQseot0ioVPhWB+K2E0V2zr3ek=; b=VaiRyY8wYPYSGRt+KZ6P11hxR0
	PIc0bS/Gqdy5bm7gsH1DOpj6NB9xyNphlPtRaUiyRsGGMfV/42Z8cAH9aCSpxfyGXXrZaMq7eoF95
	ORbwNA+SnWXnDURPKTJ6i445cMLs2XuDR7YSUv6qeH9xYHBvbVhyYzcJSC8DqZSwELZ8P6AWApRG/
	y+IL1ZRf8gp/c82TWX+h1rRwgbiTvpv8dOs3cmO2uyuKzKqh+13YcKG913KoHOj3VF5DxCpkrLNgc
	xVbcFldW5+oVGXY7CLjUeGGEOIexvWDD4rnI0oiFlhdgoXdVorEogCNoMkkLV/keEuDrqb/q6Gq88
	n1WR7aWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giIfQ-0008Jf-8S; Sat, 12 Jan 2019 12:45:36 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giIe3-0005sq-LX; Sat, 12 Jan 2019 12:44:14 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N94qX-1hN3Sw2Ced-0165Go; Sat, 12 Jan 2019 13:44:01 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 4/6] ARM: dts: bcm2837-rpi-3-b: Use consistent label for HDMI
 hotplug
Date: Sat, 12 Jan 2019 13:43:26 +0100
Message-Id: <1547297008-2740-5-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
References: <1547297008-2740-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:FR5dWh7Bc7ez/2t7UujYBV6wbjP24rJ3IIBr6DeJzE4EixhKGqS
 3ilshHe46R9iW17IU856fqbAJ+QTgMPdUZbyQvN4uc2gJQ3aaQCzy22HSKBWWrtMxX4CZn0
 4Nglfks85Fyde7xl7tx/zQUEFscUygaRRPK+rycSa2j0GcP+TdQV18NhCzao8PhxFDq8KQ3
 jYwfBwpAwChPLMTBnjDtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W33OjkYlMVQ=:a9YtAGBv47gUQfX/RzJzAb
 18/pyrAjqIhGDroLfNmx5nzlwPNXIjmIJNNSYWOJvh1Jts7HAWWXO0sHfla8wsyuEnAt7LXXb
 kCE5eGyAcAfD25PimxmlPdpafsCHU6+dbnnSHwY73PCQCvLnX8hDkJ1hmZthy33ZLAZvri+wd
 UX3w/ajzz11VzFr8B7z3JgqVFmR9z/HPsMZ1jY+zELeRCBQIKgB2x1pHCQsZizz7iAIX4OynB
 xcRtFG+tl9fidGvMev8KMfdOjPii5RWIwjEhtKqBGmjCOtjQh99JeL8AGQHnuexsDtvrGrsgx
 rgUNfR6QrVgdZsBGJxT41rH+VPxW0SocMxrwXl3r1b+V9EBp1poHFooK2BiGqV/T3pz+7g8v4
 Xb+joSpoOsJOT/6/4e1veQhotEF+b/CRGAYVyIpKbJ0nDdno1Dl89qFQwOFvLWdYaaY5bcbTg
 7vxZmKXI8bwY+tmVDhpGf9r5MemDQWZLS6M9bECCw530bvHH66n5a+ioMJxpIbQOwR5DZgEO1
 b3YhR9k0u9n2Xgl+2eMDwEFRHEi18H92P1d+dL2euVkES5tWOWN8dqinuQ9+gxc1vf7fP2jgc
 k/709lQMcU3/VBGAqrij1OpSjN1RPOrkh74g8IZW3+CCrnOF7GgMFU15KYDSCGHGGFXjmMeqN
 +V6cgbrfthOE6UbkmTohuzsyDRYzUmDdJspzO/QBNIWlG3ubwHimSoDBRVPM1XH/mgTyy6NtW
 6MtW2hyGiz4TVUZytx5wDVqnevttmYirjAheH2lUeSFzi88rrV0tWl6k0HE=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_044412_168490_F7C94FF0 
X-CRM114-Status: GOOD (  15.90  )
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

This make the GPIO label for HDMI hotplug more consistent to the other
boards.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
index 9abb9c5..31b1c03 100644
--- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
+++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
@@ -39,7 +39,7 @@
 				  "WL_ON",
 				  "STATUS_LED",
 				  "LAN_RUN",
-				  "HPD_N",
+				  "HDMI_HPD_N",
 				  "CAM_GPIO0",
 				  "CAM_GPIO1",
 				  "PWR_LOW_N";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
