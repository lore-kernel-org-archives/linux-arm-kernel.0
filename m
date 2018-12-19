Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80092C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:31:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D47721871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d3gs+Ial";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQjLNi60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D47721871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jFhaQx+bHQFYgK3Bq/c/OVAAmQh4A0Dsl/1xP+hpRI0=; b=d3gs+IalN3Tyxo
	jc90nNisnOvGyZQ09UeCruaHJgyzEcMqDyWB0bbe5IdT8fYvVZgo8rO/qAmzP9UZx+wyM+WeQhhWu
	0wtcg0fQSbVlZ4tTxnW7/ibuSAJQJjTeiusyoE43Vd5r6HeV0sGSyNIKlGAgEFOGg/RP5ucIeqQOM
	lvxwQfP8++Z/lU1yqS5dg9CR1HZCViwf1bY2X0YlrwWv36wmDTZ6e5wJW9/DbIRjsENBzI8iLVct3
	0gECvUiM0d7dxvGFx3fbxdtTChpDxtSsWivJjpuPk4aOAepAD0M8ZPaq28Zs5q0nl38Hl2jrXNyHz
	AWfcocHR0AtqXaGz20zw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZSa9-0004jQ-LN; Wed, 19 Dec 2018 03:31:37 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZSa4-0004hw-Tg; Wed, 19 Dec 2018 03:31:34 +0000
Received: by mail-lf1-x142.google.com with SMTP id z13so13884477lfe.11;
 Tue, 18 Dec 2018 19:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hyoE9cQYj2vKKeNaKbEZn+1/rj10Ta2+2thIX+qo1mM=;
 b=XQjLNi60OQMSNl8uGp8JWoIVDx7+LLcQ46BFKojokG5wz4nId2PwPWwcYXF5ewHn3J
 EcIbxmYeWA4HepLPpx4EPwnahRNcOFM/gb/YtjrlmkiGbWKogwhtsCSNmG6+zmyNMq64
 cZMXW2seVxU61ZS9BxO1qv/KMIwEGFmTcLUJH+1CX1hXFo5/KZSIXcBORrgh/kWEa2aZ
 xRhd5+UeLSPi1AVXhaH4zM5axZtfevgWIlDx+ZaH7e2KaZlSWdrEBjWuN1ZqEXuyI13U
 YW0Thnebflvl6Xbj7DGnoCBE+iNrtmHWTjBXZGgZKDJyzOXYb59SpOLpy+EvdrS+AqZ3
 6P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hyoE9cQYj2vKKeNaKbEZn+1/rj10Ta2+2thIX+qo1mM=;
 b=MJehTKdfWyCxiJEVRsb5vWTuYXMjNmpSNhKhy41u8Fo71IjW1R4XxGiZKa2+D2G1++
 7Md73ngUsxheVpY1Z1Hf8TAk1FpvHYrnDmYOUEEJCSXagrSbAC5EIbrI9yQQIKhknEcy
 Pz+1Kiigsf31Dzfyk7q60Xjo5pWNSwPheC8+XgR22uV5/rL08003FCix3zJQHWsScZ65
 x3Ut+PpAPjd05AvRP9dZtnongfKvo3PEa3pbnn7FysF0WaQwuSjuQQXnESE9gDfetVY6
 kyL1feft7i+qFDXZ0VE9gob/uv4NRs7juZ2r5Vjbp9ORIupGdnQC/TMSnLIC31ghRaYI
 nbCw==
X-Gm-Message-State: AA+aEWY75Gzu0p24bUaKO8nxt6NcNuK3AsiUS2w+unxl91DvHK3m+4OE
 bVFWr2zlwNdpa13CtpmBn3yhmIkCWMDYG1qkGjo=
X-Google-Smtp-Source: AFSGD/XDXGEZjKZkD8gg6Kij5vdAu+Ms/qjx9Bu+i/tMgaufVgBZNtC0be8I7TrS0bbJWAI6cFCaXaYleSRgNHg75Qo=
X-Received: by 2002:a19:24c6:: with SMTP id k189mr11910717lfk.77.1545190280199; 
 Tue, 18 Dec 2018 19:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
 <20181218095709.GJ26090@n2100.armlinux.org.uk>
 <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
 <20181218123318.GN26090@n2100.armlinux.org.uk>
 <CAFqt6zbqaS-pFETyjRR2-1V57MiJuX65xoMjgkr-DjUnrJYzSg@mail.gmail.com>
 <20181218130146.GO26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218130146.GO26090@n2100.armlinux.org.uk>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 19 Dec 2018 09:01:09 +0530
Message-ID: <CAFqt6zYnn76OdprSvA2Bj0v=xQqtJ6xJse6+iB+-=u3WsEv3pA@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
To: Russell King - ARM Linux <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_193132_962436_D690B4A9 
X-CRM114-Status: GOOD (  26.09  )
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
 linux-rockchip@lists.infradead.org, airlied@linux.ie, hjc@rock-chips.com,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 6:31 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Dec 18, 2018 at 06:24:29PM +0530, Souptick Joarder wrote:
> > On Tue, Dec 18, 2018 at 6:03 PM Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Tue, Dec 18, 2018 at 05:36:04PM +0530, Souptick Joarder wrote:
> > > > On Tue, Dec 18, 2018 at 3:27 PM Russell King - ARM Linux
> > > > <linux@armlinux.org.uk> wrote:
> > > > > This looks like a change in behaviour.
> > > > >
> > > > > If user_count is zero, and offset is zero, then we pass into
> > > > > vm_insert_range() a page_count of zero, and vm_insert_range() does
> > > > > nothing and returns zero.
> > > > >
> > > > > However, as we can see from the above code, the original behaviour
> > > > > was to return -ENXIO in that case.
> > > >
> > > > I think these checks are not necessary. I am not sure if we get into mmap
> > > > handlers of driver with user_count = 0.
> > >
> > > I'm not sure either, I'm just pointing out the change of behaviour.
> >
> > Ok. I think feedback from Heiko might be helpful here :)
> >
> > >
> > > > > The other thing that I'm wondering is that if (eg) count is 8 (the
> > > > > object is 8 pages), offset is 2, and the user requests mapping 6
> > > > > pages (user_count = 6), then we call vm_insert_range() with a
> > > > > pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
> > > > > end up inserting four pages.
> > > >
> > > > Considering the scenario, user_count will remain 8 (user_count =
> > > > vma_pages(vma) ). ? No ?
> > > > Then we call vm_insert_range() with a pages of rk_obj->pages + 2, and
> > > > a pages_count
> > > > of 8 - 2 = 6. So we end up inserting 6 pages.
> > > >
> > > > Please correct me if I am wrong.
> > >
> > > vma_pages(vma) is the number of pages that the user requested, it is
> > > the difference between vma->vm_end and vma->vm_start in pages.  As I
> > > said above, "the user requests mapping 6 pages", so vma_pages() will
> > > be 6, and so user_count will also be 6.  You are passing
> > > user_count - offset into vm_insert_range(), which will be 6 - 2 = 4
> > > in my example.  This is two pages short of what the user requested.
> > >
> >
> > So, this should be the correct behavior.
> >
> >                  return vm_insert_range(vma, vma->vm_start,
> > rk_obj->pages + offset,
> >                                                           user_count);
>
> ... and by doing so, you're introducing another instance of the same
> bug I pointed out in patch 2.

Sorry but didn't get it ? How it will be similar to the bug pointed
out in patch 2 ?


>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
