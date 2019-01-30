Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFE2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:27:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB12C20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p1csi7Ki";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Iy2a5V9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB12C20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M6kx9+9fGAJ0DnjmeQKhdQ97sRjNl8iTZ8Gwne9Qz9E=; b=p1csi7KiVWpkY2
	X1n1sp1QhXnT9DTqWZ8lZg7juUY9LcGInpJTnVy6Rf+GTXkz0dzWLQmdjsokm8hegdM0xuvfp5uMJ
	RnM9HkKUsc10wsQVVt7rknRxLXFlI+VvqWxtQcsjOTlAkDFahW+Nn2t49uGpnClq1PnUme7o9YZZb
	Wxxz+qXWQgOT2sPA3vW60RakPJFdrpMZpCrQQewRlvrQj/qetcVVA2eAZTPxfxQXA4R2SeK5AO+kF
	4Ft1S9h3+LB1yhlk+YkBraDr0OZ2NYRwrLqffPtHzv3j+PDrpR4pXSJjGwLs3ozm4pTrDgnd6k9tX
	U2u6ZhxMhhHaL+fxqitg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gogXN-0004KH-0l; Wed, 30 Jan 2019 03:27:41 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gogXJ-0004Jp-S8
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 03:27:39 +0000
Received: by mail-qk1-x741.google.com with SMTP id o8so12883734qkk.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 19:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0b2GDl2yieLIyx2pFYrqOUiHxYeTYtmKw6/wCfFz+T4=;
 b=Iy2a5V9MHKAxrlKsnJ9rvNj4qf16/5BykO68Vm7RZa7LecX/MGwVbwNi7xKfBVOtT5
 k8Q5Q5jLXd0GA3BlUfmybllg9sTRLNHMUFzFwBbuCAtT3aGCnHizLffXYtk9vV3wac01
 iDO2opyMPNA4+IjQD82rEXt18DZys6H7bUErg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0b2GDl2yieLIyx2pFYrqOUiHxYeTYtmKw6/wCfFz+T4=;
 b=FaPh1mQ//3sZQmVFsm8yfJtGZS0PftFWIgYJ1DgSBLu1RgyXDv7n6mOLhxu2tdX5HB
 uEn+WKg7Kfj6pv9d5k2C3Lgm37EuxPeVo2bEASU8b0vcm/PhReLCKGjEdwVIuqpFNkf/
 R2jOesWg7+w+q+SvKS5Fx1UxYOk5Mqvkk5zZK1w+0sFtttfmePvcyP3QlsQMjtNVJCAl
 z+vWjvqWFRPjAM4Fd3Lv6k3NpFvDleuWU3vgsldJXJbqFYT2HugheykQoc0j5LP3Wr7w
 MY5y4sS6GxexYw0tkRSmGzl+a24cXKWolm6IYkeyW2rY+EdQPNumkRlIvMF6p0ZscRH4
 fXcA==
X-Gm-Message-State: AJcUukeZIWMy25D1iqAuTb2btdDbQnVr9UoLZRprtSWOIs0cdFfWiLDB
 1j2FR1Hc6MNlxFy+9asmtGmnz5naq5x8xVrgEY8=
X-Google-Smtp-Source: ALg8bN5KS647Oz897o2Lp4q/4anxz45TJI1E5O6Dbhj26ozy8v2BKx5KAQFns7kWbyI/ya5kUEmqLguF66sAaUDJLWM=
X-Received: by 2002:a37:781:: with SMTP id 123mr26025466qkh.231.1548818856336; 
 Tue, 29 Jan 2019 19:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20190123230733.1821501-1-vijaykhemka@fb.com>
 <20190123230733.1821501-2-vijaykhemka@fb.com>
In-Reply-To: <20190123230733.1821501-2-vijaykhemka@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 Jan 2019 14:27:24 +1100
Message-ID: <CACPK8Xc-abT8Y9f60qt=v3TQ-=fQ3k7YzJGS5Y2MN0MDfRY+tA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add uarts for SoL in Facebook
To: Vijay Khemka <vijaykhemka@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_192737_902744_A6C72FF0 
X-CRM114-Status: UNSURE (   8.57  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
 Andrew Jeffery <andrew@aj.id.au>,
 "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 at 10:07, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added uart2 and uart3 in Facebook Tiogapass for routing serial input
> from Host to BMC for SoL via LPC.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied for 5.1.

Cheers,

Joel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
