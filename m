Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3678EC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:49:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E6F2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XT9eBs2B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="o306QRRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E6F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=91gqtQlwsUcpcMbRDXIngV5RoAdwLnSagN4w6EPWOGY=; b=XT9eBs2BApK9va
	YgIobXS9XViJXfb15QpLss37oCMyVm7vpHBPHEBnPgynWo0l3VQc19qT6njpqxuLuJoQ95pfH+kA6
	Vf+3/WgxXnMSVbtDOBnU03POr5lFV1R2E4IJkfcKTUxbJNRhKIUQPCmxRIrkqi1BIL8xAAgszTtod
	lXJMrIPKDBfd1dZZ4hfr5sjXMTLN3izaGdogjf47g3VbaLE0bOXY2IU2IlNAXEGRd4ZA4dLF3aDPy
	8tfSxuapjD3QgsCTu/bDo42abnHlobzrEKSukQgcb6n1w5CmCYTTdxPuClq9UDXa5soi2vA96pWAh
	N07F3iO2eT9s6vxL12uQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSTFj-0007Ty-3b; Thu, 29 Nov 2018 20:49:39 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSTFg-0007Sv-EI
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 20:49:37 +0000
Received: by mail-pf1-x441.google.com with SMTP id 64so1608632pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 12:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=KEURUI5MRNi1XVpemKzMaWd4JIGbn4j5Y0q/G4sTDGY=;
 b=o306QRRwcaHbdJBiHybjOawkBRF4zhRcZ+SseX01ao2rZL/yqc2rUyML0Dw1ZoYRse
 kQ/u33RupEOZKzClRiQ3XwHMw5xgzgQKFuyS2IXrvo36aSEAGdbdkX5a+Uz9F0diodWL
 P2okEZY1SVsb9Ond7TkOlEnU92C6cJbxhKV+8GHeP2LwpcSGHEIjwK5gV8I06oY39TYb
 E8OSJShuKpAcuqrHEtz1KsPWfvTi3KBz/rRUBe4fiXeVqankoUKOZInrGmu5BVuJzLQ4
 wpz2b5jxjeonHoMjJTV4vn50mCJyoMnQ3suj4UusUuq3hqu2OmRbEbaR8nz+jH8nZAMg
 kb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=KEURUI5MRNi1XVpemKzMaWd4JIGbn4j5Y0q/G4sTDGY=;
 b=j9PrI/wSYqWbkJaFcUQAe98cqzyK93789Wg3iwxeZXjiG9KXqmryNrpCOc3IY6zV+5
 x9Dtjao1BX+868UmQRIYdLTvnLJqjmV80B8bT0UKk2qmK5+MWQtvYguyC7OUrS7dnLqf
 IBT5l8Xsp13JZWmgmb3yHw/KqYt/hcsASRZPOYrrRdSUWVeOFgxrfekAmsO3Izc4sTSM
 GWNzm9zTA7OZmcVooUaa8zAPPTm0sbYSMmgmxHNokMuj5SIaxya7XoYg9SLjuuFpAnDH
 bHD7Pj4hLQEu4s6IrVFF6dKcaUPQbhXsPqEvWGKj2LFi5EF58QTrOTRpx+ZGkT9IVl7F
 QKfw==
X-Gm-Message-State: AA+aEWZtinmgH8tqqnRRT15nSbZTZh0sujVB9HfBJ8WGVh80f4w/N0UT
 cMnWLLipwUzE3JZk4UbzdCEORms1XQg=
X-Google-Smtp-Source: AFSGD/XCCzMhpqbqxQ58FY2YU6vBbADK0B0NrVoETvm62NxKto2Dj9Dh9GfhyRfwt+PhLfBtRA6iuA==
X-Received: by 2002:a63:d604:: with SMTP id q4mr2476055pgg.175.1543524565611; 
 Thu, 29 Nov 2018 12:49:25 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 u137sm8093508pfc.140.2018.11.29.12.49.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Nov 2018 12:49:24 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: arm@kernel.org
Subject: [GIT PULL] ARM: dts: Amlogic updates for v4.21
Date: Thu, 29 Nov 2018 12:49:24 -0800
Message-ID: <7hr2f38v8r.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_124936_483227_D83EF373 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt

for you to fetch changes up to 7b141abe4aa137f362d7324de5a49fd3105f570f:

  ARM: dts: meson: add the clock inputs for the Meson timer (2018-11-28 16:49:03 -0800)

----------------------------------------------------------------
Amlogic 32-bit DT updates for v4.21
- support more timers on meson8
- add the stdout-path property on several boards

----------------------------------------------------------------
Jerome Brunet (1):
      ARM: dts: meson: consistently disable pin bias

Martin Blumenstingl (7):
      dt-bindings: timer: meson6_timer: document all interrupts
      dt-bindings: timer: meson6_timer: document the clock inputs
      ARM: dts: meson6: atv1200: add the /chosen/stdout-path property
      ARM: dts: meson8: minix-neo-x8: add the /chosen/stdout-path property
      ARM: dts: meson8b: mxq: add the /chosen/stdout-path property
      ARM: dts: meson: add the TIMER B/C/D interrupts
      ARM: dts: meson: add the clock inputs for the Meson timer

 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt | 11 +++++++++--
 arch/arm/boot/dts/meson.dtsi                                     |  7 +++++--
 arch/arm/boot/dts/meson6-atv1200.dts                             |  4 ++++
 arch/arm/boot/dts/meson6.dtsi                                    |  5 +++++
 arch/arm/boot/dts/meson8-minix-neo-x8.dts                        |  4 ++++
 arch/arm/boot/dts/meson8.dtsi                                    | 17 +++++++++++++++++
 arch/arm/boot/dts/meson8b-mxq.dts                                |  4 ++++
 arch/arm/boot/dts/meson8b.dtsi                                   | 14 ++++++++++++++
 arch/arm/boot/dts/meson8m2.dtsi                                  |  1 +
 9 files changed, 63 insertions(+), 4 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
