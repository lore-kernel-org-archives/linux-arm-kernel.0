Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9131BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:51:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF3E21904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="epK2I3MJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xbl66mYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF3E21904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NiAycs2fVbVzqMI5U9PevHM6kA+O1La4MF5tjVoNAXA=; b=epK2I3MJzV/Pex
	bHOQZhWnOvyzzx+cdYpqsM5wMoFAEmKGtkgeyJXu1rvM/mT4/0R4ku0GtIOrPq1k6sGDSx8zHTM6G
	niM51D9Kzzagk7jb+NnvY24mloDgZlCLuPZsg9mezXYzOb56c8cTQdRu+grtKXU63iGuWzMvXN5nr
	+1Xc8Y1p6kdY370eJICJhfqKZ2yfRgzsSQasozKKXQRLkMM6PVU98lg0P1MMSqkKEGZ/hKwmsb14J
	Eyqx1aEV+QYt4IiDaCEgUkJLX+2ouiHjTup6Y9bcZ8L/PJ4eZrESqVN6PwE2K8nZtDdQmv5L1gjxm
	ILfpfdIacAsRmFLwnF5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw17q-00036c-9K; Tue, 19 Feb 2019 08:51:38 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw17m-00035p-Uy
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 08:51:36 +0000
Received: by mail-ot1-x341.google.com with SMTP id b3so32921566otp.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 00:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tlV9vLB+KSMsmXO/I53mLkrat4UHKAVvOR8nqbfYTjw=;
 b=Xbl66mYw6fd/AAeklC09hLlPoGGov/UOZz7vOpQDOC6a71lsbpuv2jtTVvgJFUg38T
 FEs3q1yEXzo2JFtKPT7HA1CzP9z6LrOHQXCR4oM0GFQxlA/KwNOnnKMaG9C/FNhnHI1U
 xhCiuIcQfs+NclRvCqwHMonV1iGp9OL0KqqGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tlV9vLB+KSMsmXO/I53mLkrat4UHKAVvOR8nqbfYTjw=;
 b=VPxDcWr1/RYByYR68J8j/pZlDWv7xqW5nmKk4n4vVVzj6o3TfWz/z6A8y5MRL2ItUH
 vxqkhEWHtcqVjpWdpO7tgpo8hnVWdnMeq1F+ne2/KsehaCbG37RLg5697CuXYZ+EleRJ
 JEq1bT377vb1iV/muXraEw2A7A351jA3WtC1Chbw6Mcme5WS2SFEY67Q1e4srEGbfbd/
 cpwD8YFO4CfqtETU4UzOv/X9AQQpuqTSswI+cVwSF60BSe04/qcMXR3kqNUaZ0oWiQuy
 IUgSs8KAaexq1mUKc56YmVC6gxAfz9uktHM84/PDQxwPuEiY1JzOxQNY6mkXI87yXK/b
 ztFg==
X-Gm-Message-State: AHQUAuaZFeqZzBcW06MVYbUMO5gw1Kro9NpofeTfg9+u76lIUuWonv2T
 azBpqjXmlaW1J6UkucgplOiRVmF94+Y=
X-Google-Smtp-Source: AHgI3IZ/N0pwEBA72PxtqYVY80Qx5CMBpxB1t5Ib2uPj0eZ5eqEx7LmiGMvt9T7yIN6zDK5DNjD+Kw==
X-Received: by 2002:a9d:6d89:: with SMTP id x9mr9260245otp.121.1550566293287; 
 Tue, 19 Feb 2019 00:51:33 -0800 (PST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com.
 [209.85.210.52])
 by smtp.gmail.com with ESMTPSA id n65sm7129308oib.12.2019.02.19.00.51.31
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 00:51:31 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id i5so32872559oto.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 00:51:31 -0800 (PST)
X-Received: by 2002:aca:5657:: with SMTP id k84mr1883764oib.173.1550566290647; 
 Tue, 19 Feb 2019 00:51:30 -0800 (PST)
MIME-Version: 1.0
References: <1549348966-14451-1-git-send-email-frederic.chen@mediatek.com>
 <1549348966-14451-8-git-send-email-frederic.chen@mediatek.com>
 <CAAFQd5CWdZUXVb4F9BLhQdN8WHjzA8acPDx1i+WcoudsdGsfUg@mail.gmail.com>
 <1550372163.11724.59.camel@mtksdccf07>
