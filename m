Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D83C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:17:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5FD20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hqLWSeUx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="TB5zV8Pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5FD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4eNdLOzJvpFmTCDK4+rcNhS0JBLQlBjMAwe5gptmi3Q=; b=hqLWSeUxWv87kj
	HyjvPqZETwjgyLQqeREq7TK5psRnjx0XtajCXh3uSDOHI5+j2JyDD/23pefz3DSqaHR4ChDY0awpP
	U8NorXSrx9i9CTK7xQy7lYD1lc5hwDDAIQIAFnAOuhKAjLlFBjB+Kf78DI8ajl1cwpH5oI5iC5d/O
	8Qrgg6SxwSYfPuqOrAG84HreBH9mjg+JfNYfm6kFgHMS/PCFmdfL15E5HnOPrg+TGlEnHLzH9rT1h
	/yeiGSrE2KFLLjDQAqsHCeGOT115fu92GvqzKILfAUeoN5Mn3jbru/VXqpnp/JBJc8adDx6C92I+c
	a0knn59hQc34qz5Gz2JQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvaq-0001vY-1T; Mon, 03 Dec 2018 21:17:28 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvad-0001kb-CD
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:17:16 +0000
Received: by mail-lj1-x241.google.com with SMTP id c19-v6so12818059lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8loA5B9sISBo1TgumK+JeKTngqGfXbNi43zNTUj0UNc=;
 b=TB5zV8Pl4UBjfI8+RknyrGQgSMbiK0vHKPgOJwDjL+zsAifjgPt3O8VJXVI+JttV/E
 giBoMNE9amTQ/50eM6TkVueEmBcXLBBchlShN2Zcxnponv/wf5MgwCd7fowGBN0jLAaU
 cxZDNfdDhE8DcV9deKL2LsfByuLCuD9UP+0C28TLmhMHuecQKVqatQr7m1W1spF7vPs1
 R9kDEfJaQ4dW3pU2+i8hPEjVwgr6hHtrinuZH/euoz8sgUFi9ieT90smfWJVwkXNZQYk
 6gNxHianwdbC98a5whTaZLTW8Oel+TEMIK4K2SmkrxfeBuQ59jr5+QjRXmNuplYI5lob
 FfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8loA5B9sISBo1TgumK+JeKTngqGfXbNi43zNTUj0UNc=;
 b=S/ezxR/1R5RHjOjLy3Q2gmNCMV69JmBHPG0jkKjkMpAsMAgOyHJnFxyTNmT+vD9CIl
 fVVd4fKb12b+fjOcvkpSQ/Sz0W9JylXEEMcOmQh2IYSr98dtdYUgm/xFc0VfWRZQlw/L
 A3fWdAdKAS4BgUZqf4UWRyMhxQMEUb8sfu+XrpfcgeW/tnYy4LsgZJ8/GDH+RcWXe2mK
 f66vd3RfUHRPue0NpogUUFiv/X3xx2hzy34NkaXuuyg+FsfTqJu4tt4Ylgte8hgz3oaW
 q2iv/ByZP/IRV+RgyAIqCfRCubcGIHUIjlDEaa31aDf+bGHNhHp/Uh14t/r1IF7ohlt8
 Nvdw==
X-Gm-Message-State: AA+aEWYVMICRYlbNGWridoolX3mP3smCKeqabeuzh69/ArLQNhc99y68
 OeXLmX8+Uv3fq5ArvFDS2r4KoQ==
X-Google-Smtp-Source: AFSGD/UTdfCdAIeAODgn1aEsMGfBY69HZUGGqVjXjtPwSfiVUfv7IdswfG55HiZQyX6roOHkpNQInQ==
X-Received: by 2002:a2e:9957:: with SMTP id
 r23-v6mr10625397ljj.98.1543871823593; 
 Mon, 03 Dec 2018 13:17:03 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id q11sm2540422lfc.92.2018.12.03.13.17.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 13:17:02 -0800 (PST)
Date: Mon, 3 Dec 2018 12:55:27 -0800
From: Olof Johansson <olof@lixom.net>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH] ARM: mmp2: DT: be compatible with mrvl,mmp2
Message-ID: <20181203205527.dchun3lac5pc3c63@localhost>
References: <20181202113848.2763-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181202113848.2763-1-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_131715_488158_9D0ABB6B 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, arm-soc <arm@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 02, 2018 at 12:38:48PM +0100, Lubomir Rintel wrote:
> There are more boards that can work with mmp2-dt than just Brownstone.
> The OLPC XO-1.75 device tree root is compatible with "mrvl,mmp2" only.
> 
> The "mrvl,mmp2-brownstone" string is safe to remove: the Brownstone
> device tree contains the "mrvl,mmp2" compatible string too.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Applied to next/dt. Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
