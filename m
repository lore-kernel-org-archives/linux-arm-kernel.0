Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936B4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:12:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642CA20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rrjoMxNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642CA20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f+bTGpUNIqCRRKi8ZYybnSdELSQ2m2dQUzlloHxX/gI=; b=rrjoMxNb0yPYy6
	m75JBj4erK8GDt+SNeUVmy6q03/X4zIgzDjeOYuhm8u/31iUQmLtE/NkWrC6upQsqIEW84sxMhdbK
	gY/c8b02z9NrRd3hPXnXo9pgMk9H9xM6YV/YK/GrX3PJdsPDFnZyDw8a9cbfDibYJI8/0bDAAiWDs
	n+5eNKprmOQUwB+z0AcjpztJ5kc9o44AFeXfGbLOpKmw1UnPr16SFLH0EfOS+JLH5jQ6QK+kTfl5y
	wr4+42zXFkxpJf4w1jSgeHo4msK0MLKkKfRUkRcYR+uSamA4K604a6ESACXSic8wly+rmCs71AJYD
	OHD+KhdgiC3YLJsLADsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufAN-0001LO-5Y; Fri, 15 Feb 2019 15:12:39 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufAF-0001Kn-C6
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:12:36 +0000
Received: by mail-qt1-f196.google.com with SMTP id p48so11217892qtk.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OfCxOIWbrAUeX2gxFLUm+bm/Vc8jERHZYrse8eGQr1g=;
 b=JrOJ550XRsEygduTn2PZhiDZOiXR0JsqyTK3eLUS7rlB9tUI1QCLLWcNo3sCBMMjr7
 FFxBw4pqmqPpBnOaXTBifKf0WNFAjK2NMTyHg19bcgBdYoQ229ALmRMnGhsfiH77M/Ip
 m8nC4I30YzxST0ws8M6PWZHMqjuX6gieJloVvk6skaRN0ET8qa8bJPHPjQs9VHJvae/B
 WWVWVpO9Zuwm/ebV/gm4So0nC5LZWY5TXZ3iO3DP+8j+f5NaSWGdLizsmOJtIZaY082/
 y2VkOibJEKKWqZMv1a5I+RUkq+LziZlaAaJdLb3ZLAU1c6vgXTQe5lc112GZ0oVEHu7A
 MNDg==
X-Gm-Message-State: AHQUAuZp0Ybxp0D0Y6Q5Lo/qgn05Mbh/EZCDRp1pJidKcZER/GoHf8N9
 fimj436Lk/ONYKytOu16Mgc7AvS/YECIHX3yUaNliQ==
X-Google-Smtp-Source: AHgI3Ibt5Jjrw9n+x025s7O675eigHFR9J+l1tfCWmiA6V+J8Nl/DMxgKONEjdQPj3+vTn30UxHAStxFb+eVZZ2v6mg=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr7847911qtn.212.1550243550540; 
 Fri, 15 Feb 2019 07:12:30 -0800 (PST)
MIME-Version: 1.0
References: <28075c68-6393-0c2a-3a2a-ff0f76ad15d3@monstr.eu>
In-Reply-To: <28075c68-6393-0c2a-3a2a-ff0f76ad15d3@monstr.eu>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:12:14 +0100
Message-ID: <CAK8P3a23V3PHAkkv0yxwyymKUPZGxMZK-kWkPD-ULg6bmwLnog@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: Xilinx DT changes for v5.1
To: Michal Simek <monstr@monstr.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_071232_872795_8C4E2CB1 
X-CRM114-Status: UNSURE (   8.04  )
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
Cc: arm-soc <arm@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 1:50 PM Michal Simek <monstr@monstr.eu> wrote:
> arm64: dts: zynqmp: DT changes for v5.1
>
> - Extend timeout for wifi to power up on Ultra96
>

Pulled into arm/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
