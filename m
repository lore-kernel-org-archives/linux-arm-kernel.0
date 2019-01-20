Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2E5C312E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 23:03:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303EE2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 23:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hRWEI+D/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="WPuF9T/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303EE2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S5JFdqyBMCmmF6av/PxmSOjbuz2D3KrYLQzrR9A8tfw=; b=hRWEI+D/Qx29va
	W7idyTJfqHm4Fdwy9OykrOiUQ3rRhxQv88mQMxhNbVrbkDEEszoLKwe5swHAYxTnViEsv8NlJkR0S
	21MPlHbR9gw6u61iynYdDVwSxV+fYttCK5LrsJr/CElinRLtrds/rVyYjBAoMJizS78boLri5rLkf
	uvL2uQH/qD931F7zkc2mRjZR9VvxJC76FTHYZnOgl8TwZEZiNTI5KwIvmAi0pPnNwwx55Oit02yvm
	7T8vEVCeHenxc6MARdne6WTUEJWgqMJBKiHNgNe3yJlYTDV4+kG+/Wlrt84nx4m4SK1Oaejn0zveN
	pWxd5akZdlS63zN7SZAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glM7a-0006lj-Dq; Sun, 20 Jan 2019 23:03:18 +0000
Received: from conssluserg-02.nifty.com ([210.131.2.81])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glM7T-0006G7-IZ
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 23:03:16 +0000
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id x0KN2sjY027087
 for <linux-arm-kernel@lists.infradead.org>; Mon, 21 Jan 2019 08:02:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x0KN2sjY027087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1548025375;
 bh=aRBwAHCJjE+UccnuzL66nQadi9hDr8D4VV29P0+GpFo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=WPuF9T/megiqWIwqX3/c2V4/OAEQqHyqcZJ34JqTdL20JkgWinRaIcWztMVQeFMcN
 SckoebVmltzClL15+DmtBszmWM1Yg3I1vKq9p61yuhZKj1ET3jp4wPYxlX7nxrgoIr
 rhnnz6NQhxsDwIOl/5Lfur21YHadDp9soRt2hhaUVKOVyjj8JTPnWmW/zbJ1L/drDK
 8WqHNQwK158acjm6TR0+Kg0A9Aes+X49r8g2mwA9efe/mU6/BWAF3m3RpjIvYLrdrL
 biINyBPgY+X75+P7dsPps/MB/PhUj8IQ5IPwsD8NwLotldbfiQeik/4gZ1zUw1YMdQ
 KqpDPEl7LWHlA==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id e7so11601272vsc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 15:02:54 -0800 (PST)
X-Gm-Message-State: AJcUukfBTOF+vLk8VyCl8iGlPzExfTQK84YxW/XJiS6jG8ouuQ777EFZ
 QNcROEnHXbjAd2p5ztSj8vNFbooyWUITWoNDTrI=
X-Google-Smtp-Source: ALg8bN7g5/2sAjTND87vWWeoGejHVy58YX96EPLHEMnzhYhbnd95AXz4HeaHoQAmWJB3z6WfVpt/MysU7uRNZ/fHwhE=
X-Received: by 2002:a67:f1c2:: with SMTP id v2mr11346664vsm.181.1548025373763; 
 Sun, 20 Jan 2019 15:02:53 -0800 (PST)
MIME-Version: 1.0
References: <1545283393-2078-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1545283393-2078-1-git-send-email-hayashi.kunihiko@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 21 Jan 2019 08:02:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARYk12eSzFDr7r7UQJD+0NZy9fgJtuxCV3ZYuA4WS3pjg@mail.gmail.com>
Message-ID: <CAK7LNARYk12eSzFDr7r7UQJD+0NZy9fgJtuxCV3ZYuA4WS3pjg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: uniphier: Add PCIe host controller and PHY
 nodes
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_150311_945060_C0AE549F 
X-CRM114-Status: GOOD (  10.63  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 3:46 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Add PCIe host controller and PHY nodes. This supports for LD20, PXs3 and
> their boards.
>
> This node defines PCIe memory, I/O, and config spaces as follows.
>
>   MEM: 20000000-2ffdffff (255MB)
>   I/O: 2ffe0000-2ffeffff ( 64KB)
>   CFG: 2fff0000-2fffffff ( 64KB)
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 47 ++++++++++++++++++++++
>  .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |  4 ++
>  arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   | 47 ++++++++++++++++++++++
>  3 files changed, 98 insertions(+)


Applied to linux-uniphier. Thanks.


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
