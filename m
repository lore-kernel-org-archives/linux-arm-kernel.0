Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC302C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:54:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B389720684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DNC5MdPf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hNb+nyER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B389720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0VPOjl2/8CpRTHDm08RHF55Q/b3fQzCQK/HRS1ol7qg=; b=DNC5MdPfqdWcne
	CLekbm0WuGughKEEmZdf9a5K6A3z9m3SF3nJ/NX2YHFlywvtC8jODQy5+OoHe8bVYJiSUhU6MLLWc
	jOTK3N3zEL/pt6CGmBnmm3wxGXlOYJEZ6JY/LbHaoQlkAGrPQobgHiCFnXGUTw9JEHRBwT0a4/7OX
	BwJ02bMJk/IsLaMZ+xOM3Jk5B3Je2bLt3/zeJ4dpP1Xjgv/MUTpyvhG29i3XCeKGtarwjczx6S6ph
	U9NoDE1gT7Hcohm4teSjr+IQEW544Sh/4loxGwpQ/1qfX11EXDvE/M31klr/DxNLBf5AcuiMwFdBs
	dJ0CRRH0aMdqasRnkD+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQ55-0008D5-Pg; Mon, 25 Feb 2019 23:54:43 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQ52-0008BS-8C
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 23:54:41 +0000
Received: by mail-lf1-x144.google.com with SMTP id g12so8224045lfb.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 15:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4diYRZiwd25fbEdVyDO2DH/OYOgPzTAHtOFBF1MM6EM=;
 b=hNb+nyERabulX656yx8s65MX5UbbJzEe/H7wPy1UjLoKYV911/npz2gZrN9i6HQ8Cz
 HYFIPX0+s2kOXIfdgP66S3aH6m84Z56cuv5USYYtxALgZqfJMtHybUPk2b1wnfuhtg9V
 V8VMGlvLrSVK6iT0jWV+Fombr9DQggmH3BMfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4diYRZiwd25fbEdVyDO2DH/OYOgPzTAHtOFBF1MM6EM=;
 b=rlIre4MYotW2k3VWagracfc2bNVw91W+fp+9LD8qQDC37cGBkGNW05g5L331lbhYJd
 tYlAitHRgsJvkpQ/1ZFLUpwGJPF7BTgp8dEMXsPyr2qFnvIQhQUOb2zZvLk3g0k9ZWMp
 JYp4Rji8wc6WmU6rtW+tKccpa6a9lYpuEuQUemYyYh+Tx+/jTgVyFxpFbDzkj0s8Kwvr
 QsX4JJnRLpFFvq8o8RAje4d5kV/txaiQHPdPt1YV3v6EBmtYQhfrU94C1fWJUZSdW4f/
 VR7GLjtpN7e30ppEhRhK5AL498f/CIuyWzftr+gedU1jscr8JUzSc75xt/35HaT0zi74
 2x7A==
X-Gm-Message-State: AHQUAuaFAQnFLE38fYzsI0etZxEPoj5MTZuxZlNAqP9av9x8uVfQ5qb8
 NOnDUaNLW/Wx72v+tHA1lW1EqkkLzC8=
X-Google-Smtp-Source: AHgI3IZrU1h4ZiAVYh+aP4l+OXTkdDr4yOWryrpZSrhfUObkED2xhY7UgHhHvuA0I+ZJc/5vweEy7w==
X-Received: by 2002:a19:c301:: with SMTP id t1mr4342690lff.95.1551138877933;
 Mon, 25 Feb 2019 15:54:37 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45])
 by smtp.gmail.com with ESMTPSA id c86sm2569374ljf.28.2019.02.25.15.54.36
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 15:54:37 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id m11so8259029lfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 15:54:36 -0800 (PST)
X-Received: by 2002:a19:f607:: with SMTP id x7mr11740319lfe.47.1551138876234; 
 Mon, 25 Feb 2019 15:54:36 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-4-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-4-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:54:00 -0800
X-Gmail-Original-Message-ID: <CAE=gft4aJxXbrecehAhgYL0TANxdwukmdQtpiLgNkzCDAUO6Cg@mail.gmail.com>
Message-ID: <CAE=gft4aJxXbrecehAhgYL0TANxdwukmdQtpiLgNkzCDAUO6Cg@mail.gmail.com>
Subject: Re: [PATCH 03/13] iommu/mediatek: Add probe_defer for smi-larb
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_155440_284797_594EDCF7 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The iommu consumer should use device_link to connect with the
> smi-larb(supplier). then the smi-larb should run before the iommu
> consumer. Here we delay the iommu driver until the smi driver is
> ready, then all the iommu consumer always is after the smi driver.
>
> When there is no this patch, if some consumer drivers run before
> smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
> device_link_add, then device_links_driver_bound will use WARN_ON
> to complain that the link_status of supplier is not right.
>

I don't quite have enough knowledge of device links to figure out if
this is a) the right fix, b) a deficiency in the device_links code, or
c) neither.

Perhaps someone else could chime in on this one.
-Evan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
