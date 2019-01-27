Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD820C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:07:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ACCE21909
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VkOxqPay";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQJUgaYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACCE21909
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UBLx4frWhhyMvqgqwhT5IByySOEBN7NS7Qmr2Bygbx8=; b=VkOxqPayv6nzlD
	TRw60maqmewjMGnnZbXfNV/R+EOZ/3F6B+RVn011ZqShuBhd9jK6/pB0jkqTs/KvXLx+qOL96RhFq
	S4RsPMA9AzkEsxF0k58YOn6Jm7ah09KDJLt5AadZjUOqBWQcriZ5bF4OyRb0bkA/x+g7gPR9tY5w2
	94ylCaTFNoFL8SXH4QyRY6emDFAMhvH5g0PsPaZal+ylJi4V2tlQznPyEoc7fmvVIXtslsWR4LY+f
	ij3mqfOPGVI3r8QMkGfSrci3I5tq9S6E5affmzZzWtyGX76BP7W8heOwBMknCnknw/7RFLdFc3FxC
	XMGeIWDYGnnWSuLQAk6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnamy-0003bH-Ly; Sun, 27 Jan 2019 03:07:16 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnamu-0003aj-W1; Sun, 27 Jan 2019 03:07:14 +0000
Received: by mail-pl1-x642.google.com with SMTP id p8so6249844plo.2;
 Sat, 26 Jan 2019 19:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5gqtElyGAjgWA1IcD3f1+6EYOKOhZl25WPW+/clLjQw=;
 b=DQJUgaYyc2s9cDIgDXTbhgKcePEzBol2WZvwvI6xmrwG+LJZGqMLESHYlxBSvlyyQ+
 oUI2SaaDg/nIxSIVyyBEipyPmK2fYHmtCyy+DuhILnqyKmu6E9VS52zUYIar2ouPKRdT
 spF0yBPuFHYuwM3tKB7m/bM+hdtYY8xeINYQ75T8D69QJml4TyVnU8zheDFZ5xRv/+d0
 fZacP6AYd7yMLzeYEBYuBCZR0ps5yO4SEfRDf0avcrWF/WhVzAvlgh4beOcKHCs3Rmim
 bGR8TFht5XxX3GHKhLXiZmgiwFe5kndg4WxAiv/zrboSXN3mxjy6wEx8Agq+Buk9nU7Q
 w6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5gqtElyGAjgWA1IcD3f1+6EYOKOhZl25WPW+/clLjQw=;
 b=hwF+ryZjLnjH9oCE05B1FaG2ffLjbTyNyvyLVpKGt9pflH+rUZZyDGW/eomwNBb2SF
 3RgLwGoogIzv9zRCAl1iQ3+wHDtyMSApnVuhX0Y0VYW0sepwLaF6LAk5Kv3j6Cl/fx3L
 fDFmktfapTVriqb5CqKaak0FgkGj03uc9LYgeP3r6K8PKz3b6N/7r9hynEJVTU+FSafG
 JzyWQ6/lFQoz0ZDb/lr3GPXke7mkmi8H7++huXwgkfZ5c6Dy56TmlN7xc9wd43C+KFmk
 NPTvJBEWqG70fpAQXzo5CC70Ni6FOLDqmcbBiXkDepY+F4utSuF8fpMouAEv3eNIlG3P
 +8zg==
X-Gm-Message-State: AJcUukcHFHtSu9eRzj893Id+PYL4XrpR7AdHrdBWHs0+CNwAMJk9D7OQ
 oVuoBvX618TnHi36DC6XN3M=
X-Google-Smtp-Source: ALg8bN5eshCohDgRr4aNT4DHZbbxXbPGsl6tcfcU1p2ZW+JtAH0/P63w9fWMtbQ4B+tA+eLKxDtTiQ==
X-Received: by 2002:a17:902:584:: with SMTP id
 f4mr17453617plf.28.1548558431604; 
 Sat, 26 Jan 2019 19:07:11 -0800 (PST)
Received: from localhost (g206.124-44-15.ppp.wakwak.ne.jp. [124.44.15.206])
 by smtp.gmail.com with ESMTPSA id t24sm53501159pfm.127.2019.01.26.19.07.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 26 Jan 2019 19:07:10 -0800 (PST)
Date: Sun, 27 Jan 2019 12:07:08 +0900
From: Stafford Horne <shorne@gmail.com>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 01/21] openrisc: prefer memblock APIs returning
 virtual address
Message-ID: <20190127030708.GU3235@lianli.shorne-pla.net>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-2-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548057848-15136-2-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_190713_033027_87BC665D 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, openrisc@lists.librecores.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 10:03:48AM +0200, Mike Rapoport wrote:
> The allocation of the page tables memory in openrics uses
> memblock_phys_alloc() and then converts the returned physical address to
> virtual one. Use memblock_alloc_raw() and add a panic() if the allocation
> fails.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/openrisc/mm/init.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index d157310..caeb418 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -105,7 +105,10 @@ static void __init map_ram(void)
>  			}
>  
>  			/* Alloc one page for holding PTE's... */
> -			pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
> +			pte = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> +			if (!pte)
> +				panic("%s: Failed to allocate page for PTEs\n",
> +				      __func__);
>  			set_pmd(pme, __pmd(_KERNPG_TABLE + __pa(pte)));
>  
>  			/* Fill the newly allocated page with PTE'S */

This seems reasonable to me.

Acked-by: Stafford Horne <shorne@gmail.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
