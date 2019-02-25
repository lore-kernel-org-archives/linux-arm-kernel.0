Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFE4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:22:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68FD22087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 00:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rq1NKjGf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZ38apok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FD22087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aKSJ18hlXSQ3UlWtA4FeDZWaCbLrydftwjwZvuGrSJY=; b=rq1NKjGfpO/flL
	GX7/Ag2YoHVFrG26CQIqh6YvT9663/fJZP5UrjzeTt8h64uhSRfX2uIM3njdzZpF/4tAIFpwikjoY
	PMR+JalgOmxTt90HpVR1FppBgEVcmMEZRwRQnE+VJQ1trl1gLNbylzCNCG2S1cGswaNjDTdiyG4Vw
	6iPVTwmnj7dUiIYdkEzpmxoES6Az9cvCplkbIfDEyR/81MFPDOGLpdla8AULxuA4uUwnCncMKvTc7
	lGOht5IhgEvZqcz66ogtfPOJX8VvRRKSMozPZNANT19P8icbEPKeEh5bHDrtzw7vZBHezfmSHz+l3
	Of12uCzJwpx3y8nLb8jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy425-0004zy-4c; Mon, 25 Feb 2019 00:22:09 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy41z-0004nR-03
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 00:22:06 +0000
Received: by mail-qk1-x741.google.com with SMTP id r21so4303919qkl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 24 Feb 2019 16:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i/g4BDEoO8SC6+oPvz0qKmvXvQvwhQTeBbQj9LTfon0=;
 b=WZ38apoka6NE2KnNy/z1W+sat5yVyK5+zfAlXfjqITKZ9JzkPyweJ/SO7b6btf60WD
 PI5SvXABLKWSvuVLKPWJ/e7PKZDpRaossEg0u1VhI55DLhBa1g3pLZWmzhaN8qM+meKN
 kmL6wJHi7yvP2DjLcPsZuOGT04ZgKAcr1L5CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i/g4BDEoO8SC6+oPvz0qKmvXvQvwhQTeBbQj9LTfon0=;
 b=OaSFViqKELILDmaiZhiqJPTsAEXEWy2MINCmCx9q+5G4KeP9gS5wid0Im7mNrIugBL
 VWG/I7Mw9ieED8Oc5PWXb9GQxNagBOoCkjZQxvha4epqAZTbNTrjAWbDjZn1vfKRqR7J
 igxjKO26C80cIDPN3AohwtD/BYkRJKotb6yGvA/T7Cj5O8fmsmgCd1vFsbjO7LKKCa1j
 PhaB+n7tpABWmeoyErI9AHCC6p0J3VsxOAJWhXlFxPIndfBUdwKjTYfqt795EY9d6N/A
 XS1wsZxZghbfKdxT6luF/ytam2dN7ogFQ5c6LltP39fqO9907MpOF9YmcGTrvmUAcmCB
 +VTw==
X-Gm-Message-State: AHQUAuYS9DO4MoF6oiMssiu1dy1z8ODJpzpyH6n5faBt15+olyk9RMRK
 fKh5fiUhVWWWvhTKuSsXosS8xmdbhlC3uhr4AvWu7Q==
X-Google-Smtp-Source: AHgI3IY0xWjsLv/q1IQxIeA+244z8dKuLaaa8H82IYd1XWkXf/equj7WGgODV95dC+nfj7Yd1VI8iLKnKP2LvNqR6so=
X-Received: by 2002:a37:634b:: with SMTP id x72mr11055193qkb.151.1551054117856; 
 Sun, 24 Feb 2019 16:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20190128094301.151252-1-drinkcat@chromium.org>
 <20190130182137.GN18558@fuggles.cambridge.arm.com>
In-Reply-To: <20190130182137.GN18558@fuggles.cambridge.arm.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Mon, 25 Feb 2019 08:21:46 +0800
Message-ID: <CANMq1KAsZHZ42Kt98eSy8Lmh+87S9cob2uSNWjZtLDrWmEEk3w@mail.gmail.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm-v7s: only kmemleak_ignore L2 tables
To: Joerg Roedel <joro@8bytes.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_162203_828976_2802F0E5 
X-CRM114-Status: GOOD (  14.83  )
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
 Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Joerg: Just to make sure, is this patch in your queue? Thanks.

On Thu, Jan 31, 2019 at 2:21 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Jan 28, 2019 at 05:43:01PM +0800, Nicolas Boichat wrote:
> > L1 tables are allocated with __get_dma_pages, and therefore already
> > ignored by kmemleak.
> >
> > Without this, the kernel would print this error message on boot,
> > when the first L1 table is allocated:
> >
> > [    2.810533] kmemleak: Trying to color unknown object at 0xffffffd652388000 as Black
> > [    2.818190] CPU: 5 PID: 39 Comm: kworker/5:0 Tainted: G S                4.19.16 #8
> > [    2.831227] Workqueue: events deferred_probe_work_func
> > [    2.836353] Call trace:
> > ...
> > [    2.852532]  paint_ptr+0xa0/0xa8
> > [    2.855750]  kmemleak_ignore+0x38/0x6c
> > [    2.859490]  __arm_v7s_alloc_table+0x168/0x1f4
> > [    2.863922]  arm_v7s_alloc_pgtable+0x114/0x17c
> > [    2.868354]  alloc_io_pgtable_ops+0x3c/0x78
> > ...
> >
> > Fixes: e5fc9753b1a8314 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >
> > I only tested this on top of my other series
> > (https://patchwork.kernel.org/patch/10720495/), but I think the same fix
> > applies. I'm still a bit confused as to why this only shows up now, as IIUC,
> > the kmemleak_ignore call was always wrong with L1 tables.
>
> Yes, I managed to reproduce this on top of -rc4 (see below). I suspect you
> /are/ the intersection of people using v7s w/ kmemleak, so this has just
> lingered and never been hit until now.
>
> For the patch (assuming this is going via Joerg):
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> Will
>
> --->8
>
> [    0.124473] kmemleak: Trying to color unknown object at 0xffff8000042d8000 as Black
> [    0.125312] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc4-00012-g40b114779944 #1
> [    0.126181] Hardware name: linux,dummy-virt (DT)
> [    0.126680] Call trace:
> [    0.126950]  dump_backtrace+0x0/0x140
> [    0.127346]  show_stack+0x14/0x20
> [    0.127706]  dump_stack+0x90/0xb4
> [    0.128066]  paint_ptr+0x94/0xa8
> [    0.128417]  kmemleak_ignore+0x54/0x60
> [    0.128991]  __arm_v7s_alloc_table+0x6c/0x240
> [    0.129661]  arm_v7s_alloc_pgtable+0x10c/0x188
> [    0.130359]  alloc_io_pgtable_ops+0x44/0xb0
> [    0.131006]  arm_v7s_do_selftests+0x84/0x4bc
> [    0.131663]  do_one_initcall+0x74/0x178
> [    0.132253]  kernel_init_freeable+0x188/0x220
> [    0.132923]  kernel_init+0x10/0x100
> [    0.133460]  ret_from_fork+0x10/0x18
> [    0.142102] arm-v7s io-pgtable: self test ok

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
