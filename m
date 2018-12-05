Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4373DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:01:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1359F2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rDeNiCvs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLN1TbgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1359F2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lgvwPACHYxt34Tdh66Om5GgCEBhVxPppjjh9higjHtc=; b=rDeNiCvsuT8v/U
	yNTOiTJZgrJ1bM62+Q7qtClCFJ0Y3ub26OBhqGpHPTTNpPYxn/h8fH/C765vbjaFciBxLma0u/CS4
	CVZVVF3sXGmsX8LBPF2UE9rarcIQMnzGsm1dhveTAeYWi4yhJVf6GZIqn0nGRJ2rdBZiHaH4IM1tV
	1N1CUm2u+6EBw5TcdJqIe9f6+h61kTwjqZvs2FiPPJL/JhVc1D0xQUReHHhTrTDRxo4MTz/aovETe
	W+FQYHFV1EXM721OnUN5Xy3svUoZK+yCmPX1M599XHwLNJd5A/i1hbrJdJQBOQeyn48SZChaxFBB7
	I1Fj68uYrMjRakugxJyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUVrm-0006b2-NV; Wed, 05 Dec 2018 12:01:22 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUVrh-0006ZE-P4
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 12:01:19 +0000
Received: by mail-lj1-x241.google.com with SMTP id t9-v6so18056230ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 04:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m2c5oGlnNZQ+q799p5nxoQFpGmfGLOYlQnWIGd6mn0Q=;
 b=jLN1TbgRDD/fVzht2/7QZEI/H+QmXGo9ASojBnpuoPuMhxAtvqT8ficnK639nVVdUz
 2HAqRrFhLp7U0nB0Hzcm94SEqLxZ4kddTGgnkO3K9oT0rX4Yxl1pSU1qx5KCr8vBlkTn
 jF5JRVXzb2x+PRoL/MgROZTJU4zRS7Qzi4x3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m2c5oGlnNZQ+q799p5nxoQFpGmfGLOYlQnWIGd6mn0Q=;
 b=AGfZ0o/UDb5TY/V0QP4uUtRuh7baSGZ/Qmqs9ElWv0aAEhyeQzASj0pkzRWHL7nWio
 /ORxOW6DTkPlf96BGHOGHB+j1OPsAjeT6+5S+5gJ36HswyezxQZFp7A63UOx15CnEZzk
 IUV4cuviMuHcj4mKu+RF2hcOk9ZumR1L6TGsvU9xX4ZPJIFKxaoS3Mllx4I1vnAVYBou
 yeHIWbyA5RWM/jvpFbzMn3420apLPgxc2J0wVGfN176WdgBkTDqDOCkXPkyA/mwZU0Zx
 t7ll0CPLOxlu2ua14E3ZJHRNt06lDTGalAGtCDpoN3jB4UeQ98WTOjR8/yvD4hanw7xZ
 PoHg==
X-Gm-Message-State: AA+aEWYiCXShOfc/uVyiPpShWgkUSgS/Y127IeUuCLzZJWexDwDHX228
 QXP/BIyBG1AzewvJ/C8S1GkZmomH1Sq120orhDg15w==
X-Google-Smtp-Source: AFSGD/UR0z7I+ZfII9VWdgf/yzMAx4UJLcvLR82qsUCHyPGzgxUw/jjTZSXN87GC7TAwT6jxOGZwA5pMrwlITm+Z/Dc=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr15422872ljj.9.1544011264387; 
 Wed, 05 Dec 2018 04:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
 <20181107174844.5381-2-manivannan.sadhasivam@linaro.org>
 <CACRpkda25cuiPCe9ouvDDSpFwZ2z=Pm8pK=5jC-7OAcYwPSvvA@mail.gmail.com>
 <c1f63dd8-1c06-1797-025c-2cd4891d905d@gmail.com>
In-Reply-To: <c1f63dd8-1c06-1797-025c-2cd4891d905d@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 5 Dec 2018 13:00:52 +0100
Message-ID: <CACRpkdYCsh3AfmV-7ym-ffjp2k-kaNRqY1O3rd9h-WoUPYM_bw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: pinctrl: Add devicetree bindings for
 MT6797 SoC Pinctrl
To: Matthias Brugger <matthias.bgg@gmail.com>, arm-soc <arm@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_040117_895503_05E45CDF 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: sean.wang@kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 2:08 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> On 15/11/2018 11:04, Linus Walleij wrote:
> > On Wed, Nov 7, 2018 at 6:49 PM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> >
> >> Add devicetree bindings for Mediatek MT6797 SoC Pin Controller.
> >>
> >> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > Patch applied.
> >
>
> Could you provide a stable tree for me, so that I can take the dts parts?
> I just realized that my build is broken because of the missing dt-bindings
> header file.

Since I pulled other changes on top it is too late for me to put that
in an immutable branch and merge into my tree separately,
you would have to pull in the whole "devel" branch from the
pin control tree.

What we sometimes do is simply apply the *EXACT* same patch
to two git trees. Git will cope with that as long as they are
absolutely *IDENTICAL*. (The patch will appear twice in the
git log with different hashes but they will merge without
problems, a bit unelegant but it works.)

So in your situation I would extract this patch from the pinctrl
tree:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=devel&id=95d2f00657ad4c2c3eacd8a871a7aa022c3fe7d9
and apply it with some notice to the maintainers about
the situation.

ARM SoC folks: agreed?

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
