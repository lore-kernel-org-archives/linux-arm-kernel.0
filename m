Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A659C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:32:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57551217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DUE44doJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gc35xBK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57551217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=op4atEufDgTXoDyYba7gTvEyGLH72xUx5U4UGmOF69M=; b=DUE44doJZ9VwAQ
	n0DUjPL1URIwHpnh0XEapuakNpkGjTloaz9DtJ7ckQc0VJElWAQKpe1bMWGkljjLhqkYhkIPMctfN
	MScqfC9rJXP6iXQ4zCDIKDSc2q8gWOgP2oXTqp5pkPF/F3SQMVlKs3ItxCF8tpxvpyBC110Q/Pcvj
	uvobhbdRgZbfwAE9E0wgkGoL10rS6/Nv0nUVS56mvQf4iNorPLNOJYZ7j+4+X7x48fNL2UjcZOOLC
	j+Lg5d9VXS+Sll7Rj/9mqFf4KIRWKqSGXvaDxzSRWsfbiYWlATyTixJVmLqOc09J9tsUfpqc/y22i
	ZZiDFSgJBs4ncIdoRHNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvy0p-0005pH-WC; Tue, 19 Feb 2019 05:32:12 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvy0n-0005oS-I4
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 05:32:10 +0000
Received: by mail-it1-x141.google.com with SMTP id v72so3503486itc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 21:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=N3a1F+phTWNP4vUdqbdRG2LlbC8gmOfizcSGQCqcX2o=;
 b=gc35xBK2JBhKjw035oTY1u93BDW82QcWBUDh0TI0DviPy3CeCAzv7UjcT9TBy+JNXD
 lXsqfikYlopTFD18nTHjmmRrxttVYtwzVpdrcmcShD2mF0FD+Y2mPGor4BJ+JyWMkPEF
 4WDiECLbmuY+tNd3wpir2eUCE5HFOoUVxhvpG6f8UjS7IMrSRDbkoXfZbnvCnf1E+xpy
 Gb2iaVw9vsJrlo8mFuMRiG9pQMgi2y9rMP6W/VBNr1Pq8BIMegopo5fRM5cCHHRzONVc
 O/Xlf5nReRAxB9UeaX5jp8SO8MCBrq7et2MGGu2s6g7pXO7MPqGB0DajNG+e+Z61lxQj
 25UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=N3a1F+phTWNP4vUdqbdRG2LlbC8gmOfizcSGQCqcX2o=;
 b=GS0uhC+lJaKvbgiwidCCTLhpYMlBeD2JN7Uz4P5rjbAcFFiGFBRuYIwdgrZUVI+Ive
 BlQuRkdWaI9f+XV93HEm9UeEKe2aN38z2gn2PYaRaDA2v4LJHwmY3bG7OGFeyihzuAcN
 18BdmsfwajhhMekbcu1375Nji5Qld+YahC7YkobH3jvMqi2spZu8ddByS8isreXuOcif
 7wEkO94Me2FQ8D1ppjsHJgOFU8pK0YZfhVz3mH4WsCgNOY4Jn/QJVuaysKK1QFgzA6Ll
 w5BknPDzi4bcl0ACQ7g6oLKCSSyp7YahqGq1MOoq1y6t0LaY23QqGwWiCHCHK0dp7bMn
 BoEw==
X-Gm-Message-State: AHQUAuZ0F0ub5qL52qdS/rka7Or1rlcQDT8T0i6XkOD4tMnxMRzeKwqI
 1LxXUqRhFxpZCA/ne33l/UMWIg==
X-Google-Smtp-Source: AHgI3IZ5ltUtXza7ruJZojlSoyiNc3n4l7gI2q26hEETIjvCNdzWMCapc6G79N9F+MyPSvpcyvD6wQ==
X-Received: by 2002:a6b:4a09:: with SMTP id w9mr17157160iob.260.1550554327823; 
 Mon, 18 Feb 2019 21:32:07 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
 by smtp.gmail.com with ESMTPSA id k26sm6197007iol.14.2019.02.18.21.32.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 21:32:07 -0800 (PST)
Date: Mon, 18 Feb 2019 22:32:05 -0700
From: Yu Zhao <yuzhao@google.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190219053205.GA124985@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_213209_625374_53A2B689 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>,
 Jun Yao <yaojun8558363@gmail.com>, linux-mm@kvack.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Chintan Pandya <cpandya@codeaurora.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 09:51:01AM +0530, Anshuman Khandual wrote:
> 
> 
> On 02/19/2019 04:43 AM, Yu Zhao wrote:
> > For pte page, use pgtable_page_ctor(); for pmd page, use
> > pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> > p4d and pgd), don't use any.
> pgtable_page_ctor()/dtor() is not optional for any level page table page
> as it determines the struct page state and zone statistics.

This is not true. pgtable_page_ctor() is only meant for user pte
page. The name isn't perfect (we named it this way before we had
split pmd page table lock, and never bothered to change it).

The commit cccd843f54be ("mm: mark pages in use for page tables")
clearly states so:
  Note that only pages currently accounted as NR_PAGETABLES are
  tracked as PageTable; this does not include pgd/p4d/pud/pmd pages.

I'm sure if we go back further, we can find similar stories: we
don't set PageTable on page tables other than pte; and we don't
account page tables other than pte. I don't have any objection if
you want change these two. But please make sure they are consistent
across all archs.

> We should not skip it for any page table page.

In fact, calling it on pmd/pud/p4d is peculiar, and may even be
considered wrong. AFAIK, no other arch does so.

> As stated before pgtable_pmd_page_ctor() is not a replacement for
> pgtable_page_ctor().

pgtable_pmd_page_ctor() must be used on user pmd. For kernel pmd,
it's okay to use pgtable_page_ctor() instead only because kernel
doesn't have thp.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
