Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB15DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FD12075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I7rSnR2L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDg+o/jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FD12075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T9FsMfwpn2uCesutJyR+zQEcLUyZ2Mscj6WXED9rvpQ=; b=I7rSnR2LoIK4zW
	szkKYutklI16KT/CWG5M9eSjLufIikVPS0beC+8fXoGTqW2IBu+hFy6mCDBIUs9td7Cr0sy9977Uh
	zLlx46eEbT9xCA2eru30z+jCJ0jJ+fAuqSoJ8csbSIPx0kOFxs+DxBI1KzJZxMOyr5p/uNXj28C+8
	IwzdfP2q8jT2TKokazTcxXFEYAl+6524FSw5YMkJ3+UkMa5a4HfmQVqNzy+ASVASFQ3/lusep+sB8
	hGTIdNE0lfnQrN+G/9bEBGdGRLn864K1kLdacEpQq73D6WfwQQQ9pBMbeOT3rLgPziz/wNlEfZKKv
	lGMxMFnS0+D4c7VqjySQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geAhQ-0003r8-KU; Tue, 01 Jan 2019 03:26:36 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geAhN-0003qS-H8
 for linux-arm-kernel@lists.infradead.org; Tue, 01 Jan 2019 03:26:35 +0000
Received: by mail-pl1-x644.google.com with SMTP id gn14so13180598plb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 19:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=koD8akXG6XEb6yxJFJ9jXYmiNEUmQM46EGLjAZM9WsY=;
 b=XDg+o/jEm6W4w3X40pSKjTJRQTNDZl/tJ7hOJNRwtYkl9K4YpnMJ+M/C0IhISBF5OQ
 co4XLjLJYQXaMvWnBWLJbSDHLmKmUZlJwNhyZr1Np9CWVvmELfoqlb5XnLPk0qGcD88k
 fssbI5rIbJi8/CTTZntvpNiHxL99jveWcjsOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=koD8akXG6XEb6yxJFJ9jXYmiNEUmQM46EGLjAZM9WsY=;
 b=C1PCEeuVaQtZKkQPKptR6gXWm4wZhZEHuB3M08FQJ3cyYQ5spgHmq76rCjkuzT1atu
 pnhgHv4mkZ0OSZmzq8D/ep8ecPVi4QL6NSO7MK4RSDcNpGuARg7C7GJ6y0v4KTU/qWL7
 0hQeF/yLtI1QUKDBemnqDGMlv7kymH5hodfdroDeL3usFOEkEs6cfkUz4e+emhaBeBTy
 bgP3tBvwjOASumMUR7RHIje2tIpppgSeNNSH2uExk2saAQWQgIm/j6ZQXNnUycwoTFCO
 SpEth3E26zay5vWE2dTcv0MLXE5ClVEGXlmNJSwPWHM6dD8+aahTGG2Bmj1S/SeXdnZb
 0FwQ==
X-Gm-Message-State: AJcUukdwF3j+vjMJmhFUejtDZGDBlj51hip/Kx7JWset/nJUW6Wkn+DP
 3gzgH4CSaZqlqr6pVInpuvVU
X-Google-Smtp-Source: ALg8bN7q2drViqpaFZBkNnXa3aQPuJXb3ycyShgdc7LB9noeUwVcI0gtLEiZbYqSGK1mN836/z9uGg==
X-Received: by 2002:a17:902:2868:: with SMTP id
 e95mr39328666plb.317.1546313190867; 
 Mon, 31 Dec 2018 19:26:30 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:73cf:97ca:3812:84fe:81d3:6fa8])
 by smtp.gmail.com with ESMTPSA id k24sm71662750pfj.13.2018.12.31.19.26.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 31 Dec 2018 19:26:30 -0800 (PST)
Date: Tue, 1 Jan 2019 08:56:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 6/6] MAINTAINERS: Add linux-actions mailing list for
 Actions Semi
Message-ID: <20190101032622.GC2736@Mani-XPS-13-9360>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
 <2a7f53c58896e2a9c3115a8630040b98497e5877.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a7f53c58896e2a9c3115a8630040b98497e5877.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_192633_594660_953A4BAC 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, robh+dt@kernel.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Joe,

On Mon, Dec 31, 2018 at 11:12:18AM -0800, Joe Perches wrote:
> On Tue, 2019-01-01 at 00:25 +0530, Manivannan Sadhasivam wrote:
> > Add the linux-actions mailing list for Actions Semi SoC architecture.
> =

> Unrelated to adding this L: entry
> =

> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -1240,6 +1240,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
> >  M:	Andreas F=E4rber <afaerber@suse.de>
> >  R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> >  N:	owl
> =

> The N: entry matches too many non-owl entries like:
> =

> Documentation/parport-lowlevel.txt
> drivers/misc/ibmasm/lowlevel.c
> drivers/misc/ibmasm/lowlevel.h
> fs/udf/lowle
> vel.c
> net/ipv6/ip6_flowlabel.c
> sound/soc/samsung/lowland.c
> =

> Maybe there should be two entries
> =

> N:	/owl
> N:	-owl
> =


Thanks for letting us know. Yes, we need to change it. How about below?

N: owl-
N: -owl

Will do it as a follow-up patch if agreed!

Regards,
Mani

> =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
