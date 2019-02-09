Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357A7C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:30:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010F2214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BQSZmVIb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCxx4ni/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010F2214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:Date:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0UXnW/MobgPwlNm/OmDmwYNrZ9VNyIvuLLLjVYNoCbo=; b=BQSZmVIbn0tCTM
	dKF168d521alEUeYUXG2T3xGIINKweUHAf70OFVaANcBuzoIxh8z5raXgY6QYJGL5g6tw1ASy2pem
	g2cUZ9DVzhFE8S1Y6P70YDqD7a8Hsp35JwyRNHuMtwUfzvyLWrAgDWXhjWA3QKj0U3IxkzNQTPJUQ
	a6Gq4qu1KgELRVY2NCT+RrGd64pqenPcC18muxJVlLrNPNcfE0Zjh1AlyKPoGC2UgTMKNOLrl8MT5
	kbelTZ3f109eG3vo7xMjOLmjn5zLdFs+I6tqb3tPIzVmjMwom+Q3oHEyByUYR/irDGBu71wfedW4W
	o4RFfAP3AkfWXlSC5YHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsXOi-0001kq-9E; Sat, 09 Feb 2019 18:30:40 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsXOf-0001kX-Eb
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 18:30:38 +0000
Received: by mail-wm1-x344.google.com with SMTP id d15so9479169wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 09 Feb 2019 10:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
 b=GCxx4ni/0v0jcXvzeInqwPsGbcOUWXDaWdmlMH4Xy1BGkP5Y2wTRsm9/ZxykA8z+UH
 ulCcXyvAvcp/pyfkiBo4PF5C+ZQPTOk4A8+cgO2KoYDgZlHM6ITdg0FvK35Ei0nzh4f8
 qwhcW7qt0IVC/KIosW7XluABSDGkdZqRl3uRUXqi3fU6CIfqt39c/t1y5krhtQ7QXlXv
 QheBwVrOF8mUnwG3f0A6mUX3W4zHtGVZwQTEF8uk/M4piGCjuh4OyJ3IgdmmvV8giMKe
 gYkkOG+UZS/ARz/n3MZhs+KgXNoaOvSBBEzSJjJXSyKzJjdvc+4Mx0EADOQwyUmuVtfq
 6zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
 :mime-version:content-transfer-encoding;
 bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
 b=nYO4nT4ekZG3QoJOolEd0dGtAr2WZ0hvAH6cXscgH0cZAwt2F5ZW3DjfLLKFDPshBJ
 M7up2IQOXkuiTGbFuc2ttketwL/ustuVSCHebVjPBz7sxkwZ8dt88rioll/9OZB9CrAw
 Ii6stq0H8RCaupjpvEBiWD2fqgt9exCqa4GlnA1xUUuEELFQBx2d8tXeCFRKRijzM7lX
 qYbniE5EOK5IcaxNF/LpB9Q19Q7wB977hj4d388TodxzdDqpy+mRYIW49fqm1rbEgNDM
 KxQUXOTgGGwE9GECBQKZowJ0llfiHCAy743YV1QRZljON29wXst+ZeHjUQfDZ0xZkM+U
 Jh/g==
X-Gm-Message-State: AHQUAuaVgAMAM/riHBoldndDmjpqtXtWj6K0t7aoPmW9f9XPh3/gWoOP
 fW890au3vJ1rzeaaLTryN50=
X-Google-Smtp-Source: AHgI3IYAx/IEh5wQ3rwUXcEi18pGlhjvtWs7A3M6FRBBBhcwaYV0P7uyDUXsYZ1vNB43DXk3cME3Lw==
X-Received: by 2002:adf:a14d:: with SMTP id r13mr5867588wrr.169.1549737034313; 
 Sat, 09 Feb 2019 10:30:34 -0800 (PST)
Received: from [192.168.1.100] ([93.51.16.173])
 by smtp.gmail.com with ESMTPSA id m21sm10985171wmi.43.2019.02.09.10.30.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 09 Feb 2019 10:30:33 -0800 (PST)
Message-ID: <02256c76ab48570778f12366e86ca5a84f94f105.camel@gmail.com>
Subject: [PATCH] arm64/io: Don't use WZR in writel
From: AngeloGioacchino Del Regno <kholk11@gmail.com>
To: AngeloGioacchino Del Regno <kholk11@gmail.com>, Jens Axboe
 <axboe@kernel.dk>,  Will Deacon <will.deacon@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>
Date: Sat, 09 Feb 2019 19:30:32 +0100
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_103037_515915_136A7578 
X-CRM114-Status: UNSURE (   5.27  )
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
Cc: linux-arm-msm@vger.kernel.org,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
