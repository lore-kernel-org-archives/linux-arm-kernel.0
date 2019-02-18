Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E97AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:57:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2363217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="udpKFK2f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="r+fShDgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2363217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Aa09yYmXl4T/dnzYiVaikIIXwPIVD9f4nGwL+TnErwU=; b=udpKFK2fZklgUm
	4lBzpe9D1sgnf3m205LldcEgW45i6t6MIbht0PRB2LZIKbppHZYJySvORm5lw1auo1bEviWIj26Pk
	Q9MOiuM+mSTmkPZlExbRaTVa30dg3HiaMbHQ4p9lbPOb4dOWnhvJiD2vZ8UEHCmo/rzCc6kKC6a1R
	WBre9Vhu9K7MCSmPlg8MTF3n6BWYc58k8dfEzbJQZCdPKVnxNmBGpg1kTla9SuUWGV8YzbImZIJMi
	hA5OxgqF4TVf6amY+3+AEsAiBLjCwuMDdQKHePqZ10h2DtRT0bpBbmnbqxnX6e6SClKasbE4IOAtR
	qzonGTt4GrZkaYrB7NKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvlHv-0000jr-4B; Mon, 18 Feb 2019 15:56:59 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvlHs-0000ii-Rb
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 15:56:58 +0000
Received: by mail-pg1-x544.google.com with SMTP id b2so2927272pgl.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 07:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=15CNhbhWvXOtTCo6jebNIpwW9Qe1MGlcrULyF7u9LqQ=;
 b=r+fShDgqwp3BRKoIYd1vFXRjXb/bsjS+BtPyxt+qG9KLv3jmc25gVLCV9z2TF2KX1a
 nSh63p3TFizYDVhfxplA2EMwo19/ZhGILwoBruhStGNB4bxSxYcFcMYMFOxLxNfXPSzO
 qBRD05FV4TBN1sJcgTPgNV3M14SGWrKuKHWltT3T3GcXBfuQhVjzTaBfMAC9NWW0V/At
 68RZRJZcZ0UjQR7zFzXBFZHH/O+K3Sg0k0bswJ4tXXjjIcWFG5Dk+1w04JG1YA0fKrel
 dBmcB/0QF+tKqiG62e8X7wTGSlXzX54jWxoCk7OGLIzteyRNHsDW6VYY7lRheEGctLKJ
 aJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=15CNhbhWvXOtTCo6jebNIpwW9Qe1MGlcrULyF7u9LqQ=;
 b=ro2vNgVyCeeuSNrniUPhEgtDPNXHPbdiTpHmtEc8SvNiekJ99C2FoqsRbICeeNfdzy
 mZGziAYZcivtz6UnxSo/ScAn+EeOp+RZd3yQ4TYTuRdnDb8thiluxdGxJKPE6+Vq1RDh
 KSugjhXK6GzvcqDVy6aooHgC5mhpva2RdsPciamna7DPeL37Fw+Mo20B44jRuZ2AscBJ
 86RULnsTVQsm026EnOPtoXg6jcbQWULnoCo+35r006KFklYcZ5vw9GHi0iq1CWaB+LLZ
 pRksSshltuluiCgQpGZWmaYdL5Uc76CTIuDmmDzumip3CbL0TwK3Jz0DyoZJBn1N8hR1
 mgVg==
X-Gm-Message-State: AHQUAuZZ3TUyrLYf24hYQxYkKmdGWq704+5mCypSEpNfI6/8jHv9b8mF
 T3CXstilrE8YE9Wd3TvG/PE7OhmqCB4lynIfAu0kqg==
X-Google-Smtp-Source: AHgI3IZMGzkFgLdqE+AD7Y3hfwzxkylhvyZESOlZyS8079LBJNa4hh/152UrmuZJtH7Oj/um+B//tVelXBjizv0bfMs=
X-Received: by 2002:a62:1c86:: with SMTP id c128mr25717905pfc.54.1550505415843; 
 Mon, 18 Feb 2019 07:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20190217043434.46233-1-cai@lca.pw>
 <CAAeHK+y8Xd1J2DppUMQLVhoc69wrqgNA=9hV45Jsd7V97CN6yw@mail.gmail.com>
 <dddc0e6e-af71-c98c-c8db-20c6d9fa87c3@lca.pw>
In-Reply-To: <dddc0e6e-af71-c98c-c8db-20c6d9fa87c3@lca.pw>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Mon, 18 Feb 2019 16:56:44 +0100
Message-ID: <CAAeHK+yDa=Ks7TY8unVfFYt7ekDOyqpqW4otyMg1XUxkFt5Q+A@mail.gmail.com>
Subject: Re: [PATCH] trace: skip hwasan
To: Qian Cai <cai@lca.pw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_075656_924181_9B121386 
X-CRM114-Status: GOOD (  11.61  )
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
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 kasan-dev <kasan-dev@googlegroups.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 4:53 PM Qian Cai <cai@lca.pw> wrote:
>
>
>
> On 2/18/19 10:25 AM, Andrey Konovalov wrote:
> > On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:
> >>
> >> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
> >> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
> >> because there is a burst of too much pointer access, and then KASAN will
> >> dereference each byte of the shadow address for the tag checking which
> >> will kill all the CPUs.
> >
> > Hi Qian,
> >
> > Could you check if adding "CFLAGS_REMOVE_tags.o = -pg" into
> > mm/kasan/Makefile helps with that?
>
> Yes, you nailed it!

Great! I'll send the patch.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
