Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E608DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57D82082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pFgXGTey";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j5QsHq97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57D82082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gp9Hpmhasp/CCluiMTUrK7DYp2Q0/Yp78AqZQdcsFyY=; b=pFgXGTeySL1VBQ
	5Tjq/gWLF4Pjz6PuPhaCAErS749pX5YRKFB+oX43GIUGXsM6aQRh2cvWAc/CJj0wACstRe8rzmZWw
	5Xy8kL5NM4doGIw/YyHAtPA6rqcZTOGa4Xs6xdU1MeL74qW9pZ5ILCQJanmoIT/oPiuHvcwuD45wP
	mvES/y3ZNyfy8w2GGFEffgGUr59PTVi1MdWR2NUcpI/LFKBlSSq3t0wwiumRksekbYWDHlTdTESBQ
	BQXlXSHEz+oDVTj97Tv60hDATjkhLFnL39/E3kh3WDorcmY3o+y81A6dHONRX7Qan678FerRjcNxy
	0+ydViPiunGGUH8MY6vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUkld-00028M-SS; Thu, 06 Dec 2018 03:56:01 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUklP-0001io-Et
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 03:55:52 +0000
Received: by mail-ua1-x943.google.com with SMTP id z23so7947835uam.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 19:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A8p+oRvH8GClZ33XJ1CZx0DHSum1K8zcjO/xC+vm0bM=;
 b=j5QsHq97UGqU0OBmZna87WHV41lURwPRb2drmQkr/G8Bliki54vX3sKmC0INm9NfYS
 FE2k57kV8JASXSdw7sYz8TVv8u6FwTUFxVLZBjRuyHo/+//6Z9PMnBH4QFj1RTpFnNOD
 mFo+xB0TALi8a0cj2elpXBBT9WvqRBrdDXsrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A8p+oRvH8GClZ33XJ1CZx0DHSum1K8zcjO/xC+vm0bM=;
 b=Z+/ALvkezZR9K5o1nW44n6zUfoXeNbqpfL9ueA8n9AY3onq2frF6VV/S6D8RnwGT2v
 Amfs3r3iMSbD9kL/rmSdoDsTmTAPD66l4YCiTts/WgCNPiJTifhl6XPSbtep6+O7sfej
 VsQLy/ymEU82a/uWNVpha2YUoNOpSz+iE/QszLOKLYMy01N7x4NCOVqUdKYdatjFBxtP
 XcuqO3DxmsdIUWutV+xeauU7ClwkR7mXrCHEcIoyBbim3TQ+4aDxKWqOP14zDjyZV6/O
 seQvcrFn/1Ufz77xUo9azRn01nt1UlDDUPa6ycI9qaSqopljL+lWsnaXd1nvEmuQ8U6M
 eUFA==
X-Gm-Message-State: AA+aEWa8vVbGqgVurbTELG+p3xQY7FNB9WbfmBICmC/IAs+sUtRXbPgz
 huU/Fyjv6hMmhkfVkrHKWq3fuNAb6I0=
X-Google-Smtp-Source: AFSGD/UA3FVk1vnG/J/t9oC9ANQ/3l9ycRxzMZGsZTy66/xzClvuRFuc98GJlvUb2t6dCpKY13RWnA==
X-Received: by 2002:ab0:1c12:: with SMTP id a18mr11705674uaj.15.1544068534772; 
 Wed, 05 Dec 2018 19:55:34 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com.
 [209.85.222.45])
 by smtp.gmail.com with ESMTPSA id m89sm6681153vsh.22.2018.12.05.19.55.33
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 19:55:33 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id e16so7918242uam.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 19:55:33 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr12691635uac.122.1544068533318; 
 Wed, 05 Dec 2018 19:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20181130150859.27366-1-anders.roxell@linaro.org>
 <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
 <20181205212651.488d9cd4@vmware.local.home>
 <20181205212945.58edee31@vmware.local.home>
 <CAGXu5jJeyBRHPhKKRyp1=NCCdBfrJw=mdg4+XCEL413ZtkyU1A@mail.gmail.com>
 <20181205224333.3c589916@vmware.local.home>
In-Reply-To: <20181205224333.3c589916@vmware.local.home>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 5 Dec 2018 19:55:20 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+PjtxDD7sCCPwVf8=Ofzx-=6OT14xAKdV3vGqJDgx7XA@mail.gmail.com>
Message-ID: <CAGXu5j+PjtxDD7sCCPwVf8=Ofzx-=6OT14xAKdV3vGqJDgx7XA@mail.gmail.com>
Subject: Re: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
To: Steven Rostedt <rostedt@goodmis.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_195547_893957_ED73B353 
X-CRM114-Status: GOOD (  15.22  )
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
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 7:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 5 Dec 2018 19:29:11 -0800
> Kees Cook <keescook@chromium.org> wrote:
>
> > On Wed, Dec 5, 2018 at 6:29 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Wed, 5 Dec 2018 21:26:51 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > > On Wed, 5 Dec 2018 17:08:34 -0800
> > > > Kees Cook <keescook@chromium.org> wrote:
> > > >
> > >
> > > > I'll Ack the Makefile
> > > > change in the tracing directory, but the rest belongs to others.
> >
> > Okay, I wasn't sure. Anders's patch was marked "1/3" so I thought it
> > was directed at you. :)
> >
> > I'll grab this one in the gcc-plugins tree.
>
> Should I just take patch 2 then? I'm thinking it's independent too.
>
> I'm collecting patches for the next merge window right now so it wont
> really be an issue if I do.

Sure! I'm not sure what Anders's intention was, but yeah. :)

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
