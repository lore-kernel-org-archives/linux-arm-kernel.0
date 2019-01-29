Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8ECC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:25:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E35621848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RqrLX7gk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfbYOAd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E35621848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=veUcBtVNR9ppZoRjPhtZcdh1qZF6oLYcrZFQYQhDg9A=; b=RqrLX7gk5OnB8N
	F33Ju+ucyc4MorUtEWxJQ6QMdLoCrNTzmnm93sOV+ieCmRUUPOW7VyNzE9IRxKwdl9g1E3SRVQdln
	fmTyjoPng4y0DTB4W+5iOtdSO5wbluVTrSJf+CbFEOUldPnYvjqnsIK5xxReEjY1VM0JvXLOJ3gus
	dBfMVe8JExgipWdlsxrE5hwEnpcQ761PDcy+aEj8B6jVO5E966SZVH353xi6eXF8DPXXQj7wOcHSu
	4XgDdY6JlYsmuZEspqbctxZhYD96UdWpcbkj7NHDkWE2Fj1BTvgd4qtBPxRv0woqQFMts8m2wZ3pT
	qNzQvY/j7kmvlD8Rkvgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goVGh-00074g-3n; Tue, 29 Jan 2019 15:25:43 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goVGb-00072f-La; Tue, 29 Jan 2019 15:25:39 +0000
Received: by mail-pf1-x444.google.com with SMTP id u6so9788650pfh.11;
 Tue, 29 Jan 2019 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=jsK7RsBEyiyXYTpRVcowXJMK7pXPpcPrFLCk40abBLw=;
 b=JfbYOAd9w1R0YskrDDeyQNsO9kI+q1OcdSDx7Cx6J8BuPlWgBVeTM1ibP2IpmiW6ON
 9UtUyZXufaWu4Qox8H+21ALp9lp2b0PIPm2Ab7u/A5Q/g0kV2n+PCoLmuJU4P6j3CJEx
 ZRxF/2bZz/H/nxFI0Wu8SAHDNEGTbUjSyNsBRUnglupkTD3BUXF2WYHWXeMIVvYMkCp7
 lzncsH7LI6OUcMXp+Yy4wh5Om+sLTrRsqlaa4VFze/fA80ZkKcLnfnQYIO6F0B0hsbJz
 bEGpafa3BREIm56KCYy3Tnp2A7af3U/C1FMkKHrtsUKIDNJHYJ108zy6ELFFZQhQYtlQ
 PxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=jsK7RsBEyiyXYTpRVcowXJMK7pXPpcPrFLCk40abBLw=;
 b=NyzvbnKvaugBpkEPIQMuTRFMpTAGGLdNPNi/v1X1mamRbniLdqhdT+Nd2x+jakla/f
 +vQd1hFQuSg6E+EYHL2WWRGd4pr95bWF15i0Bebp0rlc7tUSh+yTQfg+38O46hSocJON
 z2gzVpxh6rhmYhjF9kuxHbjzLaICRv0ObvqLj6XrpzFcwqinPHoHIcdbPMzheN6m17rQ
 tjHDSgNcP6HCCIhf1vERuP8NUovvom3xNBTe5x5F3I6z3cNfdmuMJwvWuvGuizaogpSR
 iLuwZXbhA04ef8E8oJFRhoDmdkc0hNzb0DPy4By538ZcBVTI6MT2Vz+nAgPqQMRUWCUQ
 bmSw==
X-Gm-Message-State: AJcUukcV9/Z4lSgwIjApBu96lNYkjZTPEnCHjOaeWWtClX8T0qXNSyfS
 3a5dWC5n3+Can+PD5kAYJ5I=
X-Google-Smtp-Source: ALg8bN5AgA8PsSPz1nkOdfK2fC65cTO5rmnS2/nTWF9DHP3MT5Cpdop30c9e2tkykwksKYVBbZ6+hA==
X-Received: by 2002:a63:5026:: with SMTP id e38mr24165629pgb.123.1548775536671; 
 Tue, 29 Jan 2019 07:25:36 -0800 (PST)
Received: from nishad ([106.51.25.107])
 by smtp.gmail.com with ESMTPSA id l5sm57380459pgu.86.2019.01.29.07.25.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 07:25:36 -0800 (PST)
Date: Tue, 29 Jan 2019 20:55:27 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 NeilBrown <neil@brown.name>
Subject: [PATCH] MIPS: Select PINCTRL_RT2880 when RALINK is enabled
Message-ID: <20190129152522.GA24872@nishad>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_072537_732006_C7307B7F 
X-CRM114-Status: UNSURE (   9.70  )
X-CRM114-Notice: Please train this message.
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
Cc: devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
 Nishad Kamdar <nishadkamdar@gmail.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Paul Burton <paul.burton@mips.com>,
 linux-mediatek@lists.infradead.org, Joe Perches <joe@perches.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch selects config PINCTRL_RT2880 when config RALINK is
enabled as per drivers/staging/mt7621-pinctrl/TODO list. PINCTRL
is also selected when RALINK is enabled to avoid config dependency
warnings.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 arch/mips/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e2fc88da0223..cea529cf6284 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -623,6 +623,8 @@ config RALINK
 	select CLKDEV_LOOKUP
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
+	select PINCTRL
+	select PINCTRL_RT2880
 
 config SGI_IP22
 	bool "SGI IP22 (Indy/Indigo2)"
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
