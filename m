Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC0CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:43:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACD42192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AhawcoEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACD42192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RvYDMGTmGU2A1z1vzHWNVFsyDx83DYAG82Cb0zXLa7o=; b=AhawcoEML5xa/J
	dsb2qN28oe6A1hJqJhIprWbxCFNtfFCx3mlwbYcVMAaXffkSAcXhttqSojWjFukUaD0mMnlFMlT4T
	iUkRritYv2pwLL5VbVsA+qW5GmLRNtdAIRkoksMAl8r/Fu5/7bfcoqysX3xDU4lx5V8huQAxEe1dO
	u4LHl1+GPnrPGym98cEc2mtkmgpcStvhEazODsooUdZE22aTyZ+r0DNDE2v2rnyX65gdy5SUx9dgM
	vzyBnmY2GWzyiQmpmgpfXlBMczVcY7JbpLM4eyIoEfwyNqBjuGoy7AxxqbV7LsG3jatc4keGSqi9B
	wmJOvJN4i/fpPHFraSwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guehq-0003cG-Pu; Fri, 15 Feb 2019 14:43:10 +0000
Received: from mail-qt1-f175.google.com ([209.85.160.175])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guehn-0003bF-TB
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:43:09 +0000
Received: by mail-qt1-f175.google.com with SMTP id z39so11140194qtz.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t+RbHZ78PVOcqPqIj6PSIFQirW4zu1js94QAADBlDA8=;
 b=tkcLQT9yk7h4Ru//cZHhqRmc3sfEJEd/lINEksI98x9L9F4otb4kPSwuAjb87yE4CA
 jQZvGhI72X9ytM/SQTxYC1ttOF/roIuUJGSwb+Wsc+g7q5hIjTJ5LkCn5hDITkfiODhX
 FSA1gM35AvHsVhDCjzPL6VK+8Qo/xwnodLgtibaglIOaWc6gXMNK8uVBTWaR/2hix33I
 x1+cuQqrs4RtjlooMTEzQ5Wi8ZUl8i7dogSgOdkiFd49M7x+7nyRUFbukeV8F3ojzqlh
 wGed55vlZ6XY9GO1nefV49Q0Pv+Mvrd7C1gCuNjNX1TviuZVZ54Naah5Rnyohtt9Ndkv
 +99Q==
X-Gm-Message-State: AHQUAuZlAThod0t7+76wAKV2JLFO+/ZkI17+JATVO/Up4wpNsM2ff0Dv
 ygWHVX+OegXFKAefPQxD8498s10+qIk2e40Y0ec=
X-Google-Smtp-Source: AHgI3IYfUjneFhoBhJKACK2EzQnbdieyUobkvCXPjBxyLhYFSrYWj2fZqR4DoJBw8jxt0St3maURVE6XDV3QFlr31ow=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr7734444qtn.212.1550241786796; 
 Fri, 15 Feb 2019 06:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20190208103133.4jomhfzbqphbxkm6@flea>
In-Reply-To: <20190208103133.4jomhfzbqphbxkm6@flea>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:42:50 +0100
Message-ID: <CAK8P3a2mHyaDr3Fao0SZEtHeEcv4JXVDb5KCy9Cj43vO7vB6xw@mail.gmail.com>
Subject: Re: [GIT PULL] Allwinner DT changes for 5.1, take 2
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_064307_937180_6B4131E0 
X-CRM114-Status: UNSURE (   8.77  )
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
Cc: Chen-Yu Tsai <wens@csie.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 11:31 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> Allwinner DT changes for 5.1, take 2
>
> Our usual bunch of DT changes for the Allwinner arm SoCs:
>   - LCD support for the Q8 A13 tablets
>   - GMAC support for the A80
>   - PMIC power supplies for the A83t


Pulled into arm/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
