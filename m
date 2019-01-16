Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EA6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:27:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667F920675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DEE1rCZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667F920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UQiIEmqAL1TfHiWg+/7GVXTwHK7/1lfa5EVVTfAonps=; b=DEE1rCZqvBj6kZ
	BgAe6dwHBJTosyemGSEK5Z/aAK0z4iexdJHOu50mpgcSU/hzxcY5Oqv42gDNlC7CI0KdX7a2BO0sG
	wxRYvKpm5kybIbE9IZPbWoFidG0QitzmmU/YhZxD90Ua0147dCCaUldBY2wtDTEKdqEU39ORfCpmj
	7U56JElVNBNnuMnUCAhReoGdTY2xVey1LNn1uStHrTaYoVpzt8NCdsjiiDSZsnGA8zkPGYBrvm33O
	NslFd4JpH2JaeHsZSrKNeoJ3eau2p48dgi9TpbxNgdvTXFZ3HpgdN+DANTqYbSrgy9zHz3AxGvGI3
	C9jvV3uWgJceg7dHiTWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjmAc-0005uj-9g; Wed, 16 Jan 2019 14:27:54 +0000
Received: from mail-vk1-f196.google.com ([209.85.221.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjmAY-0005uF-B3; Wed, 16 Jan 2019 14:27:51 +0000
Received: by mail-vk1-f196.google.com with SMTP id d201so1462514vka.0;
 Wed, 16 Jan 2019 06:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UQM6mniKlKxrnOmNQBuQkbxwhizn1F4ro8TFUMtXkmo=;
 b=Jzzf7anvzjP205j4C9ALNtw9tEQJ4VBc0idrlYriJMdN/aEVTzBikcxeLoulGgC+lZ
 Be0Dn/JbQIO3q7wbsga4v2XRYrf/Pt+OEzkdnfkQQEcipMDSFhdQhkmTyqTlfSc9Kx89
 XoNesb7aBSCRuXUQH6MhqltZf2aqvyVWm9Ljvvl9NwwowTP1Lh/e+j+pbTJKAJP2Ahfh
 AvSEANkvcK5lIscdFIjIC3pTUPg7drgXMNBa6xdP39E5D6zLp0ScCS6LK9CJ+PHvngXU
 cKyn/Q/Rk6M/Vm73ye8rQGZrIvrwrFi6GzY5M7VnJlF9k8YwQ1H+LvJnNUmitR2NEEgh
 O1aw==
X-Gm-Message-State: AJcUukcDLqEOcyMt7Fs4feupPWVV30peG1PegLm+qWk7/eV7N8t6ORQB
 P191dArhUe81afPdPfrWJ8AI5NGJDmGCF635wco=
X-Google-Smtp-Source: ALg8bN6VwI1ArYelHZvmR1PaA1MLFLrSrq7A9DMWJ0UBcwJmVEmORYrACtE6Zw/o+h9WHLVB78c6er2JrxSMrNC9Lxk=
X-Received: by 2002:a1f:2ed7:: with SMTP id u206mr3609173vku.72.1547648869025; 
 Wed, 16 Jan 2019 06:27:49 -0800 (PST)
MIME-Version: 1.0
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-20-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1547646261-32535-20-git-send-email-rppt@linux.ibm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Jan 2019 15:27:35 +0100
Message-ID: <CAMuHMdWKPj-2Let44rmaVwh-b6kkGg+0cFPQ-+3k9LP86pB7NA@mail.gmail.com>
Subject: Re: [PATCH 19/21] treewide: add checks for the return value of
 memblock_alloc*()
To: Mike Rapoport <rppt@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_062750_386863_4D79702E 
X-CRM114-Status: GOOD (  16.83  )
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 the arch/x86 maintainers <x86@kernel.org>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, Linux-sh list <linux-sh@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>,
 Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 alpha <linux-alpha@vger.kernel.org>, linux-um@lists.infradead.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Linux MM <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 USB list <linux-usb@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 Openrisc <openrisc@lists.librecores.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mike,

On Wed, Jan 16, 2019 at 2:46 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> Add check for the return value of memblock_alloc*() functions and call
> panic() in case of error.
> The panic message repeats the one used by panicing memblock allocators with
> adjustment of parameters to include only relevant ones.
>
> The replacement was mostly automated with semantic patches like the one
> below with manual massaging of format strings.
>
> @@
> expression ptr, size, align;
> @@
> ptr = memblock_alloc(size, align);
> + if (!ptr)
> +       panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,

In general, you want to use %zu for size_t

> size, align);
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks for your patch!

>  74 files changed, 415 insertions(+), 29 deletions(-)

I'm wondering if this is really an improvement?
For the normal memory allocator, the trend is to remove printing of errors
from all callers, as the core takes care of that.

> --- a/arch/alpha/kernel/core_marvel.c
> +++ b/arch/alpha/kernel/core_marvel.c
> @@ -83,6 +83,9 @@ mk_resource_name(int pe, int port, char *str)
>
>         sprintf(tmp, "PCI %s PE %d PORT %d", str, pe, port);
>         name = memblock_alloc(strlen(tmp) + 1, SMP_CACHE_BYTES);
> +       if (!name)
> +               panic("%s: Failed to allocate %lu bytes\n", __func__,

%zu, as strlen() returns size_t.

> +                     strlen(tmp) + 1);
>         strcpy(name, tmp);
>
>         return name;
> @@ -118,6 +121,9 @@ alloc_io7(unsigned int pe)
>         }
>
>         io7 = memblock_alloc(sizeof(*io7), SMP_CACHE_BYTES);
> +       if (!io7)
> +               panic("%s: Failed to allocate %lu bytes\n", __func__,

%zu, as sizeof() returns size_t.
Probably there are more. Yes, it's hard to get them right in all callers.

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
