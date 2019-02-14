Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A8FC10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:32:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509792229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W79k41VN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhR0xAQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509792229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=W44mwjABtLq/Em90ZhdE81xa0TVdz51oLSY/iTjYhoY=; b=W79
	k41VNhnMxnVnOeyT187iCzDlD35+uzAoexo0K772UK/cmGU69B6gWO8tZ2zipksuBE3ewEJv7M4rp
	QqSCQPZUqndbBpGfvP/I2qgG4UwZM3Yt+k3WA6ErPeJnRVDcUilJwCPPZHuwnIsWSJqtXLWfaETOX
	0fWYcjtQlZ6Byo3071RhU3iXfV4/W8WjrcDczCTAeVCCIMS28e405snWFlRnhzXDKDeIagvsrtv+c
	6HCShNWCZEikwDx9vIi6OkVYBiRP2J6/PdGFB8EKWvEGy3K496OAJ1uvVBAS8e6ip8RVepZ7TLQdI
	BznChE7FbYKMfamiSe5DxloQFaVgrmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guCQz-0001Sh-EW; Thu, 14 Feb 2019 08:31:53 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guCQv-0001Rn-DM
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 08:31:50 +0000
Received: by mail-wm1-x341.google.com with SMTP id m1so5308368wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 00:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=QJEStO10BrnZ2B24LMVFy4GfmZeL/MrbI49P/PhmFYM=;
 b=xhR0xAQp6wqm1ZAu2R5vhtGuvhol4tTj9QxqAsvATX43QHImZafXW4utCoHqIzBO1p
 0Bvml6q+r+axr3EmRwgayNPntvwSX1aNw3etZUGiyDL5F+E8ICqzZfaio11gPhk2KJw6
 nmUSSkvrTRUVyg4NFkQadMgeIfQ/C/ukLVkB0foMhB4wA5MVzNIu95QRzsyIj00QrIdl
 /yzgheq8D1YRKJV5Xy/bZ8tl118z1PIA89KS4MdGUMSaMWRPqBMHmACC1rd/CknAYSyx
 TgYfXwp2nbnhgel0KRFbJq7B4gG1Z/rvzmojZMCExBckkIds0HL2NkQDeCNPSD+LBbcJ
 uLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=QJEStO10BrnZ2B24LMVFy4GfmZeL/MrbI49P/PhmFYM=;
 b=Yy6DsinqmJLCsBeJeBWBd9lcOYvIdWs0BOD4Ur3ZE8x6Yr337gQfOAonH4+dXXGsXl
 4LDpuLzeButpbM9FJbbSJosYJqzOr8bcL3JyL2GryYclXKpKVsM8Gu5sJnN6nCjfxzhI
 QO2YPs505f8eVXrFPOPROCceXBJSPM2njwEsuvjvdzEPzyHz/vvDEHBNs814LpdzwmWh
 Gb1FwV5wQtFrZrxLwso8dEmTeIJrL7BNpRBDcA6kQn8rDYB7b/dV53E+VpfCVJN8r9KK
 msp+OJHAdv4+OvIKbL8HwMQhOyafjJS3QehqtNNBeTN/OrUrw+t9dexC0LfZpcKRkMIA
 IjaQ==
X-Gm-Message-State: AHQUAubFiJsQNTv35CyIkfmQbufNep6VptpjlBObHXBbeGWfcoBni9W1
 r26MB/Nureq3w0O0kf3bYbp9ubCwVTc=
X-Google-Smtp-Source: AHgI3IZ5jqE8J2z5X3FrSGajwzhMwb9UGCvVdSlAcAyG42tLFy9ZOCEZqmei5K2EW2wto16CJq57lA==
X-Received: by 2002:a1c:7510:: with SMTP id o16mr1704122wmc.38.1550133107624; 
 Thu, 14 Feb 2019 00:31:47 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:104b:51c7:1dcf:5141:50b9:8a8])
 by smtp.gmail.com with ESMTPSA id q6sm944673wmq.4.2019.02.14.00.31.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 14 Feb 2019 00:31:47 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux@armlinux.org.uk,
	arnd@arndb.de,
	alexandre.torgue@st.com
Subject: [PATCH v2 0/2] ARM errata 814220
Date: Thu, 14 Feb 2019 09:31:43 +0100
Message-Id: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_003149_455556_95BE304D 
X-CRM114-Status: UNSURE (   9.72  )
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
Cc: benjamin.gaignard@linaro.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Implement ARM errata 814220 for Cortex A7.

This patch has been wroten by Jason Liu years ago but never send upstream.
I have tried to contact the author on multiple email addresses but I haven't
found any valid one...
I have keep Jason's sign-off and just rebase the patch on to v5-rc6.

version 2:
- limite help lines to 80 columns.
- Add  Arnd Bergmann acks.
  
Benjamin Gaignard (2):
  ARM: errata 814220-B-Cache maintenance by set/way operations can
    execute out of order.
  ARM: stm32: select ARM errata 814220

 arch/arm/Kconfig            | 12 ++++++++++++
 arch/arm/mach-stm32/Kconfig |  1 +
 arch/arm/mm/cache-v7.S      |  3 +++
 3 files changed, 16 insertions(+)

-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
