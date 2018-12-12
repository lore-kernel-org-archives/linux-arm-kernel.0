Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5CAC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:29:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0BE20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B7BQWatP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="rXUWt6G9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0BE20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qIoMe4KRDU1ha0gagj5mLnFTXyiDtTBwpW4ynJ/A7yc=; b=B7BQWatPsC4OjR
	LwqGiVBuc9EyprafEF6xeMqOVXZp4rthaPAjRn4q/xstof2I0XcUXS9sPAdmvp6IyXrbRQgMcjigo
	L6Sql+/yPtvUIUQo68II9elUtKSr2RCaEKvScFbMYbibSDLS/fpG0Tr0xcjulTZG+we0U4JZ1kDa7
	OE+uIKBlZ3bEIHVGJ+9GmelhQsUA/IBjNg8rqaRPA+kwaQvEY8zVsuVNXDG32jf+x+MFlaB/SNHxg
	DJjU5bWwG/Hu61H32mf1dHjqFOHRzywNc6eu9M9CUHIp6LYZ9ympLJAHrbnTmimd3pECAStGTf5sp
	QN113KAcps8KlZWGSn3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXD0B-00011r-UE; Wed, 12 Dec 2018 22:29:11 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCoZ-0007Pv-Ni
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:15 +0000
Received: by mail-lj1-x242.google.com with SMTP id k15-v6so17720929ljc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aQUbPlGCwZxTnHTHCGeJKtvPeUVR4uN80qZQS4f5k3Y=;
 b=rXUWt6G9A47HZvFjTQEb/2LVceUfrxpXy1hYI1SAZQ+mcUKdODcgzdssaQWkdh+6ec
 mkJK04b6YaKkhj/eTwn6h59allvNBZhbt86bewFC6kiVpVsAzHMfkvSvpYkej4zrXY8s
 FB7UmQcnkYkhuUV+GS0CChLWa/486lGMk4RhgGot82G2mIGJI9FzNWbgI/bumV/lrODu
 Z0tXTaAbIYV3veBa9hwdJlz+mYUOqKiZGrylZMGme1ztlFXS2zf0cmcb2e8hFb76Iikr
 +jMEwWaCyywXDx2u3gD7kpTlCZDIUWQ+ynGwVhrY7SfpQD17X4BfNCscUXV9vxXu/9Mk
 NkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aQUbPlGCwZxTnHTHCGeJKtvPeUVR4uN80qZQS4f5k3Y=;
 b=E9fayG4yMcIWLzUQLS6OvcFzgWB0p4tYwW95ox1DEvB9kWHU/eSIK/0qFpaRlde1Ll
 fDS4j3xKD2hEvwSzLMFIj00KybZRKxZbzpqA+HPly+MUn8JpOuooxxSMooRs9JShbzy7
 gPVmkLLGxm0f3D0iU45lifPqbyrx2XRWzn/eEJcA4N2emB72CwNlBkWZNGtJ1sZ4Dl6h
 se7V/rVQm0kNhPC/7SGRGvT8NfFbqH+KsOheEgdb4rGuoHpTX3ykBRJyBcUgTSFwkGe6
 ru/R2ZBufPUdBm8QcZ99NN+EVSsYOotVsWVYMDtle3VUZBbt9HEVVWX1DTPwLXcq8Kx8
 5VLA==
X-Gm-Message-State: AA+aEWa8/JtnB6CuomVhuMXQK4KR2qA9QBSvLq4ApjQP2UuOtZ1TCDEe
 nUhSDX1ps8yopBYktCt/SDtvxw==
X-Google-Smtp-Source: AFSGD/V1T1coNKjFRctaA92Sht7m1cTteOqByQLTFCDA96psVARk1CzBIm7BvOz/G0l4mCcFoSlIrA==
X-Received: by 2002:a2e:681a:: with SMTP id
 c26-v6mr12950337lja.175.1544653020098; 
 Wed, 12 Dec 2018 14:17:00 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id d19-v6sm2742ljc.37.2018.12.12.14.16.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:58 -0800 (PST)
Date: Wed, 12 Dec 2018 13:56:55 -0800
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] ARM: ks8695: fix section mismatch warning
Message-ID: <20181212215655.wwciqcwmlnq4wtwh@localhost>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210215856.2238253-3-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141711_879228_2792C174 
X-CRM114-Status: GOOD (  11.18  )
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
Cc: Wolfram Sang <wsa@the-dreams.de>, James Hogan <jhogan@kernel.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org,
 arm@kernel.org, Greg Ungerer <gerg@uclinux.org>,
 Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 10:58:38PM +0100, Arnd Bergmann wrote:
> WARNING: vmlinux.o(.text+0x13250): Section mismatch in reference from the function acs5k_i2c_init() to the (unknown reference) .init.data:(unknown)
> The function acs5k_i2c_init() references
> the (unknown reference) __initdata (unknown).
> This is often because acs5k_i2c_init lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to next/soc in arm-soc now.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
