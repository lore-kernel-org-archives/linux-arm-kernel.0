Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5D6C2F3A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:47:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5C42085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aJYDEIrR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iLRGbOqn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5uhICuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5C42085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nm2Qb2pQO4VnwAQytwFbmBsQPhiA+k5Cb0GCxvciSxg=; b=aJYDEIrR98dRfG
	FfaVJ6DwFnwfPrYLkajZsXLz9L6yEZo80UJn4yQpascyvlK3/lj2hWnEiyiL7Sq2NMck+B8lYbLND
	f7llVAmHAOiQEtJjW+13Vsm93j7XiB2fNWbrVuccDTksDsxYpllLGZVrkiMKN33NHkoPoOofu8hXe
	6+lmEmfO8x9/VBtDQjf4Brs3szsFd3nN+l4zL+SY8BzGPHq7zglGydM52y24mahS9Y+VoOLjcH5eV
	rBrUy5O9ubpDxYdzHYQNuCxRLVgzt7fvB3skKAUI6yLFlcaxq55eh7do6sG2wA9Sf9fgcEKJfZIX0
	uSwdEd1e1JcvfK5+z4Ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYzR-0008M5-Mf; Mon, 21 Jan 2019 12:47:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYzP-0008D8-VN
 for linux-arm-kernel@bombadil.infradead.org; Mon, 21 Jan 2019 12:47:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aqofOx10bCSXiVPy4GuYZRETwNglCG7lZze/M4Zb5jY=; b=iLRGbOqneEPnI7MIg+xlBoGtd
 Rrlh4+tjGr+QZjEyiSwKt+66deHX5LcCsC2bBeukxNz8d5L19IHLBm+hvpTXbv0QgzPczO1mGb9iq
 z+dz2Zh5NtPfkzx8G0JgJdCLzIgFIbniE32TMmnzBqDNwTowQ0Y0eUKGf9rkE0VqM7nYEjoQul9L/
 vfKyCl8Nzxk8xeZ5/1x7fm6tiNyJVH5n6QCOkr+kE3Z3DMbXllZf4AKM+gwKbrJ9zIi54VkUWfbsp
 RknXOQi3MF/QhTDdJDinCmK2mxYUP1G2RgxXNZ+Fn4/k/ONya2ZNboSaIkPMDjiwvTitHzQuxL2V7
 n+nBGqkag==;
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYkE-0007Vh-3P
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:32:03 +0000
Received: by mail-lj1-x242.google.com with SMTP id v1-v6so17410262ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 04:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aqofOx10bCSXiVPy4GuYZRETwNglCG7lZze/M4Zb5jY=;
 b=g5uhICuvVz4zHWOR6tQsmNDVkzaKe5eGUSC2NyR2qCktFZwWjOHt+NBmDz22VwqcG8
 nLm0Jg/fFrP2WYKHoZDHkQaZwq2wLTzgSRvymo8HdJD04SHcdqKPf5yrkfuYuxjmSJsY
 zH/e/U/FPoD0VOiaAhDrxiTWXImxFocPpbF2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aqofOx10bCSXiVPy4GuYZRETwNglCG7lZze/M4Zb5jY=;
 b=t2SZldb8YbA4ezDelAl35QGdryFWkPG9WQ0JgVCYLgT7iGdCaX4fjudce5Q0Dn76ZE
 keNvn8mmRBoYjW7Yp0OGIO6zpbJFD0qXr9PtZyN3p77lJZNOMY4H83CwcykzTTYw3N92
 Aeg8SGn64lNfLddKEctU5FwTGl9K5miEyDIt0p6JHbeCL6z6+V6L4RJA74Gsi/JziQbD
 lxJgIXg8sVSKEdTPEEpN0x5hb3Fd/0Jke/8zfaHpa+lNFQcMkpTbNOTDJhnt4jvgQRLW
 Tp0Dy+i5X5GeKispxbQAB8t31LJBuIy3YAzGqaJQnUfVcEGf++gRDJbsbxcp01fal5+x
 CWJw==
X-Gm-Message-State: AJcUukeWQ2rd8WNfTGhifpdcVvFd5VeJj2l4KaOgNDhi8mKaiYYOv51Q
 WCiDl+ItucMEB0UXVUzM5p4ZR/TwOFvRVQ4RKQ2fHC/9R84=
X-Google-Smtp-Source: ALg8bN7S2x4BQYl06MueRUBpbAY7vAJokLm7goThgWZDbetRSNumPpcg2FrQ9UV0AbfOdc5XKGg3OBP8XSuM8ToMQ3g=
X-Received: by 2002:a2e:9107:: with SMTP id
 m7-v6mr17670146ljg.23.1548073919809; 
 Mon, 21 Jan 2019 04:31:59 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdZ-WSqRmL=J2LCEoU4dz1DrOTUwbF9tutVZaovEbat+qw@mail.gmail.com>
In-Reply-To: <CACRpkdZ-WSqRmL=J2LCEoU4dz1DrOTUwbF9tutVZaovEbat+qw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Jan 2019 13:31:47 +0100
Message-ID: <CACRpkdbG8FomArY-jC1WQeR0zmaDY9qiw+YwVcUrvsxUR-3J2Q@mail.gmail.com>
Subject: Re: [GIT PULL] Nomadik defconfig update for v5.1
To: arm-soc <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_123202_171681_8851528B 
X-CRM114-Status: GOOD (  15.65  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Did this get dropped or postponed?

Yours,
Linus Walleij

On Fri, Jan 11, 2019 at 8:36 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi ARM SoC folks,
>
> this is a defconfig update for the Nomadik. It is activating
> drivers that finally fall in place in v5.1 so it is targetted for
> v5.1/next.
>
> Please pull it in!
>
> Yours,
> Linus Walleij
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> tags/nomadik-config-v5.1
>
> for you to fetch changes up to bf355705d7143b01894f60a713c5975bfddb7909:
>
>   ARM: defconfig: Update NHK8815 defconfig (2019-01-11 20:15:08 +0100)
>
> ----------------------------------------------------------------
> This updates the Nomadik NHK8815 defconfig adding a few
> drivers that trickled in.
>
> ----------------------------------------------------------------
> Linus Walleij (1):
>       ARM: defconfig: Update NHK8815 defconfig
>
>  arch/arm/configs/nhk8815_defconfig | 41 +++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 14 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
