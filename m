Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33953C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:49:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C6B20666
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aEVO+gtB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="EXwiTU3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C6B20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GG+tEX5Csx4Y+hqwmtUZya3Xr0egnyT8nABpwapSt4A=; b=aEVO+gtB6Jj/rP
	Vfo+zZU/Ncmaq65Q0Z5Bi6sRH5DCv/NlYQ8wdasTjmJOOGtsOrHD4pFhvH36FpRD/OzFDpAq2hcZW
	1UgS8Ns/ao42uyVId94hXJEBUAjdsWJWWZZhm655UItWuhS2p82d4U7cXEQU3ytJVqMtF2SNMCg50
	m1pJBIaJPNRIPm90paqPr68Y1aAVXvzS4w0uXoOLWTEweTdoJevNR92IV9aT3NcJDBqbyMvXTJtE3
	9EM+JNw4tHY4L6Fc7kwah7gItnBfUrv4Wu55bzlw9GazJ6Cy6eVaL4nxlsKL9+pN17OilGlPMwqHx
	p5fqlx3H5IeLpq7flnqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTv9H-0006mS-9V; Mon, 03 Dec 2018 20:48:59 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTv8t-0006Gy-8P
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:48:37 +0000
Received: by mail-lj1-x242.google.com with SMTP id c19-v6so12744870lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AK3c+9ETBl4j3tbkVWiiBjg5BzTdGwZucP5nJN6qZJA=;
 b=EXwiTU3kZVEQ2NP84OUHcTGGaWu6rktMYGJH5C3xpflIxrdH2YDO4gvQo3gQi+c7/D
 V1Jjpsj6eqBWufRZnDGyBJIWv/atF+NyaoFpZNB6J4Mn0+2cU+xO0k7Bdg676m2Zp39U
 1eaRdTz72UGt0Pru2PLcY8BkGOlNg7ERxml4pUDa4w81Rzv7SdbCsaDdMDbOYJsYKPPD
 Wgn7DPuAMfWC9+1BKS0WxBorj6SkeSMfbLFoKBVlXnEu+/efq9SELj8NCSEj96vXukB8
 jGuLR80hFh7Xob3dw1XnH1w5vBeWPqdiWVBXpAtNBiQ5LlL42ZpoRjHOMlA14wMgBBwN
 4WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AK3c+9ETBl4j3tbkVWiiBjg5BzTdGwZucP5nJN6qZJA=;
 b=P9ev/I7Jyol+NOFiUhuTJg6cu1aVQnkMmNy6NCqoivfcQaoafCxyWv53l+PB/tmrs7
 34smDpQylVKwTBQKi6pNBI+pWZvU/SptScjn8VCG8jnXJDshAijHgjqDYIy1YR19v0PE
 nKizMMmea1Evfbx8xDlqJLtHekxiPfGAjhMk5O9Uft624G8ApbhbO+ZzrocDrxWhH1hT
 k+Sa5Hyc7e6AuxYv+br1wSQPGFSY77g0wIYN/GcTsKuxe68qVozcHXHdtygKNaTkS1Vq
 FB0fsD5qDzarqLYtwHdanwj2Hvi6chERpnrTzZ0ANqCgZXcKo3gV5LptPfm8A6svGMXR
 oC5A==
X-Gm-Message-State: AA+aEWZnS6nbrEd38jLMecaIOglmnIgQj+yifUhgGPoXS3wDTFsbAAUr
 LZQ++Rxah8Tnnl4EfbdAmgX+1A==
X-Google-Smtp-Source: AFSGD/WtBrTiPeQW99fWQPH7nw+r2XgfGDn+wgc7MdzMOsx+P/WRmHhePnTn/AIiucR2GuPlIw/w1A==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr10994200ljj.9.1543870103035; 
 Mon, 03 Dec 2018 12:48:23 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id j12-v6sm2716078ljh.66.2018.12.03.12.48.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 12:48:21 -0800 (PST)
Date: Mon, 3 Dec 2018 12:40:05 -0800
From: Olof Johansson <olof@lixom.net>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH] MAINTAINERS: update entry for MMP platform
Message-ID: <20181203204005.wuy6kkuutfwg5d2m@localhost>
References: <20181202111428.1543-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181202111428.1543-1-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_124835_750050_6D44267E 
X-CRM114-Status: GOOD (  13.24  )
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

On Sun, Dec 02, 2018 at 12:14:28PM +0100, Lubomir Rintel wrote:
> Move Eric Miao and Haojian Zhuang over to CREDITS, since they're AWOL
> for some time already. The git trees have gone away too.
> 
> I'm adding myself as a reviewer. I'd like to be Cc'd on patches and will
> be able to test them, but I don't possess a data sheet thus there might
> be things I'll be unable to review. Hence the Odd-Fixes status.

Applied to fixes. Thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
