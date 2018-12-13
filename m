Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE88C67872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E22F2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cqiUB4p0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="KMqP9efC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E22F2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6bsKpoPJL9/svAr2dW2ynL1cCMIQ0d7T74LEb1wgnVc=; b=cqiUB4p0NuFoRV
	WMopp+D/UJsJbh/a/EQPd2a9aFonaPJo8FHEFstZodzBo8vRG0Wr9WJcHRyeJqls61FAF4W/lTKeH
	2fztfK9UceQDeT6AquWlCB2qFl1b9+RykUE4Ryt5GMcsz4WH/p1u79TTjHTci1+GvUFFUKUa5vlyn
	G9WHQZ5q/LfXSKtGHZAZjI29o64T5QwDGHJ+mjsEbWGZRVOfEq7b3fOltpeuvUWnYcKPlC24L8rSC
	r9VKhg6bXYIU8hIKQDN1nPrb44ZmROK9SjuiuGQvuHfj7itLvWYUq7wuRCHIDjSWIRI/LsJLuHjba
	kt0fCJltEVon5NOxU50Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXKrE-0004kc-8v; Thu, 13 Dec 2018 06:52:28 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKqY-00045e-Es
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 06:51:48 +0000
Received: by mail-lf1-x144.google.com with SMTP id v5so695407lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 22:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JdgcwaD2BuNk7SPz5Qho5H0RctNB2IAwYYQYfuyLYf4=;
 b=KMqP9efCNfIIZz6WnaMVik0lnS8XmdqtZFA6uHyfye/HwrH+27cTawXz2U9gGTbzag
 D1fVHRtmxbu+qCpLXTKDgscQnyWrQO8j4rQcTg2iV6tiMyltC4ozyeyeGNkgInITFqhv
 SYOGy26SS6apyixX8OC3Bsvtlo98TBdKcRiELPLicI0doMvyiqTpZWoMbSzYXfN6aPYf
 oD/ZasYzv8TbUKmdW5tDUbwrLFylzk0hRtTofinGQmZdUE2fo8tl99xov9Au+70//O5u
 fAnMLF4pLKtL/Oz0XgRAJwtJ0fN/ju1Pl24c2G/uQGodPGaO1A9N6KngjHp7S1FjlJ1n
 LSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JdgcwaD2BuNk7SPz5Qho5H0RctNB2IAwYYQYfuyLYf4=;
 b=erkhE+DzfH4U946Iev1KRgCLUXYJoMjchWteTEgHf2GnOs/HzI+3+NLtOZ/J1jybUK
 mQKHaiAY+gAZdwZm5D0mqFYxTdgXaroOrfG0urA5kK6gy8UgQ70IOlYyM2VOTzAwdvxD
 TBYBCKTC6OyrrhKspCULQW+7h0akkHt2H1d/6UjTcvfjr/6oS2ziDiA0xfCc7cd8aBSO
 YKnLOm7LaXq4uI2dQR0QplVdzM6HOTFoJPTQ4CqHygjOwK0rlPviqC2RCfVWRTnU8lnI
 nLXlSM/PDSta58F+7vWo7UXLd3xAlYMmhSdZV1HKy0RUrZ3sBAVrPGm9iUB2gFlSmysU
 4mug==
X-Gm-Message-State: AA+aEWa9WMM8MGhbMrr/kImMpkkE3DEjDDEu6QMGQWN9ov/NqHpeqZmK
 lilFrJuOuFysxoI3zxeZ7a98VQ==
X-Google-Smtp-Source: AFSGD/WUo8ssXkqSckXrLXameooM4KZASyiq2mEX1a75tFA+P9k/7c9zWJEjZvvH9SPMcrbt/J5WqQ==
X-Received: by 2002:a19:4345:: with SMTP id m5mr13228859lfj.142.1544683894283; 
 Wed, 12 Dec 2018 22:51:34 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id r27-v6sm152528lja.65.2018.12.12.22.51.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 22:51:33 -0800 (PST)
Date: Wed, 12 Dec 2018 18:14:42 -0800
From: Olof Johansson <olof@lixom.net>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v3 4/9] arm64: defconfig: Drop USB_ULPI_BUS and
 USB_CHIPIDEA_ULPI
Message-ID: <20181213021442.i7eabju22cviqnae@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <a5a9193c-018a-8d52-7b62-2743db048a69@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a5a9193c-018a-8d52-7b62-2743db048a69@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_225146_908874_C13E7024 
X-CRM114-Status: GOOD (  10.31  )
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
Cc: arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 09, 2018 at 02:02:18AM +0100, Marc Gonzalez wrote:
> Commit a930d8bd94d8 ("usb: chipidea: Always build ULPI code") made
> USB_CHIPIDEA select USB_ULPI_BUS, and removed USB_CHIPIDEA_ULPI.
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

This one is the same as some of the others; it had already dropped off with the
refresh.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
