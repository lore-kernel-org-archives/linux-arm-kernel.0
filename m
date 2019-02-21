Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E740C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:57:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF222070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XNallwKQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="wwPRWoH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF222070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eHNHIro7gnA8+Z8Wsw+JwmHFwCln2AOuykRJNGf5iMs=; b=XNallwKQwpx1uI
	OYtzjTUPY2ZPa05LVJCtB00o7lXBGUotI11PxNbTHfjxt+KtqEz5uGlUrr1NP+6nD42YeVkp/b8qv
	hLRMZXRuu72dCN/d31K33eRhYIzd86ygIkjK/4jmKiQt+BAPxvqDe7yK0eLdvWPPbVpDU+k+C7PWp
	AFvn1FbAzL3HnDGg2gQaQYuHfC/hUcb/8uUxpk1KVD6SY9+/L2fDxmRPL+5D4whELoIp+JHu947Q9
	tB15CsVg+aSpexvRzy/9val/r5AZlQeHzUV8g/K1xUsjRxzcIoKGH5BSBq+GC8ppRAE2fomPzr7Ok
	jQf/JW1uwkEreEXcd2sA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwpmk-0001wP-F5; Thu, 21 Feb 2019 14:57:14 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwpmh-0001vR-9H
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 14:57:12 +0000
Received: by mail-pl1-x643.google.com with SMTP id d15so7151790plr.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 06:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=T6VBBJYyKGf9Yt7Yt1V87f/1+l66aJ7Oi3kjsALTg5U=;
 b=wwPRWoH7RscIRgKfRveK1NuIj23T/Lu9QLuQEw/AlQodiLk7Li6narB2OnDzzopxGh
 AIwxvNdAU3Dy8rZo6y55/MSqf91CVcBpEdUpQ/EdMhSETrfyce4iRd0DhiYWDR4Ogj9L
 52pXutYxgrmONKkaNVbCUN9nDGVt53Wnh10ONcI5kGw9RT1JNgIT7lUyRT3cPEXxyGpr
 fwxE93FUHAT4JpVECaIH8mY9FsDpLfbDacUHtRoRKGKVl89tqSIzfLKkbjIA1YKOtjPp
 S/am9lEOA3qmmUiZ8S3kpbmzDSGa7d2Atbak6PZMraWUy7dEFSny0KMOEmW9z5I66Kkk
 LYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=T6VBBJYyKGf9Yt7Yt1V87f/1+l66aJ7Oi3kjsALTg5U=;
 b=VtB/cc8ikoBL1UPEFJj1i1/ZYImkxa6V4vJcqbTsgVfE2pSkyxea6YNUSMal7ApkGn
 HqcTUnR9amhonivbqAF6wCdPXqIPOLI5+ytuWtrRuBJBWQz052zIH8gm1EbsMFcTHYHY
 ENV5LEccceWtCAIuVPXnma0xvc+vySPg6kvhP3quWgTVIMAs6qy56Fv3znaMXEMGW0yC
 hdsHFcyWmydm+IevpujL0/EOcYFzHNpVw5v+BzkLw38+HdLMCMmUi0+I7hQrnyvPzIQJ
 z16c8Ya6fB6PO+giXmN2sa6RBvYSX725017Z67FSSkn5W7dU9VxqsJIFvlz5NIYlfF6J
 FeOQ==
X-Gm-Message-State: AHQUAubBgtfXssIXXbNIZ/eJrelTL6njU2HGIDzApeYLj64aSE1oQDY9
 b+EAwmtpXOU7boZc7Bm5xTvW/A==
X-Google-Smtp-Source: AHgI3Ib9Y14HOUHgb7hPC19Ds22hTsvdmOthEb6KPxlYMOxeEBURgY4/74WCmxUy5cW9dU9bAhaEZg==
X-Received: by 2002:a17:902:e90b:: with SMTP id
 cs11mr20788392plb.197.1550761030340; 
 Thu, 21 Feb 2019 06:57:10 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.43])
 by smtp.gmail.com with ESMTPSA id f10sm27599894pfn.11.2019.02.21.06.57.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 06:57:09 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 4C4EE301708; Thu, 21 Feb 2019 17:57:06 +0300 (+03)
Date: Thu, 21 Feb 2019 17:57:06 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 03/13] mm: Add generic p?d_large() macros
Message-ID: <20190221145706.zqwfdoyiirn3lc7y@kshutemo-mobl1>
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-4-steven.price@arm.com>
 <20190221142812.oa53lfnnfmsuh6ys@kshutemo-mobl1>
 <a3076d01-41b3-d59b-e98c-a0fd9ba5d3f5@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a3076d01-41b3-d59b-e98c-a0fd9ba5d3f5@arm.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_065711_330194_BD3D29AA 
X-CRM114-Status: GOOD (  20.01  )
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
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 02:46:18PM +0000, Steven Price wrote:
> On 21/02/2019 14:28, Kirill A. Shutemov wrote:
> > On Thu, Feb 21, 2019 at 11:34:52AM +0000, Steven Price wrote:
> >> From: James Morse <james.morse@arm.com>
> >>
> >> Exposing the pud/pgd levels of the page tables to walk_page_range() means
> >> we may come across the exotic large mappings that come with large areas
> >> of contiguous memory (such as the kernel's linear map).
> >>
> >> For architectures that don't provide p?d_large() macros, provided a
> >> does nothing default.
> > 
> > Nak, sorry.
> > 
> > Power will get broken by the patch. It has pmd_large() inline function,
> > that will be overwritten by the define from this patch.
> > 
> > I believe it requires more ground work on arch side in general.
> > All architectures that has huge page support has to provide these helpers
> > (and matching defines) before you can use it in a generic code.
> 
> Sorry about that, I had compile tested on power, but obviously not the
> right config to actually see the breakage.

I don't think you'll catch it at compile-time. It would silently override
the helper with always-false.

> I'll do some grepping - hopefully this is just a case of exposing the
> functions/defines that already exist for those architectures.

I see the same type of breakage on s390 and sparc.

> Note that in terms of the new page walking code, these new defines are
> only used when walking a page table without a VMA (which isn't currently
> done), so architectures which don't use p?d_large currently will work
> fine with the generic versions. They only need to provide meaningful
> definitions when switching to use the walk-without-a-VMA functionality.

How other architectures would know that they need to provide the helpers
to get walk-without-a-VMA functionality? This looks very fragile to me.

-- 
 Kirill A. Shutemov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
