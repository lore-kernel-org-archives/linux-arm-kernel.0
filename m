Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA29CC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:13:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8768020989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hpeZrk7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8768020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+uebpSOeCCjAr9XNhm4ZKBwSNLmK03pbiUb6GCEKEbs=; b=hpeZrk7GT51GZV
	5nfKCygw7YRbSUbIyYheKObWb1a+/kdzd8YU/75ZoISodgC2Lz4BKp8fJm02D5fhFTbRwwx6cZWmq
	o2FdpMaKcsgsLxhzyXGQ3IkwNY7KRoiT1533IIrYnTl/VTqEBBnE8NvHHP47t0IrtSh32ke19/Iag
	wwi8Tjc6I6uPCGMziIAS9dGIxAdmspN97T/vyzdcg9yJFXDIq4NbMqBaiJzUxtguqRoePTytKtn2w
	jvsatoBdyd5WS5jAxOtqjKSZjsqax8IjvyjXlBOD4b4hFfMcZVxO7yzx09j1RCN46acTOrYtOy/Yb
	sxfBdIDP3OXJjLvmTVkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goms2-0006Wk-EB; Wed, 30 Jan 2019 10:13:26 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomrz-0006WH-Ba
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:13:24 +0000
Received: by mail-qt1-f193.google.com with SMTP id y20so25504113qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pk2WfGjuHag7ZlNHvzx+SexZIOH9mOuvtQY/2sDJlTg=;
 b=sBJbSSxiPlmofJwRpXcP4g/DIGhIVnv3JRNuJXLx+2nFLWYKDyqrJBxz8bZ+CquRNE
 96FSpOH/+hGJY/4yhVfrl3Xna30/JQGkagcRMWo9tFzM2/XMPLdsNMfRg5oYOwqgCZ2E
 dDd0ObQRhFKs4JGcFPRY5r884+mbsgU77J8hIS8n2J2GL5P+G3VjNVUnKTUP3wiI8O6f
 tZHtHG9G7Li0gRblhZJjMz+A2tQq8U93E7u8IyhRoexToe8fSljjfNDSjapjCRZtinhY
 zQwNdqANCq1n5nln1dkiWXx7uvO8Mwtsos6le4UCNOZ2lI7YdqA4HKzT5xNPuL3NhxdT
 5jfg==
X-Gm-Message-State: AJcUukf4/tSFZgQCkltWi2WfYQyCDMM6WRh4H+W56HP1WmO9w2IiVfpo
 zGZRH+vzfsU7y/dyU2tusgYx7OruBo+o6oQ2wpw=
X-Google-Smtp-Source: ALg8bN7OiBh1NCtkZTlzPamIklwp54aWSX0wWCvK2yK8UQgyWS6gQDbRLPsb5UqLNWhzymQ8epKwnibD91bIqXD0lKQ=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr28832033qtr.319.1548843201958; 
 Wed, 30 Jan 2019 02:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20190114021658.GI15371@dragon>
In-Reply-To: <20190114021658.GI15371@dragon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:13:05 +0100
Message-ID: <CAK8P3a2AiD+7VLJQzUKRjNzG1CV9uBY+-AFf3rsZaUcmEVXptw@mail.gmail.com>
Subject: Re: [GIT PULL] i.MX fixes for 5.0
To: Shawn Guo <shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_021323_391454_93AECE72 
X-CRM114-Status: UNSURE (   8.71  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, arm-soc <arm@kernel.org>,
 linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 3:17 AM Shawn Guo <shawnguo@kernel.org> wrote:
> ----------------------------------------------------------------
> i.MX fixes for 5.0:
>  - Fix spi_bus_bridge DTC warning by correcting '#address-cells' of
>    dspi3 node on vf610-bk4 board, as it's being used a SPI slave
>    controller there.
>  - Replace deprecated gpio-key,wakeup property with wakeup-source for
>    board imx6q-pistachio and imx6sll-evk, into which the deprecated
>    property sneaked during the merge window.
>  - Correct the backward compatible for i.MX6SX GPT device, as it's
>    actually compatible with i.MX6DL GPT rather than i.MX31 one.

Pulled into arm/fixes, thanks!

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
