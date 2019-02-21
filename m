Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBCAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:06:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060CB2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mblATrPL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="NKPNMRo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060CB2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5/xy5gtlu0ElBO46hy+PQtjoPvN4dJvcqDKzOTKCjKY=; b=mblATrPL7Q2YAX
	KlYs6XUcuN7KbI8DFkF0Q9B4CS3hFw9i1relYNU+V3mqsPC6GL+lUxiEo98nU/zBM+2U3Tr2j4zPa
	SYo7nyb/DXqqJ//suOnuwMTeJRFtf1msz52Q0RjCz1vlRT85LPXhZTF72rPQFLt5mp50OKCuIUalm
	5XeQhFWKOAEmn1GIValXXg+2HiSVhRfGBgxo1BZpnyXWuV1VyrUX8G0gp1tNrJbS+cpAqCDmhRmZH
	5pJ6QZxnf70b/PN1h46eyy+Qdegw+JWWTenvsgH4i17AydMjuPj6gv6eV53CFBm3MrtfhG7ujZ96t
	luyeh3qZ/fcp7DdtQqHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwvY3-00045W-1c; Thu, 21 Feb 2019 21:06:27 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwvXz-000451-N6
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 21:06:25 +0000
Received: by mail-lf1-x143.google.com with SMTP id e27so7484lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 13:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VaJWYAuyQeiGU3BWEwsARtgeEZnMSVA9riqh9x2CWpM=;
 b=NKPNMRo3ErcDG4ky/fPBEzQnksX3jp49gQoP5BNMEml3Xa4+q8OBDs7eAYPRL6qIaa
 YnxzxJBtMWzo0qktAuwG5l6TasJiZlpxVYcujUQeC9ZyBOy31eoJP2BEWav5d6MVOWFT
 ih1drWY0aq4VUyqJizrEh6aOe04fRSqfb/3/vv8pOVYQ7XigqKstevSLa4l2aF42wYPT
 KkNfHtJMkZH4omVe/xjOwvs0Oo/DxPn8TwLXZrI3EbTeppnTN0jFJG0j/9bVHyOeAA6v
 LYgZf4FpipElkeU0YNCJqUuOwJL3/b6ZeZT+gWOK+CkI4MM2RS0pxYuSWRnBJkwbSBGq
 etsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VaJWYAuyQeiGU3BWEwsARtgeEZnMSVA9riqh9x2CWpM=;
 b=Opt5pdtf1rh96NGR1w+hPSXWIKiTzwdnhaCJcWgpxeauXUXHejhiEqncf0AQrZFw2B
 fYUcai+nitxIwCWeXjxJzcriNTZSN5Gmz/EO9zohXjHcU5Hoump/SbDRTKGFhnQsLwHD
 5z+PJFemCEcG/4oNsidtkd4taO0tiuM9vP4lQ7uGXTGjn4VQLqJSAWvuV3SJdmpfH7mA
 d77YRjEnkuha7k59nFuXQ7EnT1X5irdeL2tUv8uASomxguPYcN99OQ3BMITr2/BUgrbn
 pDYcWLSPtVPSVBOdlTcSIaonrBwnpQLReEd5eO8ERnsDKybbvzaSd2yVvEIKRbaHSNiq
 psPw==
X-Gm-Message-State: AHQUAubrS7qSYmz0WkBIoZ0hUFzsmHDXzS/RFKEzQL948lfXR+ww7pWX
 yUT18TbNmoE2VO5slVsf1kObzA==
X-Google-Smtp-Source: AHgI3IZPyEOrLA7QJzleHCFDOD1gvwBgGn5TGNiVcau/7k1voltB6KSCgJi+MGXiUxUSeuln6x/iYw==
X-Received: by 2002:a19:6001:: with SMTP id u1mr317237lfb.56.1550783181385;
 Thu, 21 Feb 2019 13:06:21 -0800 (PST)
Received: from kshutemo-mobl1.localdomain
 (mm-23-232-121-178.mgts.dynamic.pppoe.byfly.by. [178.121.232.23])
 by smtp.gmail.com with ESMTPSA id z85sm6143768lff.80.2019.02.21.13.06.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 13:06:20 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id E14B7301708; Fri, 22 Feb 2019 00:06:18 +0300 (+03)
Date: Fri, 22 Feb 2019 00:06:18 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 03/13] mm: Add generic p?d_large() macros
Message-ID: <20190221210618.voyfs5cnafpvgedh@kshutemo-mobl1>
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-4-steven.price@arm.com>
 <20190221142812.oa53lfnnfmsuh6ys@kshutemo-mobl1>
 <a3076d01-41b3-d59b-e98c-a0fd9ba5d3f5@arm.com>
 <20190221145706.zqwfdoyiirn3lc7y@kshutemo-mobl1>
 <e0c7fc0c-7924-1106-a7a3-fc12136b7b82@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e0c7fc0c-7924-1106-a7a3-fc12136b7b82@arm.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_130623_803702_3FE90D9E 
X-CRM114-Status: GOOD (  15.38  )
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

On Thu, Feb 21, 2019 at 05:16:46PM +0000, Steven Price wrote:
> >> Note that in terms of the new page walking code, these new defines are
> >> only used when walking a page table without a VMA (which isn't currently
> >> done), so architectures which don't use p?d_large currently will work
> >> fine with the generic versions. They only need to provide meaningful
> >> definitions when switching to use the walk-without-a-VMA functionality.
> > 
> > How other architectures would know that they need to provide the helpers
> > to get walk-without-a-VMA functionality? This looks very fragile to me.
> 
> Yes, you've got a good point there. This would apply to the p?d_large
> macros as well - any arch which (inadvertently) uses the generic version
> is likely to be fragile/broken.
> 
> I think probably the best option here is to scrap the generic versions
> altogether and simply introduce a ARCH_HAS_PXD_LARGE config option which
> would enable the new functionality to those arches that opt-in. Do you
> think this would be less fragile?

These helpers are useful beyond pagewalker.

Can we actually do some grinding and make *all* archs to provide correct
helpers? Yes, it's tedious, but not that bad.

I think we could provide generic helpers for folded levels in
<asm-generic/pgtable-nop?d.h> and rest has to be provided by the arch.
Architectures that support only 2 level paging would need to provide
pgd_large(), with 3 -- pmd_large() and so on.

-- 
 Kirill A. Shutemov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
