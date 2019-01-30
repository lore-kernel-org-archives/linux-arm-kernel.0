Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32022C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:20:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03DB20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VnEKB4gC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KpwpN3ZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03DB20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vu17oz9DFbJ6mlkzkWrUykdVJw0gYnKScOJgAWsKjqA=; b=VnEKB4gCe1lDgs
	c+GGMxdWd7XYSKL0NF0NhzLN4pfMC+VEafh2uaGSZ6Veo5uUPL114qZM9ZfcN8kD98MPAXuymHNdl
	7pn1EYC9QKFI9opYr2m//HEOHvKojX9nLREThbsLVeDE+oMTbI8P5OU6H9SeNs0jyj1OOR/iGOrzH
	18BxtdW+jtdMCnblAbJM+rrZ3dNR/px06liSCWtu1S0yagRnjfH1XAUELAvB5S3OBFDwBQJzJBsg2
	5V+zqzJyEey6xSvmU4rRTHwsj5+jbS6HEyv3jw3Oq6FJdrHiVDSUCntsiIDIA5JeK55auis1ijZM7
	0LeT2xokJvH6/JyWXnKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govPI-0003n1-3y; Wed, 30 Jan 2019 19:20:20 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govPE-0003ls-E4
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:20:17 +0000
Received: by mail-lj1-x244.google.com with SMTP id q2-v6so540008lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YN5U0FYrh6FkR0o1KHBgp086/PB+j1Y8dRv+wNG//Ag=;
 b=KpwpN3ZFQ4vbMUm9l7sXtcQy8j8YXcesm39ZIgfCoV3Sqfg9C3dlURztb0XmMmmabL
 Xk1Q2df3biijflUKXuQ4aQx9OOH4eJJFgNjkqtnBMj2crJIjHqtWFqc2wgfqY36s3ylZ
 Ao9FdNPWutaYb7NOX6tUeT9K9GxQBnSMPa1wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YN5U0FYrh6FkR0o1KHBgp086/PB+j1Y8dRv+wNG//Ag=;
 b=K6MHYooYltc88T/W6ArCQTab49h4WG/5hfwiy25Y67PJ/xxO/7Yf5TrAX8Pb8bQSs3
 E4gKjAvUm58S+htro61w87owlebIEWojiftzrMMgjqI+HvDk+E2j3MsC8xcyyIJAJMGd
 oLAkfS04Mx4mQ2LmAHkkg5SofTolZjzgTtOXFolahZQ/jHAGphcCK3E+WaYqw0MBcS2r
 tQGkbr7CDesYYqpmiJPvbVzsO2duqVi0ez388WwtJqAa58Cnsq5Hydgyevwle9v3jeE8
 O6QaysGlfx9k3QcHlbxVfhDwiDm9QlefZvNWvs4ce/wajEFzj+p6oy09xHnwFuY/miI7
 mvJw==
X-Gm-Message-State: AHQUAubrvLk0CoG3wbN2OY4exBSHejBMZKvpo0xJWEZwpEAFLgknE5Ap
 YHwt29ONyeDkjI2dLuDZpL+HnjpoAp0=
X-Google-Smtp-Source: AHgI3IaBfDDtPng5oqRQUrIMnhmn0a6/tsgn5Rf4GLknPIY9KgXOvgOAgUb6Bt85D8rSvcZOQQLh7A==
X-Received: by 2002:a2e:8006:: with SMTP id
 j6-v6mr3661023ljg.186.1548876014631; 
 Wed, 30 Jan 2019 11:20:14 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com.
 [209.85.208.174])
 by smtp.gmail.com with ESMTPSA id k3-v6sm417583lja.8.2019.01.30.11.20.12
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 11:20:13 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id t18-v6so592673ljd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:20:12 -0800 (PST)
X-Received: by 2002:a2e:7e04:: with SMTP id
 z4-v6mr26580031ljc.97.1548876011815; 
 Wed, 30 Jan 2019 11:20:11 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-19-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-19-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 11:11:59 -0800
X-Gmail-Original-Message-ID: <CAE=gft4xwk02tM9cgnLCZDpZgX3z9w8fjXfJxJ7HtzdOaCN7=g@mail.gmail.com>
Message-ID: <CAE=gft4xwk02tM9cgnLCZDpZgX3z9w8fjXfJxJ7HtzdOaCN7=g@mail.gmail.com>
Subject: Re: [PATCH v5 18/20] iommu/mediatek: Fix VLD_PA_RANGE register backup
 when suspend
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_112016_468389_243EF7DA 
X-CRM114-Status: GOOD (  10.51  )
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

On Mon, Dec 31, 2018 at 8:00 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The register VLD_PA_RNG(0x118) was forgot to backup while adding 4GB
> mode support for mt2712. this patch add it.
>
> Fixes: 30e2fccf9512 ("iommu/mediatek: Enlarge the validate PA range
> for 4GB mode")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
