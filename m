Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D76CC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:29:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE95218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WqjB6Lbz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMtBVCwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE95218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FTUhyNieF8D/hk5RfRpdmHGSwGe+dC9EYeRPILB/xKw=; b=WqjB6LbzEJUkb9
	UZmZMmsYsZMk0QUP+mQUUhafwTH3yGAImb1EWAPX6UVKto/b0QDnflDTWF0aQCzbviU/iwMQuBz+L
	pLyDbCd1/AGh54VvBMlEMckZILDgbQayc3VK03uJPzm7I/rhxRWqYM9aoXItDhLTw5mu9ZBxPr3uZ
	WZeEAr9EmUvf68TxeP5yJq5WrE5Sex3x9kbxcAt4oQytU8rZGq6vIqsVC8+Z2stzzPKvLUKP37scq
	zrjbSRd0WlCtRl2UDcMsEgx1plpn80jZ7ifO1vy0dNNOVfc0Yk7m+sqACd/LVUpSTvu0J2/vAaUeb
	wXhs7sQQ+LebD1nPH9qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbJn-0006Lr-9e; Thu, 24 Jan 2019 09:29:03 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbJj-0006LH-Av
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 09:29:00 +0000
Received: by mail-it1-x144.google.com with SMTP id h193so3382893ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 01:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YOgiQRbEc2ZGqRBKfFg3466MI00NsQxMby/czhlkrn8=;
 b=MMtBVCwoX7nPmat/Zu3fE2gyRB686DtszfASBsWsXelgf4qP/4lsF5RHThNfDZ2PGF
 FJFoVf3loh8VmbUbY2RSyR1yt3lJO1DfKOxDWwhGbWiWvFkdJO6VccXXj6cFXBeysLnZ
 CbU513EbflTpqigfkgAMUXrgb+ENJG7JykNcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YOgiQRbEc2ZGqRBKfFg3466MI00NsQxMby/czhlkrn8=;
 b=p/IES/cg041IpAB/rEwFcwEfnLCn+++7nLPpDW2+scRiOYYVkvyUT+QJETKX+0Sv2z
 foAjpvNTgrGQ2AShBio0++uEKGsl4UO6KjDKvhSLlwu7kYJOEcgiOHO7+P7RqaNSOdha
 Qjjtqreq7puEkTh+nZLlGKtdCe+HGI0K2fNyMgdL38eDYVTetZC7U/FTMD2ymYSbzJkv
 cMK8tC1MmhesZxN1OelPhTREDF0R7Mhqo+wlFT54dp8n2ThU6v4jlS8LlnoazJKBisn0
 PTZQPlfghD3gwHmlA2EmcFPcQLrMgJ14mHo7plNGw668oYYHz6oa5vvFzw6XoJ1snPsh
 3j9A==
X-Gm-Message-State: AJcUukcKIOUoU25SUWtQVFf9eu8g3paGKeIhgNg+kl92fN2mRPW5j/9d
 uxKNHzesVWqnn/HF+enYxwH9o9gH+O+AujiaTIF7+g==
X-Google-Smtp-Source: ALg8bN4JgLY/gFm1maSc+bETsFLPr/UaeNA5zos+EvnXWXoWHcBplWfV4NYk6BxLzUsPHoa/pw9yrVnfZefdjBf+mPA=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr1058463ith.158.1548322137295; 
 Thu, 24 Jan 2019 01:28:57 -0800 (PST)
MIME-Version: 1.0
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <20190124091316.GA22796@infradead.org>
 <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
In-Reply-To: <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Jan 2019 10:28:45 +0100
Message-ID: <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: "Koenig, Christian" <Christian.Koenig@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_012859_379988_4BF0F5E2 
X-CRM114-Status: GOOD (  19.72  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, Christoph Hellwig <hch@infradead.org>,
 David Airlie <airlied@linux.ie>, "Huang, Ray" <Ray.Huang@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 24 Jan 2019 at 10:25, Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 24.01.19 um 10:13 schrieb Christoph Hellwig:
> > On Wed, Jan 23, 2019 at 05:52:50PM +0100, Ard Biesheuvel wrote:
> >> But my concern is that it seems likely that non-cache coherent
> >> implementations are relying on this hack as well. There must be a
> >> reason that this hack is only disabled for PowerPC platforms if they
> >> are cache coherent, for instance, and I suspect that that reason is
> >> that the hack is the only thing ensuring that the CPU mapping
> >> attributes match the device ones used for these buffers (the vmap()ed
> >> ones), whereas the rings and other consistent data structures are
> >> using the DMA API as intended, and thus getting uncached attributes in
> >> the correct way.
> > Dave, who added that commit is on Cc together with just about everyone
> > involved in the review chain.  Based on the previous explanation
> > that idea what we might want an uncached mapping for some non-coherent
> > architectures for this to work at all makes sense, but then again
> > the way to create those mappings is entirely architecture specific,
> > and also need a cache flushing before creating the mapping to work
> > properly.  So my working theory is that this code never properly
> > worked on architectures without DMA coherent for PCIe at all, but
> > I'd love to be corrected by concrete examples including an explanation
> > of how it actually ends up working.
>
> Cache coherency is mandatory for modern GPU operation.
>
> Otherwise you can't implement a bunch of the requirements of the
> userspace APIs.
>
> In other words the applications doesn't inform the driver that the GPU
> or the CPU is accessing data, it just does it and assumes that it works.
>

Wonderful!

In that case, do you have any objections to the patch proposed by
Christoph above?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
