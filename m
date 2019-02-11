Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,SUBJ_ALL_CAPS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A740C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:49:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423FD218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="crYhf7RR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kyfi3dan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423FD218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vRlJ5W8GOQkUDHOliI8xx60NYmqPW5B3Y5c6/p+5ofM=; b=crYhf7RRUEIFfW
	hNT30mabhMfXzbRB6TbCfD+Dw1GBeFtm4m22E/ZpHosKAJ62pHDds7c6NoUbaWfqVnijqfbxmJzJl
	OhG/pV2HRC4ZO/Y/8hqqHsl7IsBUPetjuYZJS1gePfqj2Ck7MSz+z6yYUuMGle7ZkH7ME0DdiJI6Z
	d+ZfAp8J/eFh683E46nW8taF6Sw5FYCStrUcJwQU9NRU1RydwpwnAAe+E4LY3KpYDiveMfV2WwWyM
	ETDwIr7PQPeL0ZosWgHEBg/pxtp/IXLqdYewiTA35kE2VU9xuLuFo8HI0zBnaVuBkzbz+1ujSkXr/
	Tn0+KN1ItPaiFApYtHeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtIVk-0001Kf-Qi; Mon, 11 Feb 2019 20:49:04 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtIVg-0001JT-FQ
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 20:49:02 +0000
Received: by mail-pg1-x544.google.com with SMTP id d72so109362pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 12:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=iD/2fmc3WOR75xKs3SOI8RznZuRTsGWHd3f6jaHVDts=;
 b=kyfi3danVhowRODs3bHSnz2xGgr0DF4P4v+EjPqfmcAG6qPV5XUQQj7/ezwvx6sr/M
 2KkYAkp33KRAciQUISTrFMCKZ4BHAmLZMUubk/pGjzadyehjxo1BEAcjiI+X/h/TI3HN
 igBtu0iU4lHzu8uKr+ZEiM+dbG5WjU31hiG5465F0BG3rN67vmov8yWT9hRw4suQxztJ
 CUiOfz2oUpwVPE8O0ys7inkeaURGwK1WHs8NF8xCHCpFq3nbcjKWs1gQfsKn4TgeMY7T
 W/1N/MhpoPJhjdHc6bjIy5cdok5de9/9BzYazHu9759G9rm5J7ZR+qjV1McVVpa6aQ+8
 Lruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=iD/2fmc3WOR75xKs3SOI8RznZuRTsGWHd3f6jaHVDts=;
 b=IaU+aybUhPQjsowQAVNt1lcQpTc5guP9C08ONeh6TJPVhYsXd6dNPNn8qCMbWbz7Io
 1b9rTKzDJNMfs14+/yPY/gGWPUYtfH7yLrA19v4Ms4RYcXxSWlRb5P+ldImM56KZwcjv
 rcdtB0bq8Mg0PIx/xZUOQVEYph850OzV1v9jJ3lInIZYojVAOSMUyuvpYmoQpnFy7hJa
 /M0/REIxSSW/nlbQl3CVtsFR9U15oyYXxmLFpN2m3PHVtkNWIJMWkdOtoLqvN+B1vcHs
 UMka52ZAxK3E97XfpO8Zmesqe2MKixCggWS7UMU/+RVohOejeDHy0wIoOd9RaahaHU2q
 u98Q==
X-Gm-Message-State: AHQUAuZnOQhzUL+UjXTe/YvVq31A83oCrQLg6d+ME9+t+gv8ZtASxW7F
 jmoHlUfXPnDf8q8AAtfufXDOIGiYT7Q=
X-Google-Smtp-Source: AHgI3Ib4lf6z9Qjmrs9M7eL8SvaRqCk8Uf+gA800Vg6jAcWnU5WVJAuxDkgR4V0sfijIpomyMSqfQA==
X-Received: by 2002:a63:f201:: with SMTP id v1mr140486pgh.232.1549918139610;
 Mon, 11 Feb 2019 12:48:59 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1d1:285e:6b85:3bfc])
 by smtp.googlemail.com with ESMTPSA id 10sm17683708pfq.146.2019.02.11.12.48.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 12:48:59 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: arm@kernel.org
Subject: [GIT PULL] 
Date: Mon, 11 Feb 2019 12:48:58 -0800
Message-ID: <7himxqdpad.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_124900_511985_06F84223 
X-CRM114-Status: UNSURE (   9.85  )
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
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-soc

for you to fetch changes up to b3077ffcfa24b05c05af3b990d97a392ef88b22e:

  arm64: meson: enable g12a clock controller (2019-02-08 09:30:25 -0800)

----------------------------------------------------------------
Amlogic SoC Kconfig updates for v5.1:
- arm64: meson: enable g12a clock controller
- drop unneeded COMMON_CLK_AMLOGIC

----------------------------------------------------------------
Jerome Brunet (3):
      arm64: meson: remove COMMON_CLK_AMLOGIC selection
      ARM: meson: remove COMMON_CLK_AMLOGIC selection
      arm64: meson: enable g12a clock controller

 arch/arm/mach-meson/Kconfig  | 1 -
 arch/arm64/Kconfig.platforms | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
