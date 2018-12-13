Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A463C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:10:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB34120811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f9lkfDuZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ng8UcRvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB34120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OZAW3tlihEE2dBMrJAj1DYeXh+xx7Idr5frNO1iwbek=; b=f9lkfDuZ3H72HD
	ZIdqpSFDfEZrqdNBcfZ0PwjABec6f8dRaDPUKfc3lZoiivMA3mR7eYxdJ66aKgkpPDr166y0r94vB
	hhs9tsJOO2x/YuQB7SKnflNm+WpbRzVLZB84qMvNzjuoFCe1ffRm3I8B3RieIAFssghdbGQe56taC
	Eb//uJ+gKjPrguzrvYj4ikcdN2RG3VE7wfV6SsL6GZY7RYGrY/P709Iz1FAe4DkeLs4lwBYqsHYLW
	JqkawTs1MRHrU9rNc3AmNsAkiWXeZ2MrlCephExQKJmAZzT2x6sujsyzqs7hlFeHwd8eP6dyDadhi
	1B8KJEK6RGSIwm7Gz14A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXFWZ-0007e8-9L; Thu, 13 Dec 2018 01:10:47 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXFW1-0005rX-F6
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 01:10:40 +0000
Received: by mail-qt1-x82e.google.com with SMTP id y20so362354qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 17:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4NUXph6sewKAF+Apf1FNRprvzsnumssa+ieZdO5X5ig=;
 b=ng8UcRvbK0jA0sVddxz9JoZN5d+fO5P9VO91aj7IV9eXZu1Cp4MhapTcjqFFLORoT1
 DwFNp3Uki8xpvMGTc3iUbh1+EkPvkkyhkIljNF/xC17BCCF1xhqaYHmFGgOJzphul/uL
 bKESJTjQAnULgPKYAtXFStMhf0MxVlQJ099ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4NUXph6sewKAF+Apf1FNRprvzsnumssa+ieZdO5X5ig=;
 b=miSrf7MKpyww69tLyEUS3xgr4TxZ6q3yS9Llak9tQahwWSwHrUsWJG7CwI3d3tWCMM
 r4jkwCMTrmN43rABzhVYtEMEpd0qMscqg9p37tFzv7SWX4/PgmRpj/L9Xslf0ZUbD6UV
 dDczR7yeAY2EngGa5WLDa/7eYPC308k5Z/0cyeGufuxjQMQWv/HoOvjnIQGYhfip3VUh
 6fBMHdtayA/QF9itvkOp5srcE96BCJGu2X12PYcM425MvhjJoKxF9bdK9vVJzVOZ5uu4
 h55QLlWrJpp9Hv/RL1HHjzaJt/n5fURaXLijE88ZMma8NcXmg7hR2WJZWXcvjQeonchO
 b6pQ==
X-Gm-Message-State: AA+aEWbkzlLv+3imqilc+9+otWn56dSX1YrakCxTsHp/xCz7Le+/uGU9
 XrICzb+hI4rXZAQD/0qqNPRUJSf2Ma52OHePGiY=
X-Google-Smtp-Source: AFSGD/UA2uv6C0lcuruKpIf2RhbZzybNULof2IpPd7ZmIoT47JeDFYvYL9EdwGuPrndoew8T2SukoqpDgcYH9Uj8iVE=
X-Received: by 2002:a0c:c927:: with SMTP id r36mr21779472qvj.51.1544663401828; 
 Wed, 12 Dec 2018 17:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20181212215305.3852170-1-taoren@fb.com>
In-Reply-To: <20181212215305.3852170-1-taoren@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 13 Dec 2018 11:39:50 +1030
Message-ID: <CACPK8XcHN07D5vtoAZ2BnaFzc55P+XEhzsTajOm1S2fvcrrm5Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: aspeed: remove duplicated statement
To: Tao Ren <taoren@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_171013_849542_32098505 
X-CRM114-Status: UNSURE (   6.69  )
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
Cc: linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-gpio@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 13 Dec 2018 at 08:24, Tao Ren <taoren@fb.com> wrote:
>
> Remove duplicated assignment statement from aspeed_gpio_probe() function.
>
> Signed-off-by: Tao Ren <taoren@fb.com>

Acked-by: Joel Stanley <joel@jms.id.au>

Thanks Tao!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
