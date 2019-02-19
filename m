Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CE5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:11:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F5821773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cfi8Vxyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F5821773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HIL1H+rExBlf9Ozr48wEUkU779Oi19t3qQobJNlCys0=; b=Cfi8Vxydu+TL9d
	kZOlAqNRNCOnNkm6VB7i2l0qIgdbQcBUQ2Wf8gks/0+MBm/MiwiJF4Ei+km0rt5z5YFB0enkGGRGl
	siexPNrjFOc/FPgl5X7ZPmNdr+Uk8L5SG+V+RFHNg84JaiSsLdbbGw+oGsR5EzWQ1jdxGAED53fGr
	Q6FuZd53ET1Q551q8CwINSJmQhHh7eWrmsz3CuWz2i0jR/7UEg5fLiF3q1nqRTCJF6VQ7/Ppz4KQ5
	4g7zW5LZpYL0UTXLE/12YZJUG+5VvKAqho5S4cLP4JCs8LoGkeBBqGZM28zBKCLYqovY4LbH16M6/
	tNrFCc5CLbhqSJFgCK2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw2NN-000822-VC; Tue, 19 Feb 2019 10:11:45 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw2NI-0007xb-Qe
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 10:11:43 +0000
Received: by mail-qt1-f195.google.com with SMTP id n32so22405803qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 02:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GKEeWi6nyKswsgXAGVDZ/Sod1fD7earVCrPKBugb258=;
 b=Hs/88oRm1tNVU4NeITKQrTKXuBLBfLi0fNXQmCnSuFI807V0ZI70ticf0lEc4IEMji
 qsVv1ol8OSF+5WkuN8+FPPpkZQ8+UV9Vwxlta8t1Op0ubh9eoYsytWWam0nxp96mA996
 ZUNAs6ZSgyj6p5g2P8WrFeJ46gdCKr751gR+lvcBc50QhLnI0xtWt0kcnthUt358j27r
 q4yMnCDbMZ+hcyCZIWHMrBnVAGHcnftYBMRZjx//L4q8zSnyRv3v238K6XRMuZl+hM/k
 LzqNdodp7UljidCHxGcKL3dXFTmRyCLudO1s7ogR5zB+46DJRLRnfBC27yDy90LqlbnX
 rIUQ==
X-Gm-Message-State: AHQUAub7TQrBIL6vsNWn76I52SlmGrhUoiGpX39dr8YmWzomJBFHMjjh
 bu730rmd0t4RA5p8JOhHIiOQ6sLTlhWroEJkATA=
X-Google-Smtp-Source: AHgI3IZ+O8tl4JFIwKUJGm109X1HiP9tOENsBjOokyVsOlFY8bSic4ZEhYijWiv8JO4Tfket02xvbWKDw02pQoEBC9g=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr21565641qtn.212.1550571099770; 
 Tue, 19 Feb 2019 02:11:39 -0800 (PST)
MIME-Version: 1.0
References: <1549628920-32623-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a15mLEgVAh1+jQ+GqOcQa0zhrePWofo8iGkTs5_bd=TmQ@mail.gmail.com>
 <ba5bb646-7fa6-e98f-4ac2-47c55c8f82ba@socionext.com>
In-Reply-To: <ba5bb646-7fa6-e98f-4ac2-47c55c8f82ba@socionext.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Feb 2019 11:11:23 +0100
Message-ID: <CAK8P3a0H3wYKqiV6XZe9V_y8rjDTFHcU_jq7+HkwX+6dnXvU9Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] ARM: dts: milbeaut: Add device tree set for the
 Milbeaut M10V board
To: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_021140_898075_719BD7B7 
X-CRM114-Status: GOOD (  17.14  )
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
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 6:11 AM Sugaya, Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Hi,
> Thank you for you comments.
>
> On 2019/02/18 21:09, Arnd Bergmann wrote:
> > On Fri, Feb 8, 2019 at 1:28 PM Sugaya Taichi
> > <sugaya.taichi@socionext.com> wrote:
> >> +
> >> +       aliases {
> >> +               serial1 = &uart1;
> >> +       };
> >
> > Maybe start with serial0 here? It seems unusual to start
> > counting at 1.
> >
>
> The M10V evaluation board(EVB) uses a console with uart ch1, so this
> alias number is derived from the used channel one.
> Therefore it is no problem to change the alias number to 0.

The alias should normally reflect whatever is printed on the board,
if there are no labels, the convention is to start with zero, regardless
of what internal uart is connected to it.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
