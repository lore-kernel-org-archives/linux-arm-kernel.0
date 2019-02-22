Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF14C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:51:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BF22070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C4114vgW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vdZGNswt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BF22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JRJ3/uo56Xbqp6pkhcY5UlJnJyhjZQUTav3MT6c8FcU=; b=C4114vgWrg20Hd
	Krh8ryvhqemUfystmIjQivvGlDpBV5t46++0vrdc9hhIACSaHHsi7ahfKkZojaGuuDahdnUs+TwUO
	MBZ6xsUSYEFKMKF4v6QEMIyw7En+eYnuG4zSDaAg7QZqtv+b/4SHrt/CokIZYRiFgwQErodNUca+3
	PEFLKFAZ2bSrfC+pccOs8Awva7SQGgPa3UPIC99/RIi1KjCuBMdga2/aFEjoJVCnFM1Nxp6vcyDzO
	XtPlWkjjwQFknsNJe63v6oTD/mBvc0ynSdyZZmWDpNf0+3BNTO6nno4XcdlyQ8Vk4Q1EFqiMI751A
	Wy/9PRiaUEVd8aZvo+iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxD6M-0002oS-S1; Fri, 22 Feb 2019 15:51:02 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxD6I-0002nx-EC
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:50:59 +0000
Received: by mail-pg1-x544.google.com with SMTP id y4so1283799pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 07:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GP10BU9F6M7h1OqrL4MqRJyEJPhQSevvarcmyutmZTU=;
 b=vdZGNswtb7AJLs0rpIS2e0Ol5X2dIcIZSFoxgZdR7B92zRX1At+V6fNmMIbgLXXkes
 w68sSJ9Wwf6dfIEL4dep1+IgYx/kvmKziEJCGudoY78EFdrWxSQOi59iqj3qRleNoRJ2
 iKd0DegWZvhq4XWJJ+sD7CpfJOGR0k2Nxa+vL1k7pI1RA6A7CDBueuYF6Zn8280Rte8g
 2lUfmwPD+ByKBC5jPGPg/ooBe7PKW3pENi3yPjy7wHJtPiKuaUBCCjtTcSyerF3Hyf52
 W1DkMFZlZ8KaimKOkVC0GB5msOZ5KomIMddlxcKNTWWyKWOnrbRlJtLAdBViocUS1sOC
 k+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GP10BU9F6M7h1OqrL4MqRJyEJPhQSevvarcmyutmZTU=;
 b=NvbpT4xlaQIBTk9nCkqLp0a97hZmDBVIrfI0ZByKnReM2lrCanFL7VYFYDg8JpykcB
 oekDA35KTu2OShYOehM4FYZpHACQsrC6kWDtReWAJc/6J1eU7b0eLWgqNBq/qpD9NBSl
 vYn4rlPKkLZKUnhaYuTJepvI7nK4qJXo99ggYGomE5I4+JQ+7RGvpm++f+BLjagZ+ygh
 Fl+1HQARTtlem1IDhMgVjK6Yi05UrLB2xfrQO4OtufSDt51NQSGO6G+g+VMdr3CobTSl
 jFN0I3TTQbIAJktwHnv7S5fMpLaPBe/lrPmR4gW08xbtHMUhLw0IqBqHzGSuvVtgj7+4
 LjlQ==
X-Gm-Message-State: AHQUAuaWmIGNuBW1glC1Ok7roN4Pdz5pYTRvJl3EQ0SHwBHCVr85NrVY
 h5O8oWdFkgL10gPVg8gxpWleKKze3GxtlKTWGCVoZg==
X-Google-Smtp-Source: AHgI3IYAVx2dXfXXUnziI0AYtr425fVqA5adqxqZTqupFmBYgMgDkPejFZaFhcH12ib2zsUSh1lM9ss5E7447NCmdag=
X-Received: by 2002:a65:6651:: with SMTP id z17mr4330628pgv.95.1550850657657; 
 Fri, 22 Feb 2019 07:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20190222144301.3516708-1-arnd@arndb.de>
In-Reply-To: <20190222144301.3516708-1-arnd@arndb.de>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 22 Feb 2019 16:50:46 +0100
Message-ID: <CAAeHK+zDVHqTMAqDGG1sAhvXCbAWun7yHwN=HJ1VBjtoA0aROw@mail.gmail.com>
Subject: Re: [PATCH] arm64: avoid clang warning about self-assignment
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_075058_503668_CDE1EBC1 
X-CRM114-Status: GOOD (  14.05  )
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
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, natechancellor@gmail.com,
 Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 3:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building a preprocessed source file for arm64 now always produces
> a warning with clang because of the page_to_virt() macro assigning
> a variable to itself.
>
> Adding a new temporary variable avoids this issue.
>
> Fixes: 2813b9c02962 ("kasan, mm, arm64: tag non slab memory allocated via pagealloc")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!

> ---
>  arch/arm64/include/asm/memory.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b01ef0180a03..290195168bb3 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -312,8 +312,9 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #define page_to_virt(page)     ({                                      \
>         unsigned long __addr =                                          \
>                 ((__page_to_voff(page)) | PAGE_OFFSET);                 \
> -       __addr = __tag_set(__addr, page_kasan_tag(page));               \
> -       ((void *)__addr);                                               \
> +       unsigned long __addr_tag =                                      \
> +                __tag_set(__addr, page_kasan_tag(page));               \
> +       ((void *)__addr_tag);                                           \
>  })
>
>  #define virt_to_page(vaddr)    ((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))
> --
> 2.20.0
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
