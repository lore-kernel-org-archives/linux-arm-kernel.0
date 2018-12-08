Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE34C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A0252082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZvOZQ5xt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DuHpYSSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0252082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VPBDmZoVxWZoqe3OcYBdVkqlmNmOYsNIJuYsdWmcVfI=; b=ZvOZQ5xtt2N3q3
	KNPgNNBoTE+jO21E2sdBKdoMcGCHM3oreUKe22Eqd73bTgHEP2D9C9WJds2s3BDkfzaypFCc23nGk
	GTNM/IosNmzR4p0mo2dJSFidE57kncYZ1RNzD5qlVt7kq8xUd+HAXBVcbbV7oWYlGhmDD2rpRJYI2
	CLl/ByE/kQVcFfGEan6UznAfdoQS+RxDOIAo/3TiEbyvSnKZySofTxFhOSgLyI0hxLLtkGlYhP1RI
	om5Hk40s71HrrT3kJa4tNNOmf+mmFHGYB990UwVjoWU6Vw0KFEYERTWTVSSegNE46VRYdtTjSpO+p
	qfZS2lalPCt1gFIjpApg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVfl3-0006yu-JP; Sat, 08 Dec 2018 16:47:13 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfkx-0006vL-CH; Sat, 08 Dec 2018 16:47:09 +0000
Received: by mail-wm1-x342.google.com with SMTP id g67so7240767wmd.2;
 Sat, 08 Dec 2018 08:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pM4FAqUmlNQk5CoUyTd1qnDe/uR77MZL4ayRZ464rPE=;
 b=DuHpYSSLnPfY2ImKcn1jNXWNz8BqkY0et3zsd1bze1IERm4cQUwIeVM00EDHff6qyN
 2J6sxik5qqzvh30WtzogVI2lFS3eILZq2A7RBWNNiEDJA8yKPwILbseKGlayPYqWm2/O
 DM/ZwYpPNXI2r4fknEwbm3CX+FDuxG8D+aHLO9qlXrCb1wAiRuF4NszqAd2TZguxhe5G
 5A/P1K3+P4Lnj9/5i8vvI9i5BcY6PhdLIZFlzoz352/GV7RX1BGHkLKzgoPX2BKC27PH
 ycin0ocMg6959cQvd6LBrqM3TUPUlntvTyHsuYikPvC1hf8AgEs2uUIvmXeym6RXYeif
 4P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pM4FAqUmlNQk5CoUyTd1qnDe/uR77MZL4ayRZ464rPE=;
 b=dcm8wVBK7XpFNNzrO0bSliSC7FVOnTGDoLfyO3m/izSG8cT90ACIIt0q2MRROHxZof
 uKFdcvESV+sGfbg/OgiUmh0WfxtSS29LhLaOTpnDphGzRN7skIciUga8WFmd+/lnk1C5
 cRTOBvr8zKiUc8G8cwWJ9xNiqZNyU652j/Yk6ZfajFw9Xm7+Okd/HUPj1Z1UR+hUAPpS
 CKiD+otC6PW5wx9Amu1wpy+AF2MjBMPxjQN0TdGMGQXu/89tVFrEa1Qd6smUPnkOJRy0
 TXYOittMAYviyU9S3DBlnk49mU7tSEX9KnXWhC5WWut77k1LIDahYUw5ckuofjBaV7Pn
 R54A==
X-Gm-Message-State: AA+aEWZd75xHsPV+uz26pvL3EXW2L+ZVIgQmURvKAuFYpjPuGKrx7kIf
 K6iXXaHeW4KNjQRMuEl7D8yz2o9L
X-Google-Smtp-Source: AFSGD/UPq9RtICsuxf6JrvhRkG/J2kFp1Ibcxi8ueiAdsR83/piZeOPtqS0K1WFu5x/JbTnIkZCKlg==
X-Received: by 2002:a1c:6382:: with SMTP id
 x124-v6mr5878978wmb.145.1544287614688; 
 Sat, 08 Dec 2018 08:46:54 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.46.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 08:46:53 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 0/3] ARM: dts: meson: add the APB/APB2 busses
Date: Sat,  8 Dec 2018 17:45:49 +0100
Message-Id: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_084707_438633_5F7087BC 
X-CRM114-Status: GOOD (  10.02  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the APB bus on Meson8 and Meson8b as well as the APB2 bus on
Meson6. This is preparation work for adding the Mali GPU which is
located on theses busses.

Meson6 seems to have it's APB at 0xc8000000 instead of 0xd0000000. The
region at 0xd0000000 is called APB2 or A9_APB and it has a different
size (256k) compared to Meson8 and Meson8b (2M).

Addresses and sizes are taken from the Amlogic 3.10 kernel sources:
- Meson6: [0]
- Meson8: [1]
- Meson8b: [2]


[0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson6/include/mach/io.h#L61
[1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8/include/mach/io.h#L53
[2] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8b/include/mach/io.h#L53


Martin Blumenstingl (3):
  ARM: dts: meson6: add the APB2 bus
  ARM: dts: meson8: add the APB bus
  ARM: dts: meson8b: add the APB bus

 arch/arm/boot/dts/meson6.dtsi  | 8 ++++++++
 arch/arm/boot/dts/meson8.dtsi  | 8 ++++++++
 arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
 3 files changed, 24 insertions(+)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
