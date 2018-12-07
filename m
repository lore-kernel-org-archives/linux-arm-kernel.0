Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5926BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:25:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2410020882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pAHEflLH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtJu/QZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2410020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=02UayF1m9/L1XE3ETt7JbUkeXapzSQLUconHQTpGUzs=; b=pAHEflLHornvRV
	udpRhZs70x/a+lzm7lx5PODwtAzq3VBdvvhYECLYFCToJ2s0BjMK/8qEudKwGxkYuYQn+FL/JEh2I
	25Lq4d+Z9FeYxtsFtd9QO2DLI3v2NLhPw3zzTxTyVTk0jg3I6TK+8pmiXFau0Td6WfeugXxId7+KY
	vjCLaJjRQjm7ymJU29MZP+5BWZkz2ZAJFVaS5w0Q7tL6NZfxXVUDnDmgdtp4GAJS7xvw3XwD2GkAI
	ARYorH5mpyrz9ZKXr+eP/v8HZHaW7LVp8GnfL8jtV8mFG4Ojq2fvcKOaVe6hsNdfER6ouAnMPnigO
	Z9eIRjEw+HeVyhUlFKoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVLkI-00080d-BW; Fri, 07 Dec 2018 19:25:06 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVLkE-0007RW-AN; Fri, 07 Dec 2018 19:25:03 +0000
Received: by mail-lj1-x244.google.com with SMTP id k15-v6so4480020ljc.8;
 Fri, 07 Dec 2018 11:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9e2Wbzrvdn8hVT2tBhxVO0pp+kL6y3jwcx1ShpPzbP4=;
 b=ZtJu/QZlyw3bilEm8S9OjKcAaFKDl8uywXIJPv9AXBWu7HUv1lNYCsoq8HAKttktyj
 ssHKnjWFm75vcL1BkZR6S/HWT1LqZybi7PHlkHL5Gvyu1SX4Uv1WAY8o1yT5uIo9VnZY
 vpOujufXZQzDptqRH68QItFYzJLEfbo/l0kXvHSgZyTb5d9yGcnluZTEBxPSiF6Wi/i4
 D6LdrFTq9B6gKKkFc0wmIOsj7KboFS7ojG0/UP5B4tBFQo0EL188h8Sw6mlpJOBVvYHm
 xlWaL+qNVtOLh6aLFsUD9mklVCrvNKlMW5i3EgHUUglppRWtsj4/Ahh5Kyf5lDmFczee
 iefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9e2Wbzrvdn8hVT2tBhxVO0pp+kL6y3jwcx1ShpPzbP4=;
 b=kKG2tPq1jYsqLQdZFDSp5Y3d9/JSrPBlIXCcOtTv7wPrFSbTvOwsk4bf8m6KEIlA5y
 rH1v31fqkdhUuTi4GUpEvINmsZCt06wH3ehlK2PupSGYODKym6d1H6eZb1D22UFil+eS
 Rj/Nrmb8AsZEEtnVKQuPpq73vXhGjT223maxsfMLno/ob8jR1TCssmmAWcaeNOhg/pao
 QIevngr9dyV7+JeZz0wiiV90qTazIqZJ7D/Sn0oCRh4U1cIP06z5RLwgH9wpI8cYp6Dz
 L3UJ7WdL8Ne2vHoVua6obg54BuFIGhCFRyG9m5Cu7cQKuDV7v1RE14fyEu8WJXajy7YQ
 XK9A==
X-Gm-Message-State: AA+aEWYJP8U33DQxkhcz/wwH5AhhnAwNXuQXHg7L5j8kG9BqH7NSPVub
 c6yNfeaQ1DmzF3UhIHKrxaGRaXqn0SbfcYCRm6k=
X-Google-Smtp-Source: AFSGD/XIzVoTRj76yRnUtycSWUcaUvahf5IXbuO2knQ2ryaj0PDXh4XL9bWH40gRgXnet7zbl7DHlrkXUU8kk86yIgw=
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr2058524ljg.64.1544210689938; 
 Fri, 07 Dec 2018 11:24:49 -0800 (PST)
MIME-Version: 1.0
References: <20181206183945.GA20932@jordon-HP-15-Notebook-PC>
 <53bbc095-c9f5-5d6a-6e50-6e060d17eb68@arm.com>
 <20181207171116.GA29923@bombadil.infradead.org>
In-Reply-To: <20181207171116.GA29923@bombadil.infradead.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sat, 8 Dec 2018 00:58:26 +0530
Message-ID: <CAFqt6zYCWOK-uS85GqCzcgT=+YKn1nBrRPq+M9y6eJjmXEKH+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] mm: Introduce new vm_insert_range API
To: Matthew Wilcox <willy@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_112502_467803_913C81C4 
X-CRM114-Status: GOOD (  12.30  )
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
Cc: Michal Hocko <mhocko@suse.com>, Heiko Stuebner <heiko@sntech.de>,
 Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 linux1394-devel@lists.sourceforge.net,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, oleksandr_andrushchenko@epam.com,
 joro@8bytes.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
 iommu@lists.linux-foundation.org, airlied@linux.ie,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 treding@nvidia.com, linux-media@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, pawel@osciak.com,
 Rik van Riel <riel@surriel.com>, rppt@linux.vnet.ibm.com,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, mchehab@kernel.org,
 iamjoonsoo.kim@lge.com, vbabka@suse.cz, Juergen Gross <jgross@suse.com>,
 hjc@rock-chips.com, xen-devel@lists.xen.org,
 Kyungmin Park <kyungmin.park@samsung.com>, stefanr@s5r6.in-berlin.de,
 Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 10:41 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Dec 07, 2018 at 03:34:56PM +0000, Robin Murphy wrote:
> > > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > > +                   struct page **pages, unsigned long page_count)
> > > +{
> > > +   unsigned long uaddr = addr;
> > > +   int ret = 0, i;
> >
> > Some of the sites being replaced were effectively ensuring that vma and
> > pages were mutually compatible as an initial condition - would it be worth
> > adding something here for robustness, e.g.:
> >
> > +     if (page_count != vma_pages(vma))
> > +             return -ENXIO;
>
> I think we want to allow this to be used to populate part of a VMA.
> So perhaps:
>
>         if (page_count > vma_pages(vma))
>                 return -ENXIO;

Ok, This can be added.

I think Patch [2/9] is the only leftover place where this
check could be removed.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
