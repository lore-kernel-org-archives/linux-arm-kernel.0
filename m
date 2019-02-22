Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8583EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:10:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559A42086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nNDH24OC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWIMgG6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559A42086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gy/gVrekege+OwuHl2ZQ9tvVuMF2ogxCQvfVxssAFQw=; b=nNDH24OCXIQUlK
	8ZmuzMgRR6cZUVb8lEUz90QUi6fA3sqBb0HgN2fVSF+DkB3U6Q2m7pYgtYBHKlF5Ec5r4wA0jMRBt
	J7sqnKp/mZ89SxWPsd2//DIEuVhQRfgt/QxKkrgRm8fron83hqTOsyhu7xnU2A0Dnfr5NZ1jMyjhC
	XObMkuQ9U/ZnIiQrzp/9GP5WzXk/AW8iDRssn4Bwl3vniSDLQLUgdoxIhLgnxsZrCo0CW9jN0vWKa
	b6x50xlX7sUvxCNC16tiSjdu/6HG84NQL8rIx+qxAsZ6CyPzPHramv7ScQRoj1x+yl5vDKC4swmjf
	6hPtAanlC2Foj9IuaMqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx5uD-0004VB-7X; Fri, 22 Feb 2019 08:10:01 +0000
Received: from mail-it1-x135.google.com ([2607:f8b0:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx5u9-0004UK-J9
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:09:58 +0000
Received: by mail-it1-x135.google.com with SMTP id e24so1836966itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 00:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gbkcZ5KfG5Y6nKOZPQp3ktD7+XSdF5U8q0bkVziFzL4=;
 b=VWIMgG6SlP7y6usgNUVwQZC+mPDDS1CeJq3N880qxFqppLrnBzR7+8ToUSzoFPou2w
 H3AxiS3xgjcMafjJgM71i4P4LSG6FGaAnI+vsUvQu1ZiRyUAiK2PiTYGPZmdU4zQPmrz
 8FHzyF7sEjtZwBNdUwRNkAzPWn2A+Am0LQSn/7+kUR25jduOkKgIlLoQM794meaE2EK+
 UzIqDTdg/XNQM/FuoD5ay/sqRL/Duju4Prx/lBR32g50nLFG9DCmoGJs8Tw2ChdQ9Qkt
 WcWmeoe9gckwdeB/VykDy9dX1UNEP0al53cHmjv7MexSQAeJ46uSgFxetrS0mu7urEiY
 EDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gbkcZ5KfG5Y6nKOZPQp3ktD7+XSdF5U8q0bkVziFzL4=;
 b=AGZbWtwFiZYEWBhqLFLO4SVo6k9uBzZCl0/TBcQzXELgRiUmnT8rmPWKfQphEfEqoT
 ZRPXy9hkJydrF2W6b1UTF5A0A8mZpheSaPkirZKkcwMDl8rOuxuMdqVB9+M3ueI7g6CW
 fclCfM0QPNyNWhXuIKwS9xhq6j0c6zwctLe/2y7TqAYkXXvVFu/ImST5pYr9Jz/tzW6R
 Olb1Xt+1KfUd4/XhH51s1tqVM75pB+eJblHjjDLbaWjoXURLIqUCj3LXXr+318kmWP4x
 POWB4wf8TTcFBg7aDbqPwNds6TxleW5SpnAU9hY+C8mJnHRSvF8LNd+zBpURqKI2b0mn
 7M2g==
X-Gm-Message-State: AHQUAuZGGY+DBIkZed623eqms4x8mx+HxxUEwvVgzqfeEF08Q7+jzdIy
 hmM+ERO5Xe38FQjTDpiJDkY0dpCqqdoB7d1VJ53EzQ==
X-Google-Smtp-Source: AHgI3IaqAuKCiy3mCU8M4dC0QSqYaD7o14z2FAkdRjJ9SNYgxNw6TlT/W+7vQX9utTAm80k6KWYYFz0BabPv8tGkJsA=
X-Received: by 2002:a02:5782:: with SMTP id b2mr1587796jad.2.1550822993613;
 Fri, 22 Feb 2019 00:09:53 -0800 (PST)
MIME-Version: 1.0
References: <1550642547-21968-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1550642547-21968-1-git-send-email-sumit.garg@linaro.org>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 22 Feb 2019 09:09:42 +0100
Message-ID: <CAHUa44ErR1Hw=5qbUGEqz-_VL1fh6sTAoVLEWK23dHE8O8sQfA@mail.gmail.com>
Subject: Re: [PATCH -next] tee: fix possible error pointer ctx dereferencing
To: Sumit Garg <sumit.garg@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_000957_638845_DE375D5D 
X-CRM114-Status: UNSURE (   9.55  )
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Feb 20, 2019 at 7:02 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add check for valid ctx pointer and then only dereference ctx to
> configure supp_nowait flag.
>
> Fixes: 42bf4152d8a7 ("tee: add supp_nowait flag in tee_context struct")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/tee_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I see that Arnd picked this one up the arm/drivers branch too. Thanks
for the help Arnd!

Cheers,
Jens

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
