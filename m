Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B05C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:08:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E682184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e6Z/0wJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E682184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=xHTSoEsqiRW52qrXthZBZYNqUslobhN4MXZFEFVImjw=; b=e6Z/0wJCO8e1wq+tP8dfADg6mg
	qO1jl9LTWCkIJJK/KTCMN4ZLf0xwrugFeHfkFfhu7EvJtjqjHX0034grFsHrk5mSBH9zdM9Al8bHc
	OcMS30YQo6RFEG74hVi6XvDqFLPPeBXkwYcmp9AJLSHcA6iSgoqAEjHBVgdWD+UMe+W35J1k0YWtw
	YEIKoDdaIsUCx+QCWzIqmLtWqoCeSQ2elMV1FnHLLQFtddFatloWvtaMBgHALnwM1dHgFhv9WV0gj
	rBctnhODajhYm7+dDWOqKAb7t92aMI9U/JNheUUeXL3Pz+dzLVHwCRkxaXNHubzr1AqjnuwP0xxPs
	KloBcYVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmJCi-0001vz-1Q; Wed, 23 Jan 2019 14:08:32 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmJCe-0001vC-Ve; Wed, 23 Jan 2019 14:08:30 +0000
Received: from localhost.localdomain ([37.4.249.120]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MOV26-1gYToD225m-00Pu3U; Wed, 23 Jan 2019 15:08:19 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/2] arm64: defconfig: Enable BCM2835_POWER
Date: Wed, 23 Jan 2019 15:07:50 +0100
Message-Id: <1548252470-17920-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548252470-17920-1-git-send-email-stefan.wahren@i2se.com>
References: <1548252470-17920-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:L9y+LcL/IGLVHD75gC1q79lZ2fxeL1rStsfuLWz8GHEC8Z6jveE
 M+CE3vqpz4G2J3Mmx42UrGkEkEA49eXsKgYprrMp5bXPgU35TyOWU+QFmj+Iz2/8hRoG23t
 5iMrlUFHx4jvbg6mRTlhnb9C+wz6rxfkZmLUXUVy6BS5dTD+p53R4e278OKDhZK4QiMtxPk
 ifW/SdH8VaE48EDLxzAgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C1Nya1+AHOM=:p19N0SW+Wd/HSZYKFS6B+B
 dfy+j2f+4QxqUe3wGiuV9crofU/SFr4HFnG9KpA6qIdQKC/g2c5fWarOfUYsxvTbajJrO+mVp
 UhjkwUQanyUbF9QNOQbmhOLZ40w3EdbeQvO40KosJqY3/fNDMl0GUiEEB9EwY8z8E4ibwwnqU
 ZQTW/5twiXD6ICWnNhTPJ55CBaoo4D+lD1pqFagO3c6MRK9P8BCJGesdfxu6GAXQPTxbBtOGd
 HvCtUqEQQqNTzb8vGQlMQUb2LxOliWcXJWrsoYzYt0coXjDlAaDD1cvdu/T9RtBRun/zZDXal
 +oZyLWj/cryvEjtGqqAQThY+6f8XJqK4AwU9/oYDxg8gl34fwlrVFavm9xkOEO/kLsojl/7sd
 R+M4IlMTfEqnVhdkq3SLJYB9AXEkwnKLnBAvGopTiW/DxEoEL4eSjrX3N4FKgfwAgqBHGz8Me
 p68EXZ3uP5qM7o0OMuN6cRIozK4HvLiCEp1oTqpYpu6ecVWzglKISk6hP3WG1wamMmNX+aLrU
 bI4XiAs5aKUEsW0lVynsd/KuQMGS3JvYckmFI7eLwESwlSA+OwJv6fpczFbyNqiLkupxiukP4
 bfouQnqi+QIb2xxqd/OTCoolw/OcIW+B0hKDx0mT0vyb+jQRx9x2OCoP2jd+GjbagUe85uGod
 Ma/73Mw9nW+UXEx+cFs1XQtdEwo9HVs1ftxdV+gNklhOV6wRrVop3EUN86qh8g34onFunCgfs
 JzmdEjff8t1cUorEiNsHB8N4SjoIxp/TJZuG3ABz+J+q5Mrzksnbs1vONCU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_060829_318335_40D36CB6 
X-CRM114-Status: GOOD (  13.66  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since commit 52a4adbaebcc ("ARM: bcm283x: Switch V3D over to using the
PM driver instead of firmware.") VC4 on BCM2835 requires the power driver.

Otherwise the driver won't probe and HDMI output stays black:
vc4_v3d 20c00000.v3d: ignoring dependency for device, assuming no driver

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6e5af25..ae156b2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -664,6 +664,7 @@ CONFIG_QCOM_SYSMON=m
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
 CONFIG_RPMSG_QCOM_GLINK_SMEM=m
 CONFIG_RPMSG_QCOM_SMD=y
+CONFIG_BCM2835_POWER=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_IMX_GPCV2_PM_DOMAINS=y
 CONFIG_QCOM_COMMAND_DB=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
