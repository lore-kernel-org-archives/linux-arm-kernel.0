Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF29C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:27:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B8D2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JHc1pgRD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="osxgSHnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B8D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q0bgT+PHOqSnahf2Q2ygXYZbMOxKfSi2q6e0PqWHB/8=; b=JHc1pgRDZzi/Jl
	hc22smEXWJlnxUfUzVgfuQjSWP9vL+p3QlsSMIk2yIdREe+1axUH5c65plhzEBiFErVjvtkQCFvlu
	gYsZHjGBsJl8ukT9/08NUk463ju484MY3jEkmI+mJ5aXfbw8WtXiICAWMT3vOsu/qZOEGG5du2obT
	Q6xOdkMvVntSDL8oXEVcUP3/1lyMv940gH+WtNBO0vxTXYXE3B3Sz9ttW8UHD4BXJzb4nGKeyO5Ny
	r1fFpaBaiUk+ekPVzSDmr9SihBeR4TJAf60CCnJZamFZMHxq9mQW9+PKMtPXOmCdPQgIJTTOgHJVw
	kBjpwp5kSU/nSjPLoscA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTr4D-0003uw-Re; Mon, 03 Dec 2018 16:27:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTr4A-0003rL-LD
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 16:27:27 +0000
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EF589214D9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  3 Dec 2018 16:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543854436;
 bh=qCSsx1ia05y4ES7b0cDduOEngAtMGWrVXunqUEXapJE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=osxgSHnSMh3d5C5Z87s/PUNubhOtJO5rlfY+R3LS8PPGNASd0NyRMvNKLIT6w7BkI
 58aCFtT6a6zHL7MZN5xtJnX9OYcyaEhCHX68ql+eiNTreDz+1edfdx9DERbpTdGTdx
 cPOJVv4HBTLEDp7zRe6+JFQ6nTr6AFRMFgtfMLAc=
Received: by mail-wr1-f50.google.com with SMTP id u3so12831210wrs.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 08:27:15 -0800 (PST)
X-Gm-Message-State: AA+aEWZED0zHOhDBNh8YinHn6QhR5mK1oF05UdRHe62bJ+9GWGPaGLdM
 CkQrFFjHq8z1k9CMBYDrb554JATVOxrtFrH0GVG4kg==
X-Google-Smtp-Source: AFSGD/UHg+Rgy6nW0S+kGUDaigts9RFTTI9lSVLk1wtwr1sI5Gf+vkTtl0wYMNx7Mjr/fOrUtrY7vaCYLjg7KDPVzq8=
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr15531587wrf.164.1543854434387; 
 Mon, 03 Dec 2018 08:27:14 -0800 (PST)
MIME-Version: 1.0
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 3 Dec 2018 10:27:02 -0600
X-Gmail-Original-Message-ID: <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
Message-ID: <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] arm, unicore32: remove early_alloc*() wrappers
To: rppt@linux.ibm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_082726_714933_65223AAF 
X-CRM114-Status: GOOD (  17.45  )
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
Cc: mhocko@suse.com, linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org,
 dalias@libc.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 deanbo422@gmail.com, jonas@southpole.se, linux-c6x-dev@linux-c6x.org,
 ysato@users.sourceforge.jp, Michael Ellerman <mpe@ellerman.id.au>,
 linux@armlinux.org.uk, msalter@redhat.com, Arnd Bergmann <arnd@arndb.de>,
 stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
 Greentime Hu <green.hu@gmail.com>, shorne@gmail.com, gxt@pku.edu.cn,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 9:48 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On arm and unicore32i the early_alloc_aligned() and and early_alloc() are
> oneliner wrappers for memblock_alloc.
>
> Replace their usage with direct call to memblock_alloc.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm/mm/mmu.c       | 11 +++--------
>  arch/unicore32/mm/mmu.c | 12 ++++--------
>  2 files changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 0a04c9a5..57de0dd 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -719,14 +719,9 @@ EXPORT_SYMBOL(phys_mem_access_prot);
>
>  #define vectors_base() (vectors_high() ? 0xffff0000 : 0)
>
> -static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
> -{
> -       return memblock_alloc(sz, align);
> -}
> -
>  static void __init *early_alloc(unsigned long sz)

Why not get rid of this wrapper like you do on unicore?

>  {
> -       return early_alloc_aligned(sz, sz);
> +       return memblock_alloc(sz, sz);
>  }

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
