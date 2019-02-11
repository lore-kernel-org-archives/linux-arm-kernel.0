Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1411BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:52:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D387C21B25
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pIrLPpyU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ncBVT9ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D387C21B25
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vv040pnBulyzjY4MYKJ5w2/73OLLZRiI8wKnSeQopyc=; b=pIrLPpyUp4BexH
	0pTgcfEJGfU30GXOqcaVGaEflFcugmLhGdsht43Z5/hVIfCaGWJpY5Pmmc1U6Becyj0jlYQj4aPid
	4MZMOsm4O8ARkGn90Ci9GEyvvqQkoN5q0IE/HsIFhkenKVU5FhT+5SaaQb3g3fvrAw6/sF9g1HiXV
	qsMWSWTcolINpx4l7EcyHFeM94LIN18/4u+5P3ZC56H2wZ6yRrr/JyYKPuOapwMVs0l8g+w0deCNL
	PWVtPjRYBqYw1JW7vOLjTiX4PN0HgkhwXL2JvPft2R1F6OJHZH4UUPnVSWm37ZNDp3yPZffUg2xQb
	1aCNQMh10DJlrOLXE1XA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtGgm-0007xn-6X; Mon, 11 Feb 2019 18:52:20 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtGgi-0007xN-D3
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 18:52:17 +0000
Received: by mail-pg1-x532.google.com with SMTP id r11so5352775pgp.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 10:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=onajfLzjwMOVtd+is/9izGJShjdIldm5SizvaLUaHmo=;
 b=ncBVT9tyNIxZ8aiOn7dnre8Goggom0TvQuIANUcxYHYcAfeeDAW/pJ1tXT7OKgQueF
 MwVqVQuXrOqAtT08VYAKSwE++I0VmP13ZxXyhW0aHCvpPht7QPP8DsjyNB1q9UiS9QQl
 9nis0PU6XVMI930sTgtUCXc+fAmTp6gsgaaqqrv2IrcDnHYa8QQ6hciHJK6+lgRilZhN
 KdqVMLYVj7G0Grzr3UxJ2Dq0ijc+Xx3ACM1wwRK1oFZm7gwjlXdLXp02XnnVh4GoMf0t
 Uhm7OacraCe04mXWaJ3y/+i8oWGZKM8zgc/nBhN60h1PI8Pp5idnG3RIVGXQVzve/sCh
 iKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=onajfLzjwMOVtd+is/9izGJShjdIldm5SizvaLUaHmo=;
 b=H7/qvezpO4ohKMdi6Y8qTGXyMu0LQIq1Q0YrkuqzL5iwhuyvQLgHg7UECRBEgiE9Dx
 OLvsEgy22E6fAfJUL52COmoJTDD8iEiZFVHRgoD8tAkMmP/PKGMIUrC7qSu4k6oZW34i
 RVc2F0eERtVTnkUkJXvH3j/DVaH167Mtw92jnhoIywtOgrmyK3lNDxmPYmjTRs2aZLc3
 eREpuZ5hPmihx9WUqPYR4QPGjwa+9/0rMTclw4vUTcRVuuD+ioTfJjs6GOo0nQ4ZPyXV
 BGh+JQXyJzAYXRCBpFoOLUIzA962D/0kJsiUNan9ONXML9+xuqz2GB9yjihoHDSdzAPr
 9bdA==
X-Gm-Message-State: AHQUAuYwxbAibk40PL7D9IQ/5FdWBmv64bP1ZGOtvcnXHzFp+V9J1ZnC
 a/k4WFa5d83iCdjYdfyCtxrgFTNlWt7QIhc41NL1zw==
X-Google-Smtp-Source: AHgI3IZQFoZrbycn++mXjdTEjZaF9ayC32KEiKRH0Wc/WBMk/e+oR/Sql4ixUe/6CE8nd6+lelEMoUAztsut/G+K/Ak=
X-Received: by 2002:a62:6047:: with SMTP id u68mr37586266pfb.239.1549911132174; 
 Mon, 11 Feb 2019 10:52:12 -0800 (PST)
MIME-Version: 1.0
References: <b1d210ae-3fc9-c77a-4010-40fb74a61727@lca.pw>
 <CAAeHK+yzHbLbFe7mtruEG-br9V-LZRC-n6dkq5+mmvLux0gSbg@mail.gmail.com>
 <89b343eb-16ff-1020-2efc-55ca58fafae7@lca.pw>
 <CAAeHK+zxxk8K3WjGYutmPZr_mX=u7KUcCUYXHi+OgRYMfcvLTg@mail.gmail.com>
 <d8cdc634-0f7d-446e-805a-c5d54e84323a@lca.pw>
 <59db8d6b-4224-2ec9-09de-909c4338b67a@lca.pw>
 <CAAeHK+wsULxYXnGJnQXx9HjZMiU-5jb5ZKC+TuGQihc9L386Xg@mail.gmail.com>
 <20190211121554.GB165128@arrakis.emea.arm.com>
In-Reply-To: <20190211121554.GB165128@arrakis.emea.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Mon, 11 Feb 2019 19:52:01 +0100
Message-ID: <CAAeHK+x5J_eYm+3qupptBK5gWLqkz8OM=UCgRdrKb=u0s4yxxg@mail.gmail.com>
Subject: Re: CONFIG_KASAN_SW_TAGS=y not play well with kmemleak
To: Catalin Marinas <catalin.marinas@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_105216_465062_22B10125 
X-CRM114-Status: UNSURE (   9.84  )
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
Cc: Qian Cai <cai@lca.pw>, kasan-dev <kasan-dev@googlegroups.com>,
 Linux-MM <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 1:16 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Feb 08, 2019 at 06:15:02PM +0100, Andrey Konovalov wrote:
> > On Fri, Feb 8, 2019 at 5:16 AM Qian Cai <cai@lca.pw> wrote:
> > > Kmemleak is totally busted with CONFIG_KASAN_SW_TAGS=y because most of tracking
> > > object pointers passed to create_object() have the upper bits set by KASAN.
> >
> > Yeah, the issue is that kmemleak performs a bunch of pointer
> > comparisons that break when pointers are tagged.
>
> Does it mean that the kmemleak API receives pointer aliases (i.e. same
> object tagged with different values or tagged/untagged)?

Please disregard that comment. This is a bug in KASAN, will send a fix soon.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
