Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94743C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:58:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613B720660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d2BJQva8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="SOWHN5HD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613B720660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kQxOlnMix3BoEmXiTqLEj02NgByOvCNvUqcL1yJQxRI=; b=d2BJQva8mPQ0V/
	Ri3+SnNU7G+LeRFfO5KoaKJ6RRlH8Q4vmBMaxlvUarQvkPEWVjEXVKndu/JWNnW78htMY1BJ3cyle
	vcgpB5qzt3WCumgz31Truzit9Jy+JswKFNlyytixWgUw1QOGTdoxxS5eUcWk4zQ6Or2JlxqaPjbXb
	J97GPCXMNoSDKcztQsPPFM236qq0L3l1rq/GCGyVEBUlXCH6+IWzsimJBrXMzdhDzdU07w2i2dr3n
	EYZZGyxA+st4OLpe7fy/wTw69Xn6sOARjpth+v0uqCy1Qe1zftDbri2RSKhUbxISZ9BB4HUXLinXP
	7wxMduxu/oc/TkoPtnGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsfa-00038U-Ug; Fri, 30 Nov 2018 23:58:02 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsee-00023l-Lm
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:09 +0000
Received: by mail-lj1-x243.google.com with SMTP id 83-v6so6471387ljf.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CP3v+8d1ujQgXXZ15DRe9aJvH1aYib247lxF953bnAQ=;
 b=SOWHN5HDYdoEejSh0oaKIthatsiQqeJ8le0cPg1PydE18VJjHBKjonBOXGNZgsq3rF
 qXkeFywIwuVWCHcW8ZTE0Cy46VK46aFDNZgO5/7C6G725URhygpY+BOja0pRJHCypHRG
 4VjrEsDfxKchMmSmD/18GHxmTDKTaxGp8v7cnoV3KpgFhqXZbdue0CY5agcQ67ZOFrwc
 b5ivoRF6U9GbvSAoXlv24bcVpUYggQUHVEyoOHW+JwsxQpeMPP5JmEy+uUAObm1wQ3l2
 qt7V8Hxq93ZKAo/Qdln9k9ClBqs/bqoiCU4jGXe+dq1smiSmP9Tn362KozCQN8RJF3Ua
 paQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CP3v+8d1ujQgXXZ15DRe9aJvH1aYib247lxF953bnAQ=;
 b=DHWOsTym2/l9s+7cRTrGbCQ+E+WKMOzl7WKDCQBRtDOEFno0HHk5lFgMSxyJ/D9awP
 MR81n6tC4cWFPgtIDSUwXithllXi2MMXO331lJdt7alWFd2cImZbzkR5Xsjz1Aj3ctAj
 Ok1vjrjBphVS8m+Naj41D0eZt+XSuG6XnP56jgFEAI7wb+9A+gMBxXKKoiwpUaNx4Z2R
 ePUVRwi0PyfkUeCZHgTGKPPYITpa5DBHtoCmwPyYO2YfLdkxf6D4MWLK8kiVKp474Bod
 fSgrIuXc0aKxFN+t+QTD9X5BzraaBAu2qXCulb6m4kkrNSOMIyP4p1/sl1/1BZLk5RP+
 FxYQ==
X-Gm-Message-State: AA+aEWb98jHbTtYd+x8s51uOZprXs8nNCrNCCY1JajFkf5/ACMSLY3XV
 F4w3a4xFnr88pAEPCuO8waLEiyrexmQ/yA==
X-Google-Smtp-Source: AFSGD/Wi+w+KGLud2zAZUcbmDDyNMPk6SSlNIdQ5hUkbqFJYgMPEhxIi2Laz9Ad68s8LQbRf7/hdmA==
X-Received: by 2002:a2e:9457:: with SMTP id o23-v6mr5453857ljh.7.1543622213046; 
 Fri, 30 Nov 2018 15:56:53 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id v19sm1046630lfe.69.2018.11.30.15.56.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:56:52 -0800 (PST)
Date: Fri, 30 Nov 2018 15:11:38 -0800
From: Olof Johansson <olof@lixom.net>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v4 02/20] DT: marvell,mmp2: fix the gpio interrupt cell
 number
Message-ID: <20181130231138.fxpee3dinkopkcnn@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <20181128175324.163202-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128175324.163202-3-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_155705_624573_25799682 
X-CRM114-Status: GOOD (  11.82  )
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
 Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 arm@kernel.org, Pavel Machek <pavel@ucw.cz>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 06:53:06PM +0100, Lubomir Rintel wrote:
> gpio-pxa uses two cell to encode the interrupt source: the pin number
> and the trigger type. Adjust the device node accordingly.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---

Thanks for these patches!

Applied patches 2-10 to next/dt for 4.21, using different patch prefix:

ARM: dts: mmp2: ...

Some of the others (gpio, irqchip) should be reviewed and/or applied by
the corresonding subsystem maintainers.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
