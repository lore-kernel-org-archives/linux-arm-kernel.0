Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435DFC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:29:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C6620849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ALpsmDiI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQuiJlyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C6620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J+U34wW90LmqLeZjIvXgFyl61VjgysZOFKzbuk2Z+ao=; b=ALpsmDiIIVwetL
	vOMZl0n3I9E890XnkVdYoSNh4WVQtTjHTWkgAPoL8oC0nkhCk2uUDTu5O3ig+C10dNd5AMCXYyf59
	oP7rQBr1HlUpr87kOCr3lOjIlYP6Pid9tc5EZUfXG4NOnu0vueUywkEsRNoIDQm0ShGA1153i/SzZ
	Hykn+iO/+brDTGH5xR/kChY1Ffs8oNCwxNoOyi2zPg9P0do3T9aqFuBOgc3LmdG51K97Qj29CmZkq
	7qPwhtQJHYf8Lgdajkb4kSLOYerEz6DuQCLCw1nv8udyD7qvZOsQbeXxWMBDKagM/08U3MNRR2q8W
	mqvOv3fVjsA2vY66NFew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXLR7-0007vn-Ea; Thu, 13 Dec 2018 07:29:33 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXLR4-0007tQ-EM
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 07:29:32 +0000
Received: by mail-io1-xd44.google.com with SMTP id t24so866327ioi.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 23:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9EOdrHiOWxYQdlpEG21k4ONStXGY4p2qWeE2RcGhYm8=;
 b=RQuiJlyFYRGZNvWZbffX0gdj2i3TcapbbFAoXKvDetUDTUXSlRCOHINqiKEnQT1RWi
 kPrYHa51BOvpICSgzAb7MBoHs4NWmvxKSJSHCLLRjxMzGbZggvbrTfrUZu14gbTStySF
 xenwpJzLcN6pBZjDx9aXTvXD0yjA2fao87tnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9EOdrHiOWxYQdlpEG21k4ONStXGY4p2qWeE2RcGhYm8=;
 b=sGo8Cl5jZhHgNlrEmvsmoFTHw7/K9PIS/+WcqXNIYHDWgCZH3UkiS7/K8aR7lCJY5w
 lgXxjPkIWSqUZ3WTjNRt1CroAJrzRWtoO+XRoAX41DlWnCkylRWTa1NXkdUefkR1hyVZ
 7gm9s5p+7PCJeo2zod0Te8sJnl2Bf5VaDdM+w6KWlDw8Euyp06bk3rrl1v4hnnIDbTAu
 Z/TY0gX7i/RiJFUDwZinZFQxNH0JdoYisjSeT8fA8mqPvHPBGWKUkg4ByML5RXCErcB4
 I78tb2bF5mTdZMKBdZmXnZluCax6/+I77+kP51Quiuof8x91LsLqa1VdMrC06te1Xmgh
 tBeQ==
X-Gm-Message-State: AA+aEWb6Rz5FiI3eaMeCOqt9lwFal0cPsQVcSIJXSDPtLirlL32yW42M
 OtDeouyBOR4rXD1Korxa2LpAzY/g8ajTq7zI5DVirDp8
X-Google-Smtp-Source: AFSGD/VkmYFEClYWVaEc2S2tCHenmseVkl+jzyvmps+0WDujcDZT33bVXbjvh8aSVGqPG+hooU6Xir4KD0PHbtFao6w=
X-Received: by 2002:a5e:c303:: with SMTP id a3mr18523435iok.53.1544686159250; 
 Wed, 12 Dec 2018 23:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20181212122800.GA29450@jax.ideon.se>
 <20181212213617.mltwlxfcbap4prlj@localhost>
In-Reply-To: <20181212213617.mltwlxfcbap4prlj@localhost>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 13 Dec 2018 08:29:06 +0100
Message-ID: <CAHUa44F=_DmhnvKxCAfErBcGL96=nmW0eSvgdhkF+pb+c-zhjg@mail.gmail.com>
Subject: Re: [GIT PULL] tee driver fix for v4.21
To: Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_232930_481260_4B1487DC 
X-CRM114-Status: GOOD (  15.29  )
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
Cc: arm-soc <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 11:16 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Wed, Dec 12, 2018 at 01:28:00PM +0100, Jens Wiklander wrote:
> > Hello arm-soc maintainers,
> >
> > Please pull this tee driver fix for a possible double list_del() in the
> > OP-TEE driver while uninitializing.
> >
> > Thanks,
> > Jens
> >
> > The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:
> >
> >   Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)
> >
> > are available in the Git repository at:
> >
> >   https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-subsys-fix-for-4.21
> >
> > for you to fetch changes up to b2d102bd0146d9eb1fa630ca0cd19a15ef2f74c8:
> >
> >   tee: optee: avoid possible double list_del() (2018-12-11 14:38:21 +0100)
> >
> > ----------------------------------------------------------------
> > Avoid possible double list_del in supplicant comms
> >
> > A fix for the OP-TEE driver to avoid possible double list_del during
> > tee-supplicant communication while the system is shutting down.
>
> Do you want this for 4.20 or 4.21? Seems like .20 material to me but the tag
> name is 4.21.

It's just that we're so late in the 4.20 cycle. If you're OK with
taking it now I'm happy with that.

Thanks,
Jens

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
