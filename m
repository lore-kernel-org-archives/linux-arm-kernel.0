Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C786C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:29:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133D22087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SLMUWWEG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TJvwOn6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133D22087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wovjTN4UCEvrMnH6niXlUo7dgtWtGPm/tMgEeJbUmwQ=; b=SLMUWWEG3JiALK
	R+eAgvj0w/EMmoVG6xkvnRxV8zRrOovRz230LHahTXGoHeH4tEqTRCp4lO753ZuV0086/2itZ+3HL
	vA3dyYMGx6IOMDU2rHX9OPEPrJ1JExJj2183Cc/4hiYfVbcT951KAgpbNDtgYvArZn4mtzQy4WIp2
	2G7c3Uq2kYe4SAKTh9td2yCQvJarONpYyi2R/wIAs2QVJ0r21b9O00rH51OyZNJ4K3w8/WHYrdJHJ
	QZFd/sf4v/T36h1Bw2okeQeCmLK4Ihd1t/ldyooXggxbqkyhZBz7bs13Rw9i44bN0wAFSZw7X13Qu
	Rsn+aJE1UQ506808CC7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goubq-0004Ll-2U; Wed, 30 Jan 2019 18:29:14 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goubm-0004Kg-Aw
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:29:11 +0000
Received: by mail-lj1-x242.google.com with SMTP id c19-v6so448352lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lcw5vt9zbl++2RXOENtvs4XQX4dr/6bQWVR0Pe9YBiI=;
 b=TJvwOn6QwSVGUiDeb09oklzogw6mAA0r+OL2c9ehh3L//6bdR3mD03hcoKP1ausY9r
 46Iu8d4YSJIzjEPla7bDxNqxFGy+/Matc4dXOkm/riEjy0+6VPYb5AfyN95joo/dNZ1n
 Lu4gCpPgrKOiE1Zb7SSLvEjp3sEHx25BMSDKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lcw5vt9zbl++2RXOENtvs4XQX4dr/6bQWVR0Pe9YBiI=;
 b=CFGm0N+R3VNbqrCLwP2kP5wuIHUS9SvuB24HZ9nuYRkS8GzUB6inBgBXuLaCh4rNxs
 H4mbN59LpZXzZcEbUqiW6nodBUP5KsxV9yJgutEPX0o9QHpVAuGUIwPW0cPx8tHCUTYA
 JsYyBPBJoVsVPevURje7w7bp+YZV+4w4nGyBNm1K0gEtqQR28qz/R3A1TE3QrZ0xTSBZ
 xWFO7yC9yKIg369WCYO0LAKFMq5cJVBiheb/DzFcTk7gyLC2iNGIANIxp7mgkQWoapah
 jyerwNKDigHgYLEgDbzLerlBOhYnunr3cPWOuQ+tnuEIaG6WMYbPCfqGJmxH1pdciOi1
 +46w==
X-Gm-Message-State: AHQUAuaEc4MlEdrAGN3mAKegpkWDFjXVafsZtEr1zlvnMTkYkQzZiclY
 37WIsgQHk7+GBENtIr7SKUFeOpfSNUY=
X-Google-Smtp-Source: AHgI3Ib7HXzGYNW5LjnGNUn2FYSDOECSdR2Z+i4ygI3hjwkV2Vz8WyuDblz5YFWaaksFQiQ4nq0ywQ==
X-Received: by 2002:a2e:6c16:: with SMTP id
 h22-v6mr7464663ljc.180.1548872947919; 
 Wed, 30 Jan 2019 10:29:07 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182])
 by smtp.gmail.com with ESMTPSA id c133sm455621lfc.45.2019.01.30.10.29.07
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 10:29:07 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id v1-v6so484359ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:29:07 -0800 (PST)
X-Received: by 2002:a2e:7e04:: with SMTP id
 z4-v6mr26439768ljc.97.1548872946625; 
 Wed, 30 Jan 2019 10:29:06 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-6-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-6-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:28:30 -0800
X-Gmail-Original-Message-ID: <CAE=gft6KiXmP2Dm8ksnATUcy8Mhnfo8wL=SVpwGZrC0M1CoxpA@mail.gmail.com>
Message-ID: <CAE=gft6KiXmP2Dm8ksnATUcy8Mhnfo8wL=SVpwGZrC0M1CoxpA@mail.gmail.com>
Subject: Re: [PATCH v5 05/20] iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and
 iopte_to_paddr helpers
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_102910_372463_4DAF0F96 
X-CRM114-Status: UNSURE (   9.61  )
X-CRM114-Notice: Please train this message.
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

On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Add two helper functions: paddr_to_iopte and iopte_to_paddr.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
