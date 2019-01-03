Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FE5C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C352A2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jR9BqtP5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NuGRglHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C352A2070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8WM39/DfwlHza8P1QF5gfrL9JsJCaEdEGHkcYYhFrUc=; b=jR9BqtP5OVwh/G
	uHa9q3Wa4bk0PER6D1t7jTTek1wpGMcdzW4zky8EqXbaC3+brIPqW8JvlJ6sUsPlQ9khlWlu5qozO
	umS6un86mJsUxneOYEocfz5Yzz8QDw8To9E+klsFkjO68cu2aLGXNWxuWLXtYkcpH7x3+T/g2wmUZ
	ED4b9CDsKWCR9DlBlh2u0iGYeeRoIo8Xod0juuMP5y/8ZBFHjeRnXqs7xP5jozhS7lGd5j5rip7C9
	9tHIdwThgAOmq+XbvpoLLh8ltpet1OMQ4K1oxH4ppI1wgvDfWOrqK8uB+pbBDfs6UcO8hu3nP9hFs
	iFq5rgStMNlLBkKe8kdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf4eW-0004BN-B6; Thu, 03 Jan 2019 15:11:20 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf4eT-00046V-La
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 15:11:19 +0000
Received: by mail-wm1-x32e.google.com with SMTP id m22so30720882wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 07:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0dcQ3/dkLOl44sCSWYzCMKpCPVjooWzOO9eRJkxMTew=;
 b=NuGRglHn/0Lqr/u9OI54BSv4S+ZG70CQ1chHvduL/azRJwwNXqtex+qwncXRAttU1J
 iYhIBVCT0MCE8VYwOs83y6NZityicqpTyAJZ4KeZd3JsPeMUJ5DEVpHqIJ/CLGWCUT+l
 Mu63kZmgfLXn3l9/hQtV1+/99jB5/n+KCFmn87nK8lXNoe0K612Kd//YokcgmsCmP6+u
 f/Vt5gukHL/8KMd17XLxZI4ihmczkIusRfXgFZaVuZicYlMFaGktxgkYksqQ/N4hpunu
 oCi2cuaOWv0CS3cxc9WBlXbxxXLtITcSxdn2lQWEnqzZ6zL2BKwOWxQBH8dA8aVx3SxW
 oK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0dcQ3/dkLOl44sCSWYzCMKpCPVjooWzOO9eRJkxMTew=;
 b=OF9cfKuY13HHYTpsvKBRK4Nt5xmmw6Spg/yFIhOEdVsB9AD8HI2xABY51QlCSCqZ8G
 +Mxd+INzf4wQ2wlMAjnfIFQcTP5Pmwrj0MNbihl5+YGJRLOC8ptvbPHnUluXhWmb3hIm
 DSN5LLWyG4cV1kirT81IEt8xPFylI3qg+AJmHLT6YerBRSJ9jMDYGXL29MXCu3VoVpyK
 nz8Yg48AKvfr+M+vs9bfHv5Ix7oWqM0yzQJ9m3n2dq+ffhbfpvDHrLqVZ8glo/nQUg0/
 j7SYZr+MYuwfVNfoUdNjJSh1E+hy0RpxSZPCDx4LPSsy3tJym1XbnexYnSlteE9tOLAg
 nQuw==
X-Gm-Message-State: AJcUukd3TllojfK0qtdMQNaop185xPyfn55/FvcpiP6M11ZcbdP6tvKL
 ypGhMWyJIKrXzULWyP/UylVpfQ==
X-Google-Smtp-Source: ALg8bN4i09QkBsAAx0LQZbXnP4FHe48ktuHU/6boZLMztuOfPv0oP4tv5IUgR3XlS+2/iN9GSu/HWg==
X-Received: by 2002:a1c:99ce:: with SMTP id b197mr40218807wme.75.1546528275898; 
 Thu, 03 Jan 2019 07:11:15 -0800 (PST)
Received: from debian-brgl.baylibre.local
 (astlambert-681-1-88-79.w90-86.abo.wanadoo.fr. [90.86.3.79])
 by smtp.gmail.com with ESMTPSA id n5sm45620707wrr.94.2019.01.03.07.11.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jan 2019 07:11:15 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>
Subject: [PATCH 0/5] ARM: davinci: fix label names in GPIO lookup entries
Date: Thu,  3 Jan 2019 16:10:59 +0100
Message-Id: <20190103151104.11839-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_071117_754350_C21F0364 
X-CRM114-Status: UNSURE (   8.57  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "Andrew F . Davis" <afd@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Sekhar,

I noticed some more breakage resulting from commit 587f7a694f01 ("gpio:
davinci: Use dev name for label and automatic base selection"). This
series fixes GPIO lookups in legacy mode for DaVinci.

Bartosz Golaszewski (5):
  ARM: davinci: da830-evm: fix label names in GPIO lookup entries
  ARM: davinci: da850-evm: fix label names in GPIO lookup entries
  ARM: davinci: dm355-evm: fix label names in GPIO lookup entries
  ARM: davinci: dm644x-evm: fix label names in GPIO lookup entries
  ARM: davinci: omapl138-hawk: fix label names in GPIO lookup entries

 arch/arm/mach-davinci/board-da830-evm.c     | 4 ++--
 arch/arm/mach-davinci/board-da850-evm.c     | 4 ++--
 arch/arm/mach-davinci/board-dm355-evm.c     | 4 ++--
 arch/arm/mach-davinci/board-dm644x-evm.c    | 4 ++--
 arch/arm/mach-davinci/board-omapl138-hawk.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
