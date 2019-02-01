Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF53C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:38:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DAE218FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fB8rDQJ4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQmlKMug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DAE218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7LflXFgy900ChGcmgQR3caVx4yESWXXqF0H9ZqkIm8w=; b=fB8rDQJ47a+5h7
	sYWFUqDEJreiBO7o5a1L48KuHDjBM/5UFJB5cOcLVfQC3Hhl+6h4tTdjBmiakXzI37a845NZu37ac
	KK5zO6jYfX57sUWLusdlWn5dq4xTqlGb8R08+FuGyoHlUJkwtUfH39JTsZ+oTFfPYN+d6elBXGnx7
	88wpMCX8BdKDwdbEx+TpFDZY1GN8OZ0L7iPWW55fzBK/CQ1enLhbG6vT0lb9lBZFf/2YmeX5o7Xao
	Lah8wGYrLOtLAhKANnreC4dsW5xxerhJjP5cV9nXD/zrELw6NBSTs8j8zcKMsx597qs2RFkzX2Qln
	KXcDSD/czXeqDZ2Cx/qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpY5N-0002yb-FU; Fri, 01 Feb 2019 12:38:21 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpY5K-0002yC-2b; Fri, 01 Feb 2019 12:38:19 +0000
Received: by mail-lj1-x243.google.com with SMTP id v1-v6so5704689ljd.0;
 Fri, 01 Feb 2019 04:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FA5f7YY6n6QegB8E6sgW5d/K980UEuX80JV8baCFznE=;
 b=GQmlKMugZ3bwsuMyb/P7aK4QpswXwaapZ4DsT1fvEZI+8XD1CmbdiMhQQwRT/xvM41
 FyfIcL0N8bcp4jvn7Rwk4vJw0vHXWdS7oie1el+Hqn231IBHDAw6eD5+PSU6PWH0Kbrr
 wm+pUxdv5ycyzateCY5dPVP85pDjE5NPJhuXBBI7CzvL35940bts/64hf3iffhDjUWvh
 aAfcvwWtLCX3818splV9Mc9NtipwQGWQLvOX+l8X2NO6NQvDm+wMZsoF4pTdPcv7ZRCS
 kdZcReWw7MN1tXv1r24u+YCF2/21n4WrFhEUHRDayakh1YVkONA2gIIQdAHiNaJw54K/
 eeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FA5f7YY6n6QegB8E6sgW5d/K980UEuX80JV8baCFznE=;
 b=cf8m/z3vVVIoT+z4V7ifliQFLumWEBPPU9rTJA6DrvqpwubeK23CFBin2URtuz1T1x
 T4BeyYlLuPvYgHZ1crhaY5cDNmFAgfCaCZR4WAf2bK0VWfgTbSZmYa+4Lw/CcXH1zigU
 /2nPWbVZBixFF3ww3UYiiT91xKNmlsviS09Ddp0ykVxtjII9sZIjCBx6SokSavfk8g69
 HCR+G55ddjWYqcN2FgTeFy6gNd7uFEmaT4CV0eDhsWLuUI0m3K+LIMS+WWEdWhkhiIR3
 2YwrAiSz31lkBXT6jsnoC/NxmXu28jPRK+DBEiSoLUUQ+uzpWiWtyG8CCzTQKDo3Ka3P
 2/wQ==
X-Gm-Message-State: AJcUukeCFMesACimIYtAC1bK/RnhQJyMiqZWk+D/Yju8k+CFFlce1g5t
 aNxEDhXh9BtqkC2/Rw7plCjWjo3q5DZG3AAiYPM=
X-Google-Smtp-Source: ALg8bN63OQuN/I7+5c4lLuO9nn/Jxyf+w53AUJkRrvBxfuBKIIADHNYPuQlrqZkogRtB1XtcmnGCFBz+O8XMsDRzXzM=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr31185303ljj.9.1549024695704; 
 Fri, 01 Feb 2019 04:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20190131030812.GA2174@jordon-HP-15-Notebook-PC>
 <1701923.z6LKAITQJA@phil>
 <CAFqt6zbxyMB3VCzbWo1rPdfKXLVTNx+RY0=guD5CRxD37gJzsA@mail.gmail.com>
 <1572595.mVW1PIlZyR@phil>
In-Reply-To: <1572595.mVW1PIlZyR@phil>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 1 Feb 2019 18:08:04 +0530
Message-ID: <CAFqt6zbMHG3htSsOwV3SaEEp1rMbFCoDD_3EacDk1hw_a1HJeQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/9] mm: Introduce new vm_insert_range and
 vm_insert_range_buggy API
To: Heiko Stuebner <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_043818_137696_BDF2C860 
X-CRM114-Status: GOOD (  21.35  )
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
Cc: Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, hjc@rock-chips.com,
 Linux-MM <linux-mm@kvack.org>, linux1394-devel@lists.sourceforge.net,
 Stephen Rothwell <sfr@canb.auug.org.au>, oleksandr_andrushchenko@epam.com,
 joro@8bytes.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
 Matthew Wilcox <willy@infradead.org>, airlied@linux.ie,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-media@vger.kernel.org, pawel@osciak.com, Rik van Riel <riel@surriel.com>,
 iommu@lists.linux-foundation.org, rppt@linux.vnet.ibm.com,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, mchehab@kernel.org,
 vbabka@suse.cz, Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xen.org, Kyungmin Park <kyungmin.park@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>, robin.murphy@arm.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 6:04 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 31. Januar 2019, 13:31:52 CET schrieb Souptick Joarder:
> > On Thu, Jan 31, 2019 at 5:37 PM Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > Am Donnerstag, 31. Januar 2019, 04:08:12 CET schrieb Souptick Joarder:
> > > > Previouly drivers have their own way of mapping range of
> > > > kernel pages/memory into user vma and this was done by
> > > > invoking vm_insert_page() within a loop.
> > > >
> > > > As this pattern is common across different drivers, it can
> > > > be generalized by creating new functions and use it across
> > > > the drivers.
> > > >
> > > > vm_insert_range() is the API which could be used to mapped
> > > > kernel memory/pages in drivers which has considered vm_pgoff
> > > >
> > > > vm_insert_range_buggy() is the API which could be used to map
> > > > range of kernel memory/pages in drivers which has not considered
> > > > vm_pgoff. vm_pgoff is passed default as 0 for those drivers.
> > > >
> > > > We _could_ then at a later "fix" these drivers which are using
> > > > vm_insert_range_buggy() to behave according to the normal vm_pgoff
> > > > offsetting simply by removing the _buggy suffix on the function
> > > > name and if that causes regressions, it gives us an easy way to revert.
> > > >
> > > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > > Suggested-by: Russell King <linux@armlinux.org.uk>
> > > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > >
> > > hmm, I'm missing a changelog here between v1 and v2.
> > > Nevertheless I managed to test v1 on Rockchip hardware
> > > and display is still working, including talking to Lima via prime.
> > >
> > > So if there aren't any big changes for v2, on Rockchip
> > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> >
> > Change log is available in [0/9].
> > Patch [1/9] & [4/9] have no changes between v1 -> v2.
>
> I never seem to get your cover-letters, so didn't see that, sorry.

I added you in sender list for all cover-letters but it didn't reach
your inbox :-)
Thanks for reviewing and validating the patch.

>
> But great that there weren't changes then :-)
>
> Heiko
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
