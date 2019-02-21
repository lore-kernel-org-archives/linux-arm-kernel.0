Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A651C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:28:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE5B2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dn98e714";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="1W/lKVgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE5B2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A2hY3uR3hGrcmCJtvbVnOTPmCaeoeO8c9YPQMMoVBBw=; b=Dn98e714WhF4dw
	OdsYXXyLzEQ15tzjGqJP/5xhdbeub0zV2ZqR3jh2qpbL750RfabtMxK8ZX+KAgo8lAR4ELLUWlpdW
	h+zWkOqOnGF/dinT7kZ9w+oSQFSypAr3WcjA8OHuM0mWH/xGX3eNm7bH4EHaLrcR58QiJuXUIe6NU
	McM9gFw1ZxgS1IjdZHBGBICTj7PfE1P4QUhJVkK6MxAaD/0jKLPkh+dsURveQ/FzUXIl23OTTgpJC
	9qwIEN/AZJHaJmlOLp94x3TwVJmneRT92Xn6ugshqdWd1Psa+AuNGCVqmSHnMp0aMOXH3G2/sOKn4
	Vznc5rdsbJYkY5B4SWdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwpKo-0006hf-3S; Thu, 21 Feb 2019 14:28:22 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwpKk-0006h0-Mj
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 14:28:20 +0000
Received: by mail-pg1-x543.google.com with SMTP id r124so13780615pgr.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pA9wgCQyEUyTHkAq+rVlPzlBQCV50nMzrf+ehGsqY3Q=;
 b=1W/lKVgGsUokYt6qJwL+oFd6wI/8KbnaSxB0ry6zobjbzzt8lwy3rDM0GPrPbtSzWc
 XG5+mzm8TvRZAvS9RAH1TXfpQzPMGUQl6oFNDC4cI7CFGbnXzzQkKLtKcRg+9PQgPMg0
 pXOIaFUcQmh98dypu8uNF3Y2c/xfQLSZaDJV0dnCRB+kT6gfZqY/nbPnUJ9KfNdArqh7
 gaOhtVDM5gTEAmClFOieev9ao8Ctx/Fy8y8/MqglYraqRqt5rGZzTWciBFhzAHeoA13O
 FAi/fYvXvQljBV62TkgyfrGmaviIfnN2K+pcsmzHfWyWorMknnuXuMfFrqSEyT2WFs7R
 kzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pA9wgCQyEUyTHkAq+rVlPzlBQCV50nMzrf+ehGsqY3Q=;
 b=h5CIxVke2YvNBqGI4AURuscIK5nA0+IzY3wzyXueg4Hjm4XcLI6GiJbkPGTRs3gq5w
 mUzfSyw08AiIu+RJgFmBzB50KWCg5nmG2KkCgiYRzWa1XLMwlx5Ehz/N/EyLoHbcMs2K
 f/zBif/2q7Y/NJuIef5h2TjtaNrbwkDfANR2nKyjeRF1oWYYN3y5CrtRAsmODz11josc
 yWf7/51c0mzkg4wAPmgJ8U3dG0bkwDhHXaNf12IomFhSEFgD8NRhkh7801wPJdTEre1n
 ZBa0Op4L2sNPV+6HqCtUzwUJTk0jdud0juTsDM1jxrPB/3FXTKLbsdp9lGrpN7caOVjk
 kIeQ==
X-Gm-Message-State: AHQUAuaZhyJfwXFygr7CZzcHD5LIznpLcJeFKQMnaGV00bMfYXiuJgCD
 +fQ0HFhjFeUzyurWWR2l51OmkA==
X-Google-Smtp-Source: AHgI3IbfbbYkruivN5aBVqRxR1ViZUHLVAQoi1hsZAsMbsY8Xl1Xpgutyz7rtk/D8d3+HA9SOuSXiw==
X-Received: by 2002:a62:3a01:: with SMTP id h1mr39568542pfa.169.1550759297907; 
 Thu, 21 Feb 2019 06:28:17 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
 by smtp.gmail.com with ESMTPSA id y5sm41244867pge.49.2019.02.21.06.28.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 06:28:16 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 0B424301708; Thu, 21 Feb 2019 17:28:13 +0300 (+03)
Date: Thu, 21 Feb 2019 17:28:12 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 03/13] mm: Add generic p?d_large() macros
Message-ID: <20190221142812.oa53lfnnfmsuh6ys@kshutemo-mobl1>
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-4-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190221113502.54153-4-steven.price@arm.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_062818_737301_4DBF743F 
X-CRM114-Status: GOOD (  12.02  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 11:34:52AM +0000, Steven Price wrote:
> From: James Morse <james.morse@arm.com>
> 
> Exposing the pud/pgd levels of the page tables to walk_page_range() means
> we may come across the exotic large mappings that come with large areas
> of contiguous memory (such as the kernel's linear map).
> 
> For architectures that don't provide p?d_large() macros, provided a
> does nothing default.

Nak, sorry.

Power will get broken by the patch. It has pmd_large() inline function,
that will be overwritten by the define from this patch.

I believe it requires more ground work on arch side in general.
All architectures that has huge page support has to provide these helpers
(and matching defines) before you can use it in a generic code.

-- 
 Kirill A. Shutemov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
