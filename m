Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF8AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:25:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F99217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nbboX7Tk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EQVaNHHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F99217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C210YGIb+RYkXrlFe6giP4vWUORVsr73EZ4vj3KXTfs=; b=nbboX7TkPpqq0O
	kIaJDzMtdWzPKfVtRASpODzYEJn3q4uDyYLcXW+4QXBKK4bnsJ5W2Qedgix0DkR9i7q3yloe3lbyQ
	jlC0RKoYz9iMrWdi53YIhnhE3jbhQf13HN3If8CpJQnF3gc7DMK6QRGPX5YNdz9ldH4MAh7WWMhQg
	a+zlLSRTKzv/vW0tWC89oWMovcoU26DsviEc5orXLURgtUZPJ40j1zwpEwnCaJJ9cHZl7PUIbYSRz
	DrtG9apnyn1FLeJF+TzFbpLZ/LZoUtmYAuHSW9kEQ4dW8FPSqJU56/VZSBjSkbI2i1yWCAf1nQoxV
	Ecjm7eIIfw2RDpvlCPZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfDIX-0005Xf-If; Fri, 04 Jan 2019 00:25:13 +0000
Received: from conssluserg-05.nifty.com ([210.131.2.90])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfDIU-0005RP-H0
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 00:25:12 +0000
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x040Ot4P027688
 for <linux-arm-kernel@lists.infradead.org>; Fri, 4 Jan 2019 09:24:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x040Ot4P027688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1546561495;
 bh=Z+Gv25mzqE+Yw75/hsSqQ+Lf4AxdSw/wX4Y1Bj16CpY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EQVaNHHDafyS2BJK3wguTYIEaLy4ikXivrk8+Wc1sfLqE3NuXo//OJjaqIO+Rvw6M
 Ib+LHCKkm9H00yxIUGy5Zehh5s4+V9Ct13/PHLigzV4gPL6Te1K0oLwBvr/kyhaUDE
 giaLtBobveiB+I+shc/G7nfwXDYLU3jhr+8IOwk2S41CtOO8ujqKvjnil3idBih/oS
 vGGE0dBnJWbnjatpAYuUBuH+c9Ih64bW+4SRWZqwtQRo8ty5Tne5xkMKt9Md9wVS9I
 bRWEaXwt7NjFUxRtSW0ldr8H0fkLQjg/Jrac4U/Qklrhx16Xk00iNS92YHOQUCqA1C
 3U5ztUlI2RUaQ==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id 197so7631045vkf.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 16:24:55 -0800 (PST)
X-Gm-Message-State: AJcUukckJBHH+6GulXYRZWeY73HQh/OcUxu6RkOqu4ycfQHkfiI5q68Q
 8erPzR0pUxWQ/S22d2PZak1hLJLLZREpPQPmFSM=
X-Google-Smtp-Source: ALg8bN5/Z8Gy2QTgsmOI6Dc3eiuMgamPh/YzM+FyZaHzoOCOlluYvoQ6qFDFiRFsbFujpONs7lctNE9ym1D5n3StmzY=
X-Received: by 2002:a1f:27d7:: with SMTP id n206mr18601814vkn.0.1546561494352; 
 Thu, 03 Jan 2019 16:24:54 -0800 (PST)
MIME-Version: 1.0
References: <1544760112-5378-1-git-send-email-yamada.masahiro@socionext.com>
 <20181214095155.GA1872@edgewater-inn.cambridge.arm.com>
 <CAK7LNATTGxopJJsj=sakmqxwpyETgG7ToS8tm4kLcF2jekNcFw@mail.gmail.com>
 <20181214103721.GC1872@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181214103721.GC1872@edgewater-inn.cambridge.arm.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 4 Jan 2019 09:24:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARztSNM1XwqxcZrZ7Y5GKs_53R3LnbPGhDSLOr_1awoKg@mail.gmail.com>
Message-ID: <CAK7LNARztSNM1XwqxcZrZ7Y5GKs_53R3LnbPGhDSLOr_1awoKg@mail.gmail.com>
Subject: Re: [PATCH] arm64: replace arm64-obj-* in Makefile with obj-*
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_162510_779450_DB4E17AD 
X-CRM114-Status: GOOD (  15.03  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

On Fri, Dec 14, 2018 at 7:40 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Dec 14, 2018 at 07:35:57PM +0900, Masahiro Yamada wrote:
> > Hi Will,
> >
> > On Fri, Dec 14, 2018 at 6:54 PM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > Hi Masahiro,
> > >
> > > On Fri, Dec 14, 2018 at 01:01:52PM +0900, Masahiro Yamada wrote:
> > > > Use the standard obj-$(CONFIG_...) syntex. The behavior is still the
> > > > same.
> > > >
> > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > ---
> > > >
> > > >  arch/arm64/kernel/Makefile | 59 +++++++++++++++++++++++-----------------------
> > > >  1 file changed, 29 insertions(+), 30 deletions(-)
> > >
> > > I'm fine with this patch, but I think I'd prefer to apply it at -rc1 so
> > > we don't end up with lots of silly conflicts in the Makefile for any new
> > > files added during the merge window.
> > >
> > > Is that ok with you?
> >
> > Sure!
>
> Brill. Please poke me again in January if it hasn't landed by then ;)
>
> Will


I just sent v2.

https://lore.kernel.org/patchwork/patch/1028882/


Thanks.

-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
