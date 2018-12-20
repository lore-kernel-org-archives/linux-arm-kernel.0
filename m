Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2DFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:59:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A433218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XEWwXZkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A433218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0uP8Bt1Prz1b2UsFuzXwemeAtykMgWkHFy6HAMoN4/w=; b=XEWwXZkWrHiEdL
	mw0jjDzvUW9rwCPg9t9kFROKeDccMFC65sA3X8KsH3MFHsYfmS6ENjKRGlYR8WFd5UpOjC+sDwgnN
	n9Oe9+WTvsNM7KUJuH4t8ZEi11xKXtiRVQkRPB+C2bmbhLi6TyYOKHDw/Hp8f/9/v5JJ1vaaCxtM3
	TWlPx/HZgqshhmuyJgcsn5BSlvTzut4kS9KkJv4XnySsxgNg/XYdN5cPUldmOZMOwXMh0ddqyPMk4
	HLHBox3ILxNRGB352XSTVXn+5tUL2O6jtam01aFJA4oB5r5Gj2zk49gCDDx4K/iMz3J9MFc1+3UJ5
	V0rg0ygvtmkk83VE86hA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0jZ-0000qY-9f; Thu, 20 Dec 2018 15:59:37 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0jW-0000q5-8u
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:59:35 +0000
Received: by mail-ed1-f66.google.com with SMTP id g19so2163124edy.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ayq0w2cwuOSy07jq4d4aibOw4krZLC8XeIRVzrZd/Qs=;
 b=c091AVM/WsLZk/52DQISilStTjZBYfGdPucA9JwnzzCcIJF0bZvVUdLUX2TH7x2kAM
 wPkkakBWRW0Wf7QTXkag1gobTWPGoeB15YWIP65CZIjrHXlxC6kqaxc8VOKUUfuU12db
 zc/LbZQ8+blPD4XttEHVYlp+CcLrhQxPiTLbgjb0Ro23zOnMK2VY2WH6dEXZioG8aPKd
 Z0QyMmemLJpZlmsBbITQ25MiqIT6u3Sw9Gne5XebMGvsbQNco0SqBkWjU+/Ng/8Dt2HF
 pi46BtviGLgk2tnpfSzT+nhPVl5YIB4biMdmR1uwd8Yjll3A91V6gYUcWeW10q+CxeY9
 dS5g==
X-Gm-Message-State: AA+aEWbJhUgvCd6nQgk3x0biM6OzSuElsCFPr44KTgEBjoLAGXusaaHB
 FTaOalWAdaJ40euM6BAvlHcnQLNJlkU=
X-Google-Smtp-Source: AFSGD/XKLGgSJ5x0Oki4YMWlKGUiPtbIjtt4c1DglKQqJ02bJZe9A2gEh39bqJ8fYil7snSBiJiJtA==
X-Received: by 2002:a50:903c:: with SMTP id b57mr24733714eda.161.1545321561442; 
 Thu, 20 Dec 2018 07:59:21 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com.
 [209.85.128.47])
 by smtp.gmail.com with ESMTPSA id d5sm6256681edb.48.2018.12.20.07.59.20
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 07:59:20 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id c126so2757669wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:59:20 -0800 (PST)
X-Received: by 2002:a1c:e58c:: with SMTP id
 c134mr11725108wmh.124.1545321560542; 
 Thu, 20 Dec 2018 07:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20181219095546.GA2302@wens.csie.org>
 <CAK8P3a2j7Hu7yK1wPELFr0Ke5MDFBgVnn7WjoQW+Xsv12d3weg@mail.gmail.com>
In-Reply-To: <CAK8P3a2j7Hu7yK1wPELFr0Ke5MDFBgVnn7WjoQW+Xsv12d3weg@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 20 Dec 2018 23:59:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v67jfh+e6vbnjVsYDUwpSD4SEdCq+ujUsovpBNQNwTPOZA@mail.gmail.com>
Message-ID: <CAGb2v67jfh+e6vbnjVsYDUwpSD4SEdCq+ujUsovpBNQNwTPOZA@mail.gmail.com>
Subject: Re: [GIT PULL] Allwinner DT changes for 4.21 - Round 2
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_075934_312575_776F9B5D 
X-CRM114-Status: GOOD (  13.05  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 11:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Dec 19, 2018 at 10:55 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > Hi Arnd, Olof,
> >
> > This is a late pull request for 4.21. There are two patches, as shown
> > in the tag's body. The first is a fix for content sent in the first
> > pull request for 4.21. The second is a patch from a series that had
> > been posted over a month ago, and the driver bits were merged today.
> > We'd like to have both patches included for 4.21.
>
> Pulled into next/dt, thanks!

This pull request also contains "ARM: dts: suniv: Fix improper bindings
include patch" from Maxime. Hope it doesn't cause any confusion or
conflicts.

ChenYu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