In-Reply-To: <1550372163.11724.59.camel@mtksdccf07>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 19 Feb 2019 17:51:19 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CaXz_Lqz8NhGK4DvaxPvuYLj-Y73sG7wFaqW44j+tZQw@mail.gmail.com>
Message-ID: <CAAFQd5CaXz_Lqz8NhGK4DvaxPvuYLj-Y73sG7wFaqW44j+tZQw@mail.gmail.com>
Subject: Re: [RFC PATCH V0 7/7] [media] platform: mtk-isp: Add Mediatek ISP
 Pass 1 driver
To: Jungo Lin <jungo.lin@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_005134_997916_29873B5D 
X-CRM114-Status: GOOD (  23.59  )
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
Cc: frankie_chiu@mediatek.com,
 =?UTF-8?B?U2VhbiBDaGVuZyAo6YSt5piH5byYKQ==?= <Sean.Cheng@mediatek.com>,
 Frederic Chen <frederic.chen@mediatek.com>,
 =?UTF-8?B?UnlubiBXdSAo5ZCz6IKy5oGpKQ==?= <Rynn.Wu@mediatek.com>,
 =?UTF-8?B?Q2hyaXN0aWUgWXUgKOa4uOmbheaDoCk=?= <christie.yu@mediatek.com>,
 srv_heupstream@mediatek.com,
 =?UTF-8?B?SG9sbWVzIENoaW91ICjpgrHmjLop?= <holmes.chiou@mediatek.com>,
 seraph_huang@mediatek.com, Jerry-ch.Chen@mediatek.com, yuzhao@chromium.org,
 ryan_yu@mediatek.com, Sj Huang <sj.huang@mediatek.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 linux-mediatek@lists.infradead.org, zwisler@chromium.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jungo,

On Sun, Feb 17, 2019 at 11:56 AM Jungo Lin <jungo.lin@mediatek.com> wrote:
>
> On Wed, 2019-02-13 at 18:50 +0900, Tomasz Figa wrote:
> > (() . ( strHi Frederic, Jungo,
> >
> > On Tue, Feb 5, 2019 at 3:43 PM Frederic Chen <frederic.chen@mediatek.com> wrote:
> > >
> > > From: Jungo Lin <jungo.lin@mediatek.com>
> > >
> > > This patch adds the driver for Pass unit in Mediatek's camera
> > > ISP system. Pass 1 unit is embedded in Mediatek SOCs. It
> > > provides RAW processing which includes optical black correction,
> > > defect pixel correction, W/IR imbalance correction and lens
> > > shading correction.
> > >
> > > The mtk-isp directory will contain drivers for multiple IP
> > > blocks found in Mediatek ISP system. It will include ISP Pass 1
> > > driver, sensor interface driver, DIP driver and face detection
> > > driver.
> >
> > Thanks for the patches! Please see my comments inline.
> >
>
> Dear Thomas:
>
> Thanks for your comments.
>
> We will revise the source codes based on your comments.
> Since there are many comments to fix/revise, we will categorize &
> prioritize these with below list:
>
> 1. Coding style issues.
> 2. Coding defects, including unused codes.
> 3. Driver architecture refactoring, such as removing mtk_cam_ctx,
> unnecessary abstraction layer, etc.
>

Thanks for replying to the comments!

Just to clarify, there is no need to hurry with resending a next patch
set with only a subset of the changes. Please take your time to
address all the comments before sending the next revision. This
prevents forgetting about some remaining comments and also lets other
reviewers come with new comments or some alternative ideas for already
existing comments. Second part of my review is coming too.

P.S. Please avoid top-posting on mailing lists. If replying to a
message, please reply below the related part of that message. (I've
moved your reply to the place in the email where it should be.)

[snip]
> > > +       phys_addr_t paddr;
> >
> > We shouldn't need physical address either. I suppose this is for the
> > SCP, but then it should be a DMA address obtained from dma_map_*()
> > with struct device pointer of the SCP.
> >
>
> Yes, this physical address is designed for SCP.
> For tuning buffer, it will be touched by SCP and
> SCP can't get the physical address by itself. So we need to get
> this physical address in the kernel space via mtk_cam_smem_iova_to_phys
> function call and pass it to the SCP. At the same time, DMA address
> (daddr) is used for ISP HW.
>

Right, but my point is that in the kernel phys_addr_t is the physical
address from the CPU point of view. Any address from device point of
view is dma_addr_t and should be obtained from the DMA mapping API
(even if it's numerically the same as physical address).

Best regards,
Tomasz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
