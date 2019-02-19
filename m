Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FEEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:31:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFC421738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YeEPN+h4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yz4riTNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFC421738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9Zem68f7hCW4k+04XAEv6+EnqtDGiUIkH0JgS7tsfcQ=; b=YeEPN+h4iF7a1W
	lRDQaemQ5Sz61Qzprb9iT19sElEdEONXpG3mh/cQtUCLJtxES5LRd6TDaHASG8StRQzJO15gb53xq
	mpdEpDAS+UnUO3IUzFJHRT48A+37o9vIQEhxTwRqb0zljPKQ9R9/sXWYW3fLhKH70BOSXfP7Qdz3Y
	SiJdOX0WMIzrJ/uwD+USSZgPtpim8S2GUCydD9ek5v9P1w04+9Xoh25LGlx7Cu8n47K93RiNP3Y+N
	lMjIgTxJG70jz+/L/C20atHrkK2A2BUp5NwYZv9ThpXdF0NI91Y5NzE/Bi9xm21RvVodM+sVmx3Gs
	lvJraVWsVGBvI7dEy36g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwErH-0004wo-Vh; Tue, 19 Feb 2019 23:31:27 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwErD-0004tw-7A
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 23:31:26 +0000
Received: by mail-lj1-x243.google.com with SMTP id f24-v6so19151180ljk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WO1ho7JCnpG79Vmw76pV30lk4sOfvZriBKEmXw9hSIo=;
 b=Yz4riTNSMSuXCOJjngAXOWHTXCPdN2xSlXdZ3eQ/yNF82u0hxWbe13xDIlReoe+i2/
 NcQD/TYX3aRBJL2yauZIg9A9YM0TgoxscrYABuEhDWJFFH+SxmIHp3ouqirs/x2xJ2M9
 oJXRwYrWVGdIEjPhYUjtjGIu/IWfOVcHZJ/HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WO1ho7JCnpG79Vmw76pV30lk4sOfvZriBKEmXw9hSIo=;
 b=h1g1PqualzOw+xzmA51DVEW1JxpFlVxoF+MK3x84nYDG3cbc+ebBx1k5MxjyfxNQ75
 hkfT5S6+fGX20LbESF/GjRAa00kNp6X0cMv5yW3A4a0fdxs6lb3ldzKP25riKxuJZ0m0
 RzWg6cdZs8agh7C+mXdvfcIyDvFPs0HK6mTYTnpsHje8cO+Nb4qpxn1TVL5QN/v23rSc
 Ts+LW1KdmPzv1D5Hbqd9QRs3/0WeBtRfLtdN5c0GwEyP/X7Yk3uIh+Vszlt08wqoUGJz
 uUIe+LTV2Kh1CLD2/5UZATqPyo00vL50Cz1MQDy8jyn/0XWEpEIMCiqFKuTmZjQ66UXc
 kLzw==
X-Gm-Message-State: AHQUAubsJTZtipDzUECMHcMjQTbDkIPpD35safGX3EXCxEaaH5WXaD07
 aP7Qq2o0BGQghsLd0EHthisOj3+/pLo=
X-Google-Smtp-Source: AHgI3IZHvoUjelFlr8uCtL1dY/icno6NBUjgAlOD8xuT7DKqhWKQPZsaTdpqUDrLYjkYIlfT8pA6qw==
X-Received: by 2002:a2e:9e93:: with SMTP id
 f19-v6mr19023325ljk.122.1550619081178; 
 Tue, 19 Feb 2019 15:31:21 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com.
 [209.85.208.175])
 by smtp.gmail.com with ESMTPSA id x3sm1574485lfa.82.2019.02.19.15.31.20
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 15:31:20 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id g11-v6so19162319ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 15:31:20 -0800 (PST)
X-Received: by 2002:a2e:9f0b:: with SMTP id u11mr19711923ljk.64.1550619079667; 
 Tue, 19 Feb 2019 15:31:19 -0800 (PST)
MIME-Version: 1.0
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
 <1550394300-17420-11-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1550394300-17420-11-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Tue, 19 Feb 2019 15:30:43 -0800
X-Gmail-Original-Message-ID: <CAE=gft6urwBfjLPjF29UooMbZTVA5h7fLgEmtajsLi5zYoaVUg@mail.gmail.com>
Message-ID: <CAE=gft6urwBfjLPjF29UooMbZTVA5h7fLgEmtajsLi5zYoaVUg@mail.gmail.com>
Subject: Re: [PATCH v6 10/22] iommu/mediatek: Move reset_axi into plat_data
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_153123_258790_20FB387D 
X-CRM114-Status: GOOD (  12.91  )
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
 srv_heupstream@mediatek.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 17, 2019 at 1:08 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In mt8173 and mt8183, 0x48 is REG_MMU_STANDARD_AXI_MODE while it is
> REG_MMU_CTRL in the other SoCs, and the bits meaning is completely
> different with the REG_MMU_STANDARD_AXI_MODE.
>
> This patch moves this property to plat_data, it's also a preparing
> patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
