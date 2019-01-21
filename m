Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22810C7113B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FE72084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="li0CE2mJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdjdYTu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FE72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4HOB5pV0JGjYMI94tvmG/Rn0A2HL871krO/PGG6XkT0=; b=li0CE2mJzT04Uw
	c1Yasp4Aq+53V+aI0mXCoj9C92F2n7e4Nzar1wsrbAXm4xC5c1HTDH05sk0z9Hol9T6bdasDh1xJy
	ZSDxqKkwhi1OZVRkP2NrJY33/2jabjCJxN00wJNA1q1zoya0slyBCEqh2lL16Q4UnH2d3lEXDSlfC
	UtjrBuK4fdYDUsjFoIRY2Py9h2ZhPuqAm+X+dYEvqj6UC+gMm9J2assoCQOKy4FURmL4T1A0/aspf
	89qHj4Lktm4AKNSdCRYKQSQd+7QX+pGjI+8Qu7xIAxDCnUeU91T7dLCiOG6h9sbBfsaviJoK5IKUK
	FacNgFwA6DabijRNvdAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYil-0000pM-7Y; Mon, 21 Jan 2019 12:30:31 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYih-0000oq-Fe
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:30:29 +0000
Received: by mail-lf1-x141.google.com with SMTP id v5so15352278lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 04:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=eg2vL9z0kZYlNwzntT8Fi3VWmVZh54mOpCIviKVdMIw=;
 b=QdjdYTu+trwZdQ/x2k8gkYj1ZcdxSZ9/2bMX9YYGSV2tmE+UwQlaUiyo7XSv2FtwOq
 p2Z1KQ+4efq2XcKmDqAYIyqfCUCJ2zvWrzXRtDyJeiFFYJJ5uBzXFb37BJ3jgEAUPdEd
 WjI3dUX1AoUAUPpM/qxlWUt4uiKsALN+MtnwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=eg2vL9z0kZYlNwzntT8Fi3VWmVZh54mOpCIviKVdMIw=;
 b=hkhfGKxnBN7UWnfNVyigZY4mBF3KGasIsTyT9Kd/0ItswJ/nfKQcFs+OhdPCp53Wwm
 h5tA5tdQIJNbTvLFjXhgwK4cO1D0m0xyleP2jQL73fig+QZr7u3aldFa9gN1KywTiTFn
 udDgbXk255xE81TNOl/k7sM10WMWsAIH7gILBx8q6LIGDMrHjiyVuJ8IegU/u3EDXm1m
 kLCQsoVNmLCd71ZcVH+/e0okQ5au3RnGYd1I2dlIdKpHnzAuJjPlYMtD4zRge5w4AiQE
 eovnBB9r6p14Vfsq6PjmLDEtNN5yb/iPJVqVHqhTQ1W22PngUwRN39xXVZ79AdxlG4Yw
 k7fQ==
X-Gm-Message-State: AJcUukcxX7Wehepe+wpFQYpW4XDWpgaEUgfVF0gSInPZ+5fWZtM7PsBu
 ISP5/JDJgQheX9Z1P749UcsddTT6tu+xGIkuR96jIA==
X-Google-Smtp-Source: ALg8bN5HgMA/4Usklhgpvxftb6ZfZNSWreT88uyq+WZtSjEcqNeTxu1a5O8NywjjBJHd3Dys3Uw5j0Fg7aYRaLRJEFw=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr17467095lfd.149.1548073824710; 
 Mon, 21 Jan 2019 04:30:24 -0800 (PST)
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Jan 2019 13:30:13 +0100
Message-ID: <CACRpkdYRiWZbkduBRxQdPC_1hJjQJCYhX9NFB31t1Su1CSBNyw@mail.gmail.com>
Subject: [GIT PULL] SPEAr defconfig update
To: arm-soc <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_043028_052072_8FFCC42F 
X-CRM114-Status: GOOD (  10.34  )
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
Cc: viresh kumar <viresh.kumar@linaro.org>,
 shiraz hashim <shiraz.linux.kernel@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC maintainers,

this:
1. updates the SPEAr 3xx defconfig
2. replaces the fbdev PL11x framebuffer driver with the DRM PL11x driver
   in the defconfig

This has the ACK of the SPEAr maintainer Viresh Kumar. I don't think
there even is a SPEAr git tree so I send this from my GPIO tree. If they
have other plans, they can say so now :D

Please pull it into ARM SoC in the appropriate place, next kernel is
fine.

Yours,
Linus Walleij

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/pl111-spear-defconfig

for you to fetch changes up to 3e31d705fe0b42f2a7173c13a40ac3b88947a7d1:

  ARM: config: spear3xx: Activate PL111 DRM driver (2019-01-21 13:17:00 +0100)

----------------------------------------------------------------
This updates the SPEAr defconfig and then augments it to
use the DRM PL111 driver rather than the fbdev driver.

----------------------------------------------------------------
Linus Walleij (2):
      ARM: config: Update SPEAr 3xx defconfig
      ARM: config: spear3xx: Activate PL111 DRM driver

 arch/arm/configs/spear3xx_defconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
