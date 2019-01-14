Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10016C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:03:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D597520659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mBPYUjlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D597520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fTDyKhPTZoq8LnOFtW1OVWgrNaXB2JwtOi45wsTsp90=; b=mBPYUjlS8zcjpv
	6+a9wPTwnfkC9PyuWJeoz9q5cJnGlSCUU4fo05jJ88g2hCUbXNK6o1chpFC9womWWNA1VBP5mbpNy
	huxsU8Z2J32La3qdS73fpajj5dg3P4m3oulwER2slRRgmKZRYAguanH2ApCG8HZvSU/KXS+kkkCh2
	YspZ8CBdCXTTNoEyHGclTGcfjzOr1L//DATVLiF80KQQaLkC8OZt+p+oYQ47waSqXt1t/H8O+E6qk
	kjmnPQhJ/zaN7ayWCWUL6vYEzMFiuQlAMUPZSzfp5i+G0wR/zQacr28F/pd74VhiVwgtbtgjhh8W7
	9wR+cbV3/hN+RDDGV8LQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2pZ-0005g1-N5; Mon, 14 Jan 2019 14:03:09 +0000
Received: from mail-vs1-f66.google.com ([209.85.217.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2pW-0005ev-59; Mon, 14 Jan 2019 14:03:07 +0000
Received: by mail-vs1-f66.google.com with SMTP id n13so13680472vsk.4;
 Mon, 14 Jan 2019 06:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EPXQ005dpgnhxanjjmigJASoqbeog16GFnmkdoG8qpw=;
 b=tZ40KC6jANFUO+E35EihBVwUP3GCz+oAssHE8wkcqLkKi4FYQuaJq04giguyGvzYCr
 hH0bLHbeTzsA0oTyckKhLg3/zq3x8swnScMuejNGiIW2Fci8YYVGiwv7nIH7FSU1HFTe
 ypveuOMaYsh+MfC2U6vleYHYnaKw2IedmQOPjquCOzlRkkLI+rx8eN/Id5BeT+1EWXtz
 AngV2QA10GaiIltHSFolRApBEe+7aIT6SOZ2OxmFaIJs4b1lU7BfYPG2mYT/KbWTimY/
 7ro+fbNVCiAbds78iVh4GIsLT6F0fGTiklEgqioTvcanvrXct4JoJZeiQLfmwl5Ghmkf
 hKtA==
X-Gm-Message-State: AJcUukeY2Vi5PjFTrTglL2ZLt9KomXdFVblZRnE3qJZL3sSC+JmnOGv+
 232rPi7wRUv0H9ELGUGfGjQO6meVrdRwBTqErCmjcbN5I8k=
X-Google-Smtp-Source: ALg8bN5wYMxOtX3lY+uzxTqd21QEfqP1458GnLRYAHGRLaMnhFDHkh8ZI6dVlRF3u0c0V7r+jYFPOiKxVX+duKm+d8A=
X-Received: by 2002:a67:f43:: with SMTP id 64mr10255483vsp.166.1547474582599; 
 Mon, 14 Jan 2019 06:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20190114125903.24845-1-david@redhat.com>
 <20190114125903.24845-6-david@redhat.com>
In-Reply-To: <20190114125903.24845-6-david@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Jan 2019 15:02:50 +0100
Message-ID: <CAMuHMdWEChb4+tf0m_qN9Mc6Am5T0rZLqAn6QsQ8NdMOCRPySQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] m68k/mm: use __ClearPageReserved()
To: David Hildenbrand <david@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_060306_251106_448A1C98 
X-CRM114-Status: UNSURE (   8.47  )
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
Cc: linux-s390 <linux-s390@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>,
 Linux MM <linux-mm@kvack.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 1:59 PM David Hildenbrand <david@redhat.com> wrote:
> The PG_reserved flag is cleared from memory that is part of the kernel
> image (and therefore marked as PG_reserved). Avoid using PG_reserved
> directly.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

BTW, it's a pity ctags doesn't know where __ClearPageReserved()
is defined.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
