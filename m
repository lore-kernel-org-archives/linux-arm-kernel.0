Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50466C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:35:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A60218D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RsghEvIj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNhI0Jn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A60218D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zANv8b27D2Vn1JD6sDDEqZhXMebqEcVcKLjYO4Oy6/c=; b=RsghEvIjPWl5Oc
	0pgoMai4t0/+Rhkvgk2QuLNJvIZhwlc71HsTMTXqwbqSkgJ66bC6051lCPxzruyIbkDF52jg9N7VQ
	zPNJjjERFKdc8/3u5ZytZBQ+hMTGSr6HKIf3I1vOs4iS1hU3F3RcP2/qlk7fN4tNZIqDS5ddXCDhq
	0aiOYI20aibo4UVkAoFk04RU5YIjnWR2pZsOhVBvzhdi6KD15CeUz2Y1x7GOuFW0nG6YAwd5ziAYy
	mQEN98oqCLEaMePRpQQStDeRdyXJbnSfxlg8JRase2UER3Bhpv4+1wsQm4cDKWFpS7AMULTLBHo/H
	NCgOkLnR5PcDC1TA5oAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2aM-0000Qu-Ug; Fri, 11 Jan 2019 19:35:18 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2aJ-0000QU-Fv
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 19:35:16 +0000
Received: by mail-lj1-x242.google.com with SMTP id l15-v6so13915455lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 11:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=8vo7UsjD9Tqzi9JE0BhTMXx2wMQhYOm04UIFc6KkvIM=;
 b=fNhI0Jn9nDMDWC70J+pIt2p98no/Xq3+Odp1CbGXLcPpvQqvfa+/awEtrQw0gLM3dF
 juA1vlERcAlgEnxQkeCXHGfc/i3bBDFh3XpSnbxK7uxzwVqhn14o7YmF1Yl52mnpwXNf
 TDFhelkGdi8DDQSu3HcNNyXYDM1pgC0Qt7DfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=8vo7UsjD9Tqzi9JE0BhTMXx2wMQhYOm04UIFc6KkvIM=;
 b=XvQnkZqwK7TaAA4r/CJVowICb0y+ld8/b9TuiVDP4GejQYNS/I3ywGjreCauKXeGWK
 QTGDvJFaz+QgOv0xncHRJ+3XT7AMkXHXQFJidRXuH9I3nbEEPx5ZduXOWOXJ0nnnvDOT
 5bIqofm26lIRo1qczrqWObsfqdb9FsKAzrBnxobFT+oJKiWt+MT/tm6/ym0JN0sJ3hbW
 wCJY/Geyn9olDSfh/EbfZRVoPfAm/J9RnTgPRn2lrNngEVdpPa8jg2CT1SMqNE0W25VN
 AMzCG9T/kMZYSF1TsqAlITheZzGHdA+TkYWNJ+CzZr/+P8bYbOiU5Po2Fiq2t+pFPc3f
 KaVA==
X-Gm-Message-State: AJcUukeGcu0dEKIY6byGtP2+FvPySy/xlAlsFDGxnnj8lKJls7KISNKc
 5l2gmpTQ2VOTGKmU4YadbPhr7eux7PhQrNrsu0LTxA==
X-Google-Smtp-Source: ALg8bN7QO1wpRAafFpltT7Rjz72VeAZtb5zrujJKd9z4wa55WBkIgkAGRkgVxkmkFqGsr5hgxxZd/+58sIk7AMeAWwI=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr9355943ljj.9.1547235313133; 
 Fri, 11 Jan 2019 11:35:13 -0800 (PST)
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 20:35:01 +0100
Message-ID: <CACRpkdaUp+EiS0WL1uJ7wbi4Gtj9yBqR8KwcEK+uYY=hDXEq6A@mail.gmail.com>
Subject: [GIT PULL] Nomadik DTS updates for v5.1
To: arm-soc <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_113515_539811_B464D248 
X-CRM114-Status: UNSURE (   9.66  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC,

this is a DTS update for the Nomadik, it adds the display
and DRM graphics.

Please pull it in for v5.1/next!

Yours,
Linus Walleij

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nomadik-dts-v5.1

for you to fetch changes up to cffbb02dafa374fea7adf9f79b009fa1d14c2531:

  ARM: dts: nomadik: Augment NHK15 panel setting (2019-01-11 20:14:43 +0100)

----------------------------------------------------------------
This add the new display driver and DRM driver device
nodes to the Nomadik NHK8815.

----------------------------------------------------------------
Linus Walleij (1):
      ARM: dts: nomadik: Augment NHK15 panel setting

 arch/arm/boot/dts/ste-nomadik-nhk15.dts | 85 ++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 34 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
