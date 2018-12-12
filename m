Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CD0C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:29:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529B920672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cx09KMVl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Cp2SQtA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529B920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SSWreWPrLlWFTD6BT3dqtGsa98w+gmmFfJH80+dUk7c=; b=Cx09KMVlsdF6DM
	7rUVyP9mxXQkM8xlIMpZJyosha4AHqSeCSWG7ilrr35ewc8EF8UKFmyWrmAxr0ts/R3cQhGA1LPpn
	JVZHafbfOZz42fgqd5EG18y7UBUlndnlZuUxpmi7i7Fbb7gr/tdtJl/ANUuJxfSkC27GfG00/Kc9q
	aVlAtJXWm9rWxTqClyt6cWRbcoWLznWsCgb9oSuwXv2yJPicAsdFd/O/dbsxK8NLO5A78OEJzs7pC
	p8xs9M1iDtBu6IfdZ4MVC37fx2h9kGPCCZU3Cd7fMcdIkxUEYy1Nr7y5Jzhp/1hoA9SIJc2xNWLgr
	Nsm1JRNvzMeQBMhCuo1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXCzx-0000mk-Q7; Wed, 12 Dec 2018 22:28:57 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCoQ-0007Ji-Hj
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:06 +0000
Received: by mail-lj1-x241.google.com with SMTP id u6-v6so24836ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hY3w+zeFS5PopVQkS3rMiZg3FrfXLFppwOIOWZ3z/sA=;
 b=Cp2SQtA5AmKnLCr14GgkRYJMZZDLRdIQqfmvLhrlyftI8cBVOG8DZ1H9n1tZdEa7aG
 vDO92gjMtkmzJfTpmCu413NgkWP6UukkvLMdOx4Tfr0K1c9Ys85uKxfmq14k3Td8JAGH
 pp31qGDtZNzR0JvFBAakIXnSplR0772q4BUn1yNulfblbc68ed9FvthTbUZBaiKFCBTE
 e79DGVHJ1bmA6QsU/Y8SjPj6clz0XvLoJCJSwlYWvV25yelmf66e4oVeoEz+n8vQ8XLm
 5KprPPaBCH2ixRnbyfXd2X2grRi249KUXVydK2O/w4aDxFUUqis4gQ6kx7rmn9HOAKKe
 zu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hY3w+zeFS5PopVQkS3rMiZg3FrfXLFppwOIOWZ3z/sA=;
 b=hkotW3vB66CNZmrtcA4xuh/jrjctj16+eOMN6xQ96dyVYIN6ZL5zDSrRnAcy23Av1f
 LKuxqZOCRHCd7RWSX0QhInYBtxVNK2DUcyrk9S8C9Qv4Ocx/wOXg383n4u5yjR3mAWnz
 Y4vJjwduQSFbkXvyvJjR5zM7FG+J6EUbgXMAMuohBIQdtla8O+OtwsRftp6y1kiV3Pwq
 XBgZZvIyjY2TmwiAA8OXbZBkeP+HzBTmVmQ2rnHgG2DB7AR3bU1L/p1nflLEwMpK9mnD
 Dv7hbEYsl8SjLxBYhqIaunRTxbJt4LWFY5OI+fQ7QvqFVb7sJ+a+VN27913l9ntCnBUz
 leSQ==
X-Gm-Message-State: AA+aEWYEzM9C5TIQNqLytMoEpyPFv71sHgjMuWnn1+PRs4nezPC+MQxE
 YQJXcfnzntz1WukrfAZXH7GD8Q==
X-Google-Smtp-Source: AFSGD/VTyXzkeN/3f4is+SKZQr7L93PQj9FWMssgLruF3XyK2SJ4IuO9iftrHHYtHIIIqlvVhHkYxg==
X-Received: by 2002:a2e:4601:: with SMTP id
 t1-v6mr14478280lja.111.1544653014877; 
 Wed, 12 Dec 2018 14:16:54 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id x204sm6284lfa.5.2018.12.12.14.16.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:16:53 -0800 (PST)
Date: Wed, 12 Dec 2018 13:55:35 -0800
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] ARM: mmp: fix pxa168_device_usb_phy use on aspenite
Message-ID: <20181212215535.5evv7fk7ed57gw7s@localhost>
References: <20181210204340.2269622-1-arnd@arndb.de>
 <20181210204340.2269622-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210204340.2269622-2-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141702_745132_8690174B 
X-CRM114-Status: GOOD (  14.13  )
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
Cc: Lubomir Rintel <lkundrak@v3.sk>, arm@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 09:43:02PM +0100, Arnd Bergmann wrote:
> This one ended up in the wrong header file, causing a build failure
> on at least one platform:
> 
> arch/arm/mach-mmp/aspenite.c: In function 'common_init':
> arch/arm/mach-mmp/aspenite.c:260:28: error: 'pxa168_device_usb_phy' undeclared (first use in this function); did you mean 'pxa168_device_ssp5'?
> 
> We can just include both the pxa168.h and pxa910.h headers to make
> that work, which gets us to the next failure:
> 
> arch/arm/mach-mmp/aspenite.o: In function `common_init':
> aspenite.c:(.init.text+0x1c0): undefined reference to `pxa168_device_usb_phy'
> 
> This is solved by using the matching ifdef check around the
> USB device registration, enabling them only when either USB
> host or gadget mode are enabled.
> 
> Fixes: a225daf72ee7 ("ARM: mmp: add a pxa-usb-phy device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to next/soc. Thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
