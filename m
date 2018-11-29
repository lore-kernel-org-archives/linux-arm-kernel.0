Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4DEC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:25:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF0620989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tfl4FrE7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SskGSv5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF0620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZRUcs+8KK18p4SL6/d1oIbOVucCmjXlDzAghwcONj1M=; b=tfl4FrE77kXotq
	Eh78bE51Bwkf2l0ODOrikaQGECwMKFcHRcRqC4XlPDdwTymrYl6JpgzY+4Wsec2PU4vlBbArSgzJr
	I5KprGRSY6gpKgSUi6ErAPmxrLyViNRH2fLfq8SD8qz/iQapok9theKB3/rttLNnoUamssCgwDgK3
	6iTT2U/Ogd1odangPY1CzZIgMIz+YbJ1+HTE9pKaX3FtGQ0oz0dufRlMtb6HzP/hlmFt10zSzMjeV
	EdXsofD+j32U86cXWgZCsH0cG2DRbhmVGogHErHoi1eoBwrWBmiClaMLhgd0jvgXdzb54ir886BeI
	Uf7GezrX8DQ0FXgV5EQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSVgE-0004Zo-1Z; Thu, 29 Nov 2018 23:25:10 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSVgA-0003Lk-Lx
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 23:25:08 +0000
Received: by mail-io1-xd43.google.com with SMTP id t24so3078023ioi.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 15:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AQ+WFkdZwE9CtNgM9j7g9M5KPCWqo/rsOlSZBVBeyVQ=;
 b=SskGSv5RWeUrL4sHxhqqO32YGFoc6egQqGGrhrlyxf5et3+04XdfpUzzSZPBWnAf58
 9s3kEsz/WgFnfq34jYKPfKmUdoJcFBhlqEvGpoxqEU9TXcnkEeZ6dCaKWkyYqYpetHUt
 u+LfWkTmWb3YWnQoECZ22C/R86Ng/Ks1d4DmTay2VoEInDn1Mftkh2mAezpUfb6X3Nbl
 prazV/KQEEwl/k0z/shFknNViyilj0mCRwE2ds0e9yc3rrggnjTyu/2mxsKM1wwzqmwd
 u2oK3Af3koLA1Ljh/OLcov/ujPG9/N/6uZAmeezXpV4q/+KlVTUYcJdScmN5OhMIGio4
 nFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AQ+WFkdZwE9CtNgM9j7g9M5KPCWqo/rsOlSZBVBeyVQ=;
 b=GBs2MDcr1pXRAnBv/2a+X1EU/oPAtNRLY1JhnURkvWqdvM5gYMg98uxgJuRGBo7NtR
 Vq1b1ZzORpjZAuBw6yh3fWigSXNW9dygSdiDDlzDH+rO3vr9NoMdS4naDN5vug1T7smI
 +hzCLMIIv2r/5C1DGuHUkyqlsOnpxYvGNov5zUztYW8VvSiTo3sf+EZm25HjXGsU4KoY
 QQIUK7ZkpXd7HO7O/LxUciH6JHd003r8HlJGRBnEvT44ZIPR0h1H4PM9QJFARMJ7P91v
 4fbv/Stp/p9IN8mdsrAcH9nOgzDCGkrXhEwZZzEuALEznBoSPDvWNRDyjXisLrt34TtE
 IuJQ==
X-Gm-Message-State: AA+aEWY85z316aYd+zi7v006L4ZDWWa4uJpqRhBnao0dswvhzCejzfEW
 bpqJiO9nuDjB6fSVddurjK+dxuLd5Ui3/bJNkn8=
X-Google-Smtp-Source: AFSGD/VFoEKK4gWpOWU+kQzAWkq4jtzGR1deHfy8sR+HAmXFQHBuimwJCw9vI5DepR1ieSggZ9eXpXhaegvIPCESgZ0=
X-Received: by 2002:a6b:9156:: with SMTP id t83mr2863627iod.248.1543533894125; 
 Thu, 29 Nov 2018 15:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20181129163826.178670-1-swboyd@chromium.org>
 <20181129223600.GC32306@hector.attlocal.net>
In-Reply-To: <20181129223600.GC32306@hector.attlocal.net>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 29 Nov 2018 18:24:41 -0500
Message-ID: <CAF6AEGvWekbG6WsB_7Ux9FAdcci8xrHUZLcCd0rw05CNLNqQRQ@mail.gmail.com>
Subject: Re: [PATCH] drm: msm: Check cmd_db_read_aux_data() for failure
To: Andy Gross <andy.gross@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_152506_724852_805A046E 
X-CRM114-Status: GOOD (  12.66  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, lkp@intel.com,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Sean Paul <seanpaul@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 5:36 PM Andy Gross <andy.gross@linaro.org> wrote:
>
> On Thu, Nov 29, 2018 at 08:38:26AM -0800, Stephen Boyd wrote:
> > We need to check the call to cmd_db_read_aux_data() for the error case,
> > so that we don't continue and use potentially uninitialized values for
> > 'pri_count' and 'sec_count'. Otherwise, we get the following compiler
> > warnings:
> >
> >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_arc_votes_init.isra.12':
> >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count' is used uninitialized in this function [-Wuninitialized]
> >      pri_count >>= 1;
> >                ^~~
> >    drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count' may be used uninitialized in this function
> > [-Wmaybe-uninitialized]
> >      sec_count >>= 1;
> >                ^~~
> >
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Evan Green <evgreen@chromium.org>
> > Cc: Jordan Crouse <jcrouse@codeaurora.org>
> > Cc: Rob Clark <robdclark@gmail.com>
> > Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> Thanks for the patch.  Queueing this up.
>

from talking to agross on IRC, seems like this becomes an issue w/
other patches he has queued up for 4.21, and I don't think this should
conflict w/ other stuff I have, so

Acked-by: Rob Clark <robdclark@gmail.com>

for Andy picking up this one

BR,
-R

>
> Andy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
