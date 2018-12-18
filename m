Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D874C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:55:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C23321852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EMWfU2PL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+ofMn9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C23321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gfaI7he5QmEO0Ld5qizqhkzf2GYHzPS7veHTvyA8JVs=; b=EMWfU2PLWAab/5
	zQoHndgkjfnu214mSD95zfxAzEJEpBgyQYfBzeAMvbgmEgBvoa7AgwYbMBQfWc3oa5h/ZtcE6Cy3Y
	pFq7rEAj8TpxI1fpzS2TmBv5ks7Aen29Y5mj3dBjJ2Gkctrfa4JeKHijchcPKu6fPM0HZlxMQnP3x
	hwo2VMX4yU7okHMEOPa0F3lfgSflS6QwZ7g9aXwsNN4o4AoW+DlcXL1iB3BlVqBib3Ve4sEQ6JTeD
	EG4ET4u47dGr/WXD98xGWNjV1CIFFMjACylsLEUY80nJaZF/9qmEWWpJvPrTjTlY93GxZxzH0AKNI
	TXuOutcJifSF4MgAQyIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZEtn-0001t1-3O; Tue, 18 Dec 2018 12:54:59 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZEti-0001rR-SV; Tue, 18 Dec 2018 12:54:56 +0000
Received: by mail-lf1-x144.google.com with SMTP id f23so12145016lfc.13;
 Tue, 18 Dec 2018 04:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TiOdRpCcB5RW4TqZM074ipMTqVW9QTa6+4OEUBKgdz0=;
 b=j+ofMn9pL7ziht+9i0YlnsPRRQqrmCSc4PVj/dbHod6e/WoLSYlDBKG1uxj4Na/pDa
 PwE3Xpe1xLM1NPPLYmoidU0CP6z1RhTWzECLuDk5STL9DmXNbHRY9FedFR7U0szEccEb
 ZDupnI94UxtHcmquG9+MtHI60NA7YbhcOjRYn1vWFnCUU/8jjibpTPj7Sp8R2bYWtlHH
 mZsUFsLvcf4k/LBBr45kTtwHU726vrhdId/Kcv7KTI9HNxvdDcuSHKHWX0cWyRk73Q6z
 84AhcUoV5K2PY43vQnajEkeBFoEnP9OJ1m6ZRmLvPu/668Te21in2Lq6PLvfjMO6fZAU
 v3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TiOdRpCcB5RW4TqZM074ipMTqVW9QTa6+4OEUBKgdz0=;
 b=FdmqIiX6JnvBzL8swXDRSOjKYcGE8x9kZjz+vNxokQXeHUOJA7qDDxWuDeCnDGIqjb
 26wn+YUHxwZnfl1bzrkB8fZQu57VJMvpRTYmerQoKwBoBQYyj3So1Kefo4YJIJwUUQa1
 p155/5zsBshypD0HQ65rbEsyLBA7OvNOOllxQgnqFhcC2SdFBUP4X0z2XvuPwKKskLpt
 YnhsJRkXdtvOqvdFck/yO7J3KzmXRUe7RpuC9pnsL7p47oMzVMTxkyTpJVh9eksBbU/z
 rKPHZ+rBqTqyRzW7khB5NacCldtgpaMnwkCmTK7PCVTNcm4N3jaHHrQPZrUENL3tseZa
 FCHg==
X-Gm-Message-State: AA+aEWaDaxkHH3zwDy9D7yFFXM29MpP2mQw6JfD4NFKe20nwrK8W+8X3
 xtKmmoyRyQOjhjbewxdtV5ad2S2Ki+Lyp+h/lLQ=
X-Google-Smtp-Source: AFSGD/UIp+suEbV1Uz3/N4wGmi4vyjsGqh6gbFo1pbJjxwEbFS7gl5FTWcERUtIl1pWigBZO8qIlQd8+seR1/mcS11E=
X-Received: by 2002:a19:6514:: with SMTP id z20mr2633604lfb.31.1545137681798; 
 Tue, 18 Dec 2018 04:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
 <20181218095709.GJ26090@n2100.armlinux.org.uk>
 <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
 <20181218123318.GN26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218123318.GN26090@n2100.armlinux.org.uk>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 18 Dec 2018 18:24:29 +0530
Message-ID: <CAFqt6zbqaS-pFETyjRR2-1V57MiJuX65xoMjgkr-DjUnrJYzSg@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
To: Russell King - ARM Linux <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_045454_923307_CFD21B3A 
X-CRM114-Status: GOOD (  20.77  )
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
 Linux-MM <linux-mm@kvack.org>, airlied@linux.ie, hjc@rock-chips.com,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 6:03 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Dec 18, 2018 at 05:36:04PM +0530, Souptick Joarder wrote:
> > On Tue, Dec 18, 2018 at 3:27 PM Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > > This looks like a change in behaviour.
> > >
> > > If user_count is zero, and offset is zero, then we pass into
> > > vm_insert_range() a page_count of zero, and vm_insert_range() does
> > > nothing and returns zero.
> > >
> > > However, as we can see from the above code, the original behaviour
> > > was to return -ENXIO in that case.
> >
> > I think these checks are not necessary. I am not sure if we get into mmap
> > handlers of driver with user_count = 0.
>
> I'm not sure either, I'm just pointing out the change of behaviour.

Ok. I think feedback from Heiko might be helpful here :)

>
> > > The other thing that I'm wondering is that if (eg) count is 8 (the
> > > object is 8 pages), offset is 2, and the user requests mapping 6
> > > pages (user_count = 6), then we call vm_insert_range() with a
> > > pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
> > > end up inserting four pages.
> >
> > Considering the scenario, user_count will remain 8 (user_count =
> > vma_pages(vma) ). ? No ?
> > Then we call vm_insert_range() with a pages of rk_obj->pages + 2, and
> > a pages_count
> > of 8 - 2 = 6. So we end up inserting 6 pages.
> >
> > Please correct me if I am wrong.
>
> vma_pages(vma) is the number of pages that the user requested, it is
> the difference between vma->vm_end and vma->vm_start in pages.  As I
> said above, "the user requests mapping 6 pages", so vma_pages() will
> be 6, and so user_count will also be 6.  You are passing
> user_count - offset into vm_insert_range(), which will be 6 - 2 = 4
> in my example.  This is two pages short of what the user requested.
>

So, this should be the correct behavior.

                 return vm_insert_range(vma, vma->vm_start,
rk_obj->pages + offset,
                                                          user_count);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
