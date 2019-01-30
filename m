Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E45C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:41:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFEA218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qi2YhpvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFEA218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gVtnXdicdaqNF13atfuwRj4/bzISBOu6iCHytX4D5uM=; b=qi2YhpvKU9XMPc
	2G7cjIc2T/x2wZYDnOC5YJKD7OuXOliDcu0Nxm40CFiyxNNJ8knvpi53SwRLqjcPXp4E9/Ybfuapr
	QzS4lbTR4hgO7OLmNoMZiI1OpiICWk62LpUNQGOe4HWREuIP0gAhPOYL3qvPfoBS5n2BJwsle19Y0
	hhBKxcUYytRWn2X84oV7EPMHQ04lTzSPoPvkLNmH8OpflkdhTEk7Vp43hP58kb0y2DdsQ9TXINS1T
	ZT341qGRSXTYgShoS1aSc6DGn2afQQbrakdUpXPiZ32OFvEQlcp6hHI+/UeEovXo7k1FaYlkQCneq
	wB1L4TQ1SCaVcCSP5mzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gonJE-0008BZ-PL; Wed, 30 Jan 2019 10:41:32 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonJ4-00088S-0N; Wed, 30 Jan 2019 10:41:28 +0000
Received: by mail-qt1-f193.google.com with SMTP id t33so25633363qtt.4;
 Wed, 30 Jan 2019 02:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kPRc4f6Jm7lnUZlf6/qwgNKnOho7c+Ceda89iiPHPGA=;
 b=iHx+M/p3PjyquXzzNkxy+KD2KXontcpRCMD8Aty7geL9CpJQShfWAPYFOV8qu6RjQO
 +IQdDZJmrgv1JVFnk1/2HFXz0kMmU2fnmTmLUEmkw31GNd74S+LbtNmZSdx4gsOulTHW
 9muKIH1X02XsLRmoTy8Z4PLPyA2eOFA5E3pO83We89diGHyqCWv6kSKf4aYtBmjDaZjF
 DxGmFLR0YwpGW0pqc/jW9k/4zqsCU5AIfWZZYWp5oVQ0iyEljSXR3t24+tYg/TXgG7hc
 6CZeG/fllp3jho66J7Z2gU0ZiYTDLxIuZVwjJxYCXpweGdp1+O3II4O4D66YXFU0Jpkb
 w4Eg==
X-Gm-Message-State: AJcUukfhT6VlRqGIEBFcpZ2oLWskIk60iZyC5xUay30hzRHgIV/gQJP5
 TLp47Gu0aEJ7gNqHrQ0EsY/biksxYdY10Nu0CyM=
X-Google-Smtp-Source: ALg8bN4/ymL42ypcX143ueQL+KRrhWg2jXUVvjYS8h7BZWw8CyZJ3EL0ygdB+TmL20PQLljxIUMJeaZ7fDyLEj2hbvE=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr28905367qtr.319.1548844881094; 
 Wed, 30 Jan 2019 02:41:21 -0800 (PST)
MIME-Version: 1.0
References: <7h1s4vpkpj.fsf@baylibre.com>
In-Reply-To: <7h1s4vpkpj.fsf@baylibre.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 11:41:04 +0100
Message-ID: <CAK8P3a0UoHmbWdNWbvi6ykp5J6VVXbW0AB9SBDq0vYyZShT7aw@mail.gmail.com>
Subject: Re: [GIT PULL] Amlogic fixes for v5.0-rc, round 2 (redo)
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_024122_054035_E04BAC55 
X-CRM114-Status: UNSURE (   9.68  )
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
Cc: "open list:ARM/Amlogic Meson SoC support"
 <linux-amlogic@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 29, 2019 at 4:06 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Olof, Arnd,
>
> Below is a redo of round 2 of Amlogic fixes for v5.0-rc, based on top of
> the first round.
>
> This drops the a couple fixes as requested by Anand Moon so he can
> rework them.

Pulled this one now and dropped the earlier one. I think what happened
is that you sent two different pull requests for the 'amlogic-fixes-2'
tag, dated Jan 19 and Jan 28, respectively. You retracted
the second one of those, and I removed it from my queue, but
then pulled it anyway when I saw the older pull request.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
