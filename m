Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744C0C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:18:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29ED92064A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dxG9/L0Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zVConGsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29ED92064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jmvUgBCDLX47IRfTxs5QHW6EPw+JV88Y1fLhWB0tVnc=; b=dxG9/L0ZOJ2wfD
	FGR4aAnl22oeaqpN8C9qNDk0MIxg4sm6cT7e9rI1OJPhnQ45o5RmMl6pDfjQVoam1eRb8wcd1ufEK
	4TjgFdVonJZlR/RUK7+BmLMEkf4MJoMBkBon64eD99REqBId3qbCbgcZL7U9io7WigFeawYpNY2H5
	uEeNkchSAlI9feTILYdGLCyU8tyqgX/YRmFpg886sTUJH0JCBYbctGMdCw0AVmSAhEDqH/ZEqpsIo
	l8WzpWT15TjulZPbCPMjMbijUmVlv1CPEnzFPk24i/Pw1opLOqEigBCMV5WTI+IPbSyUbjx1r3JAL
	iyMWSDdF0ozELnr0y/Tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvbY-0002jA-Te; Mon, 03 Dec 2018 21:18:12 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvaj-0001ke-KX
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:17:25 +0000
Received: by mail-lj1-x244.google.com with SMTP id s5-v6so12789031ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gB0TldqL5uwTG2DFr0qqq+TTA9iyQ3KtjGVNsaMFYPk=;
 b=zVConGsyinHhzN1VPkX/y/EWEjN+nJ/Sw8QLkYZFPHrnHtTOYfc7yu/LCPiBHGZc2a
 QEmcDLPbWdTYK506DwyGaoy4RczP1yNj379KgsGlcwv+YppvuulqioPAVRNdintqZi9g
 xYqll/YZa6PROkCNjWCK92vxs/60A/FLFHM3IG5OwyrgpBJskCecUFZStW7RewjOgH35
 yXUANBZcM6XvIZsVK5zgIPg7RFQVtbKqkFwu29QmnL/hBzvMv5Jph1E7Md0a6ap50cO0
 OsJ073X3964iEROt63S7uLkNnIRzhVk1zIYf7CAS38z5LpAdjxt1/rCp4AWr3RjmZN3J
 AufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gB0TldqL5uwTG2DFr0qqq+TTA9iyQ3KtjGVNsaMFYPk=;
 b=VGbeTt0z2r++xfZNF18gNILCHjHzZeQvobdlf50T2ofmDVRvxxptRMpaZw5o7k8Nli
 ehj5bVMNN8i2Geyu0yN/SkkJedNkQY61RofyzOcEz1mElPxeYZcZIuK22juAKd/VgSCx
 vN/gjG3H6Pr15BlOLeBgTkkzzmafdlE0O4hRlS1ps/71zCtbmQy8do3eIKcAKOvx1fJX
 9Dm7qkPiyDZsXk3VeSOivHW/rCzoVztXhY1NxjaDlYRQ8J2V/inAIo/iXAJZquIW/jrn
 Mb4Nm0n4B+yp7ku8gTQ++WiuHN9RsYOI9WJ5Qaciqrb754lNFM5lhOMgdjbGcv7iNVQA
 oCrQ==
X-Gm-Message-State: AA+aEWYh2qo6hSZwIUhLa3fcCgvZUzyR+TtNSMp1aOpK5FXKPh5jLyHK
 mJNptg4YAJLhDOFLsgIN8u0itg==
X-Google-Smtp-Source: AFSGD/WnGKcXCg9ZyMgJDgwObS8UlD5AsRLoKeEM5d4kGhwU+XS+g0/pedd6CaYqTG+ZMISPeLZ1Cw==
X-Received: by 2002:a2e:92:: with SMTP id
 e18-v6mr11883905lji.130.1543871827953; 
 Mon, 03 Dec 2018 13:17:07 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id l21-v6sm2725017lji.6.2018.12.03.13.17.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 13:17:06 -0800 (PST)
Date: Mon, 3 Dec 2018 12:58:55 -0800
From: Olof Johansson <olof@lixom.net>
To: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: enable STM32 analog & timer
 drivers
Message-ID: <20181203205855.c6j3sskitgdqxrd7@localhost>
References: <1543836121-18799-1-git-send-email-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543836121-18799-1-git-send-email-alexandre.torgue@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_131722_097895_CA778786 
X-CRM114-Status: GOOD (  13.19  )
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
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 12:22:01PM +0100, Alexandre Torgue wrote:
> From: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> This enables drivers for STM32 timer, low power timer and analog hardware
> that can be used on STM32MP1 SoC:
> - Timer & LP Timer MFD core, PWM, trigger & encoder drivers
> - IIO ADC/DAC/DFSDM
> - vrefbuf regu driver (voltage reference buffer).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 
> ---
> 
> Hi Arnd, Olof and Kevin,
> 
> Can you please merge this patch for v4.21?

Applied to next/defconfig. Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
