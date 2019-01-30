Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A10C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:35:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49632184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QEKrB9Wc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HYB+Xu+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49632184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wuTFhQH5+TXbAwXJskAH2ay91sxSXgX0fxz4qYdnUOs=; b=QEKrB9WcOHUskH
	HpyI+19mSDouUnyH7EfxmmNhEHVsbf5kaY0zyupfgkvTjHWKEDrm2LMg7X1rUBLyqtf/5aGkpNqrJ
	Dqqlg56E3/BbmC39X7upWhMObmqqz4xb/xl9J6MrHzbTe33lAeHEJ38HYbXtAcuFqdBmzf8ZvmHUi
	QWJEELRM5JJKvkvEO2y/1Eoz0oZePLja0PeVnOpkwUkMSBVPS83OACBeuf+qsdJWGMBQBXGFbqGXs
	eXli47fwLIdj6nSh7V0aDxS5a5Zypmkl/VIOOZcM1dAHP8NlfZKz5Pw2QcMk3Bewu2JE83VFrFqkU
	QCP7BkaV3JWqC6EHwLOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govdr-0002DC-4C; Wed, 30 Jan 2019 19:35:23 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govdn-0002Co-Eu
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:35:20 +0000
Received: by mail-oi1-x242.google.com with SMTP id t204so639043oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yshu7Nu72+Dtk8rXL7JZUEueFPkhXdQ3uQBa9T7+FI8=;
 b=HYB+Xu+lqUkubBO9J+MbB83KhACX2c6ZCtNkmClbu5N4zCrW3Mu7YVFuwbEeXs1hcy
 BVAJNOjpO1VF6DXo4DlaRzWieNFvTz7eWJJgXe6dzEgcPnWrVQzMeLzqSn277CHoSS6D
 upGbxRbGy4ngHeuqNHJ6MdF+hWfabsm3ChRunH+F2aZVfnlAD23XMHxWfNGcUQQvRciP
 0PjrelBuZgpe/j4jIdecT7oL6cgtu088WSjJRWbkglD7wRM7TUipK9ZCwF6AVXOw/yCT
 sO/pp7u3Qkz43e0yV4hlOCmre9lifyq5FrP8NYiwpJWk/uGDtUXMpF8hUd2y0bklWom2
 psJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yshu7Nu72+Dtk8rXL7JZUEueFPkhXdQ3uQBa9T7+FI8=;
 b=nbuq8jbuJlzAlNRsHCDQIisX4JvGpm+ycnYONVSJZMzhtlsIYbFstKBN1n6Z2sz5S0
 wTFCPu1g/09T1BW85vGeD1LCXhuZap9l0yqvy9sgovQ/qVN7aH8CGN4s3mjYYYz4YTrE
 wG5Cml6BhnNGqN1eo38AFRF1z6Pd0lp/5Rd2bxShOBoeu62JYVxuI5ZJEMuQdiBD15oN
 zzNAj8xz+tdIyweVsLN+Yq7TFyR0SmatQJl+JlfZFMeFpGj5micBg2+1+C54Re6WUtd0
 XCIhkwy1XFwjdRzeATvEs6BoUjCzDy7q+egiejhT8YoroNEeaT42qkOd/01znsGxD25a
 G9qw==
X-Gm-Message-State: AJcUukerW25Th0lYOrmZkRIJgdZLbAdPWPoH+Bj4celMkB4qQ2J4tffr
 dlL6BLvakjlKgsSvQEZWuLbhXCfxJxD/zqCmS1s4Hw==
X-Google-Smtp-Source: ALg8bN6hGKJnwAHsVa0igPx6WrWGeK6tM0dXYVfZJXpbjOb3IwGwK4BPXPa9qEXCDMEobRiXHFXi75Ss6vjpxle5Wd0=
X-Received: by 2002:aca:c413:: with SMTP id u19mr12681145oif.209.1548876918558; 
 Wed, 30 Jan 2019 11:35:18 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez0QRmU9fGV3x7nceGqBGADNTb66MnG4PW_xu+xnGUqg=g@mail.gmail.com>
 <20190130182157.GP18558@fuggles.cambridge.arm.com>
In-Reply-To: <20190130182157.GP18558@fuggles.cambridge.arm.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 30 Jan 2019 20:34:52 +0100
Message-ID: <CAG48ez2FMfyagDedETV54sFEit_mJy00iqBFsNngyeT=g=a4PA@mail.gmail.com>
Subject: Re: ARM64 suggestion: reduce the compat address limit (currently
 0x100000000)?
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_113519_529787_9B3B9F8B 
X-CRM114-Status: GOOD (  17.17  )
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
 kernel list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 7:22 PM Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Jan 30, 2019 at 05:32:00PM +0100, Jann Horn wrote:
> > At the moment, compat tasks running on ARM64 can allocate memory up to
> > 0x100000000 (TASK_SIZE_32). Testing on an Android device (with an
> > admittedly somewhat old kernel):
>
> [...]
>
> > ffff1000-100000000 rw-p 00000000 00:00 0
> >
> > This means that mmap() allocations do not adhere to section 6.5.8 of
> > C99 ("If the
> > expression P points to an element of an array object and the
> > expression Q points to the
> > last element of the same array object, the pointer expression Q+1
> > compares greater than
> > P.") if you treat mmap() allocations as returning an array.
>
> Oh, good point.
>
> > In practice, I've also seen code that does things like computing a
> > pointer that is out of bounds by a few bytes and then comparing it
> > against the end of the array; while this is UB according to C99, it
> > probably makes sense to try to avoid breaking such code.
>
> Agreed, and since the current behaviour isn't something you can portably
> rely on anyway, I think we're ok to change it.
>
> > X86-64's compat code uses the limit 0xFFFFe000 (IA32_PAGE_OFFSET),
> > which I think makes more sense. Would it make sense to do something
> > like the following (untested)?
>
> Can't we just go with 0x100000000 - PAGE_SIZE instead?

Ah, yeah, sounds good. I think x86 probably only chose 0xFFFFe000 to
keep user allocations out of the way for the 32-bit vsyscall page.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
