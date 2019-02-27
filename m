Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A58C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:50:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F31206B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i6IVJ/aw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1mLwZHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F31206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=qaTlnlQoEfca9g/tbYuM8WsmBxolIcZNYoUUVRZ1w28=; b=i6I
	VJ/awHcHZ+Qiyc/Siyvwhi47HQGdboAvL0Ky4g/nUqDTA+tAELBR0qB5I2/PpbTmn1ZmIjOCg4Hmt
	IToJUecqE3Tg4SsULfheRgHIEPcvrJKsq6PSpxF8Ul2qj4HDvEdfXm8qwZiLFgPPdntXO/apJHXHn
	3jqns0fy1eZgsqtiJ9cQ3llG6y2XOBCBzAajwAA444FSOyrTijdrskh7tXHK7LvPoOMPwnVxuu82V
	sqW6k0PlfySbpAs2MNioISbEVHbJOGXztCrFco/BGm1TgJA8GeBQjBnH0SeW4Wh/1jatGwazDCqwe
	5cakwOaRWuxRcd2pANODvcspOYN5zzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz2Ps-0002Ap-R6; Wed, 27 Feb 2019 16:50:44 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz2Pl-0002AB-3r
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 16:50:42 +0000
Received: by mail-ed1-x543.google.com with SMTP id g19so14507073edp.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 08:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=smfytoK1YrOrQodt+CIZ8wrxJHMoZVPL7SHmk3SXECo=;
 b=Y1mLwZHn9gQ/CppnqZM/nk4h7i5UaskrvXi74hlNNs1vsdEttDndcGUKB25pCHJmhF
 ZYd0Yl0Bwtmsne4V91yZ0xVTOGlFs2nBQs5q/AbI2YzWJwiYzRbdQK0M9DKLNEzHMCzv
 SC0U0aKu9YHZtKNwdOzgdIEBQxbhajxpbH2NI6FI2l8WeJjPOz5NxgKLAl3V7+n97BQj
 OjE8ZQf7kKI96/S4uV2KrFRrdpSjME7l5INqIFhtsaFVVd0xL3Sw39o8EqTUi9ecHATA
 wXA5MAmn2Quk9Ac05XzdlQIqpPZAot9YLrL0EE5NLP/XkLTt1mYd/NSudYCywCPJ8qHn
 iVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=smfytoK1YrOrQodt+CIZ8wrxJHMoZVPL7SHmk3SXECo=;
 b=SKA22gz8ARm0r8C/aavHsJ/VQgF9jV2q5Suaz2in5YzPnDPgdbg5RN6nm97batcN/B
 EnASu8fuC5JJne0+BfCrC9g1ejQ7fZ9K+HzMWeTjpb1oz21YI5wSz8J7FscgE8Zl0c+c
 s1jKgBcyD5VDpk78AbYx8SwZATc4Spr46AZjBiAhY4LgklqNhGWv3ZYAOUj7xxk/EjK4
 LgrV7LNAU81M/mJJV4tOoiOKS3XX8BfGKbTSk2UuwrIIGfSlKyubnugUCln4O5+lfTkv
 9Q5U8HpktmQrXj2go+ZNhrpIhfaP6LGk2hbQOkTAaqD99BJgyMArJoOo2rY06145itLF
 juag==
X-Gm-Message-State: AHQUAubNhJfFVdjS+7K+Sdp2/ZoS5owc0j0RDSDkwqsoKr6HyLLbmEtN
 kc1sLtwSPDE8erxx8jF8cZU=
X-Google-Smtp-Source: AHgI3IaKpn6iR5tHGpOuQJTwovtPzBxM7dVYflSHy4rKSDYNP2KPPqu9tnyebDj8q81lAlm7fsxD9w==
X-Received: by 2002:a50:ac6d:: with SMTP id w42mr3165151edc.122.1551286235068; 
 Wed, 27 Feb 2019 08:50:35 -0800 (PST)
Received: from ahersrvbspbld01.lgs-net.com ([193.8.40.126])
 by smtp.gmail.com with ESMTPSA id z42sm4398136edd.29.2019.02.27.08.50.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Feb 2019 08:50:34 -0800 (PST)
From: Andrey Zhizhikin <andrey.z@gmail.com>
To: dinguyen@kernel.org
Subject: [PATCH v2] ARM: socfpga_defconfig: enable support for large block
 devices
Date: Wed, 27 Feb 2019 16:50:18 +0000
Message-Id: <20190227165018.12911-1-andrey.z@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_085037_184285_D10D0E19 
X-CRM114-Status: GOOD (  11.12  )
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
Cc: Andrey Zhizhikin <andrey.z@gmail.com>, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable CONFIG_LBDAF, which is required by ext4 fs. This option could
handle both ext3 and ext4, with ext4 requires this option to be enabled,
otherwise the filesystem is mounted RO mode.

Since the LBDAF is enabled by default for 32-bit systems, simply
removing the current "not set" entry enables the support.

Signed-off-by: Andrey Zhizhikin <andrey.z@gmail.com>
---
 arch/arm/configs/socfpga_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 08d1b3e11d68..c96d93fb68c6 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -21,7 +21,6 @@ CONFIG_NEON=y
 CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
