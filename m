Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEBAC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:06:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD2621019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SoQTfSGH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NX8RHevb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD2621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=N3EsXuJJ6PBsf7dWesdLAJqFP5yLyarf4h3AWH1xBlU=; b=SoQTfSGHOIBqje
	sevafxpJfwa1WQcdICCy9jru+hF8QUmGd7vTl8X4yO6s8MulsO8TiXl2iipYrmyINmy5AHPldraby
	C/ytCfl1yLrmdLrplVIMZWem3gIfdVk3uR9mXB1g8WzbgUE9tlk6hfDS/1wY5NFyv8279st8eUbI4
	K6HXehH66UfyC9TEJzR1w7THMzQCceLE1t1A0s7Pbcrt6EYZeMLJu5+usKl5lRXYDHLo99ct6HRbZ
	E7mnOm41NQU1bXAwb3GDNzDk2SlIzD36/F1iMsNFbdHkuoHJNMXnk6JmmP0msT4/uNd5mpc+cCmCD
	2SN7zUN2Tq6XLda1t15w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDXz-0000RY-Vf; Wed, 23 Jan 2019 08:06:07 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDXw-0000RE-H1
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:06:05 +0000
Received: by mail-lj1-x244.google.com with SMTP id q2-v6so1054104lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 00:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=+lK1BnBGERScosWMkR4hhwvln6qRmmF6uAoEhFc9Dtw=;
 b=NX8RHevbicZNcpMCDvquM+jQ3zCZEjuDjsdwQKSXRsKM3CA1j1uQfamtvtNjbJ6OiH
 KEEprGGyR9eTuSPm8rBYBeircpUcp8H5qFhPQ8TEv7vdUbOZq0nROuMMn6C9dLfgZg6h
 FPiVPMrbTKs29TaIBLZsblLSUYbM2SRynsJqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=+lK1BnBGERScosWMkR4hhwvln6qRmmF6uAoEhFc9Dtw=;
 b=tSs3jFoYGN+sq6viNk172x1cotcyxI4rvMpfjq0ezHwdBt2XhW4lisTQTkCHfzPVfy
 KdI624L9NWnICwSVBEvJeg5Xxi5xd/cRsN+HUFk4o2GpG2Zs1QM7LN0ERcDP2qlDyd8A
 S4eMDytou+XesS1WAI+ES0pSqxzCo15Y6JV31VInimgqZj6lI121c+OpKlQ9PDztxCEd
 O+brQ68aB0oZsZw0GFXtO5IpOwNCXmodhfqGeCbsl73qnwqieb8Pv7k+Dbaph3e+LRMW
 RXbPKmw63ILlITrD+ZEsJhoC+gTqwsLoRKRztWZzuqw6Ch98u2QQBpVTgoYu4wLZK8nZ
 IwsQ==
X-Gm-Message-State: AJcUukevEMJKGL95jrhg9gkm2unJI7bYVx3BNZ6o7fgC6oyD6LMWQ1CQ
 tatsEADIvD1vGdsZ/VbzJsch27A1PPmkUg02nP9lbAAGNmk=
X-Google-Smtp-Source: ALg8bN4TA8cCb3xHdbg2INQcGM9oz7jW3mv9oaHnLS2fu0rWqr4r3e/H7SpYhVxUGUi714+GXd0yI/o7HFC8123eZHI=
X-Received: by 2002:a2e:568d:: with SMTP id
 k13-v6mr1115311lje.105.1548230762176; 
 Wed, 23 Jan 2019 00:06:02 -0800 (PST)
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Jan 2019 09:05:50 +0100
Message-ID: <CACRpkdaKoa0MHnFESoBqmmun2ZOWXOgXBYWnsVcqvDnzgBfJnA@mail.gmail.com>
Subject: [GIT PULL] DTS changes for Integrator DRM
To: arm-soc <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_000604_577858_FFD65886 
X-CRM114-Status: GOOD (  10.04  )
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

Hi ARM SoC folks,

this augments the Integrator device tree with the proper nodes to
use DRM. The patch has been circulating with the DRM patch set
and finally the infrastructure is in place in DRM to handle this
RBG5551 device as well.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-dts-v5.1

for you to fetch changes up to b724cad74c7a122a8496518a157c548f97f1821b:

  ARM: dts: Augment panel setting for Integrator/CP (2019-01-10 10:03:23 +0100)

----------------------------------------------------------------
This updates the Integrator DTS files with the device
tree nodes required by the DRM driver.

----------------------------------------------------------------
Linus Walleij (1):
      ARM: dts: Augment panel setting for Integrator/CP

 arch/arm/boot/dts/integratorcp.dts | 89 ++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 32 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
