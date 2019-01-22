Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F80C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:51:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8281220870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a85SRkgA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mdh/az/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8281220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lDrCP+3iQ/JlTy/19IN3qI4JkNtfO3hPTROmxKhzwZw=; b=a85SRkgAU/1gZx
	6MZOpfVn6V7JEhvMJ0oF33APTzRdFgjRaZ0Ra4IE3HFxTVwJ8v+cWnFztABoHJwkbD+8prW9x+17h
	yzQP3LxUJaVfUyRwXqa7GNPr3WibmOmP/y9YrCF2cl6wmD6DdjVqdNxUK9LcGxk5jzwennCLByo0W
	5DEI/TrpsV4gzHzqCXxyNB3aXtcOSoOIDV5GBdF3JkJ1W+fKDBqMQiwb2evptXIjZxvPulM8gdGIh
	gogHDnClZUVR4DrBRnOvO+BOR0nL0yg7cyViQ1vAGn/3N2IWsra8nMd42FWL88XfabvELE+gurV4Z
	hDj5O+F1nnIrtBVrcaHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm4t9-0003z5-2a; Tue, 22 Jan 2019 22:51:23 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm4t5-0003yc-Dz
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 22:51:20 +0000
Received: by mail-qt1-x841.google.com with SMTP id p17so281209qtl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 14:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o/XBYHY6SKkDwEIlSoffdYinDoT8V1LONeQ2d/odNaQ=;
 b=Mdh/az/ur8N3P0fSSYxO41aX78d92rObeQskl7lbc4hS9DeDf73UVzUUoQnLrUd0Bd
 Zatbb+NMZBOeS3NFGPdYahMoTBb07Iq5+kNvUVnquujE7C9y5uRKH0RP9h9mCLl90VY+
 XomJsnQMp5EEdrxsr8xxLlc1SHbxLsUMdNl0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o/XBYHY6SKkDwEIlSoffdYinDoT8V1LONeQ2d/odNaQ=;
 b=BMEqEUkbaDKA/dkCf3+2QfzSUENhMsb1VSBRa1cbAQknv+SMVZzSCSpHMowZKntwbt
 WEdGNOqMsyx6O7zsvcdrzWyuTfFwZ5KTbEUbSTIoolTgXEii2GdzJ9MneZX0yU9GPQlx
 OHIBcBY0UeCbzAfTRouSoceQT0WAYw53ijOc+edQJ9MGzW6SFvZBi0IzWM1pMZRAUwOv
 9gu9gh+9769KG5+oeVgrP27oAac6zFXeJeGjjzpq7/GJJRebL9J1kRrgmVOw7mNog0w7
 /fTpu4Wd3ctpX//8eUIle3mDD1EwDIBLCvu9IUUoqIoTdFYacMSYQEgHLiKcjQne3LdM
 yo7A==
X-Gm-Message-State: AJcUukflhRnJ0H/0H9+AgKZbLpaqDrMj96A8pXxBPQTYzTN03B+kozdG
 DGohc5TdMXHlTBMsJkyHQRu3GH1dnI10iCZ17vdCOg==
X-Google-Smtp-Source: ALg8bN7Zt15oTdh/04iq08N8IN0vyYu7i10byl+0WgPF5QJSa0QzavTsyex2nrnJhE4cip6lVIqoJK0xipouBFaKmWQ=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr33380556qts.144.1548197477728; 
 Tue, 22 Jan 2019 14:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20181210011504.122604-1-drinkcat@chromium.org>
 <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
 <20190111102155.in5rctq5krs4ewfi@8bytes.org>
In-Reply-To: <20190111102155.in5rctq5krs4ewfi@8bytes.org>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Wed, 23 Jan 2019 06:51:05 +0800
Message-ID: <CANMq1KCq7wEYXKLZGCZczZ_yQrmK=MkHbUXESKhHnx5G_CMNVg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
To: Andrew Morton <akpm@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_145119_471193_347729D1 
X-CRM114-Status: GOOD (  10.83  )
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
Cc: Michal Hocko <mhocko@suse.com>, Will Deacon <will.deacon@arm.com>,
 Levin Alexander <Alexander.Levin@microsoft.com>, linux-mm@kvack.org,
 Christoph Lameter <cl@linux.com>, Huaisheng Ye <yehs1@lenovo.com>,
 Joerg Roedel <joro@8bytes.org>, Matthew Wilcox <willy@infradead.org>,
 hch@infradead.org, Yong Wu <yong.wu@mediatek.com>,
 David Rientjes <rientjes@google.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Vlastimil Babka <vbabka@suse.cz>, Tomasz Figa <tfiga@google.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
 iommu@lists.linux-foundation.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew,

On Fri, Jan 11, 2019 at 6:21 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Wed, Jan 02, 2019 at 01:51:45PM +0800, Nicolas Boichat wrote:
> > Does anyone have any further comment on this series? If not, which
> > maintainer is going to pick this up? I assume Andrew Morton?
>
> Probably, yes. I don't like to carry the mm-changes in iommu-tree, so
> this should go through mm.

Gentle ping on this series, it seems like it's better if it goes
through your tree.

Series still applies cleanly on linux-next, but I'm happy to resend if
that helps.

Thanks!

> Regards,
>
>         Joerg

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
