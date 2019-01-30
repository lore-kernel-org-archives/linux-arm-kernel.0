Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD25C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:37:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EC4218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ixKnoUVU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SsQZ4kix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EC4218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jHcT7IgPcXUP2yMNOPouAdCtfPJ0Zd55tD7sAeZxi0s=; b=ixKnoUVUuswOc+
	LGBczrv/5ZNMZIdh86+LuNKAwQ/mt7c+rvgHkQOVIqm31kI8dEyiDAPS9JwTTYwIKX0vkhyp3ZmSs
	kMXE2xlCRWTKpmP8eMjmRw9nBMsVEKH+6iXx7P3P9lT8cABqQKYVfmN0wy16ERtt00zdwITlwj1SB
	SkVqnp+35HFKi9dA3Szh7shi/GBp7pKRLYD6QF+sP1tf9BHPi2wjuhf7uhtzBHgsq6ksTNTIAJvh6
	gB/ylGoEI62O4YkCaf1twdWqH7Wo5mKNs1Ub1nFeols3yS9SF0mbgHRHDc2bDYVSAyv6lxDt83zl+
	54lXeNs3WaIhixS4PUPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goujS-0000h6-Mk; Wed, 30 Jan 2019 18:37:06 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goujA-0000P6-KA
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:36:53 +0000
Received: by mail-lj1-x241.google.com with SMTP id c19-v6so468472lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AgDn3w54X8Bk6az8BYFqZSk6Fe3enX65M4AMBH8XrNw=;
 b=SsQZ4kixnoSxfSuaoIuMgqaZLJDcbUnwWAd/PcuSMGF2HaTTXdVhB+7tRqWfXYnEoF
 ZtqSQ+s+i840ezBg8svi6ps5YDISOnFZn1JQsQCAtxGsDEGYrLnEIeCo2IzVtb+V4a3R
 HYxWErI31o6esVYwtfKwmzdSLvgR0Vn2UKWLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AgDn3w54X8Bk6az8BYFqZSk6Fe3enX65M4AMBH8XrNw=;
 b=HVUPTkqsEvYw2cxArhcVQPeK/Og72SMVPYjX+UnCl6dQiR3dDNcVw5rEoSnIle+eXY
 oLM59xpRG4lQqaVUTqGS1RIRD9f1ZA3Ow8AG5jlQxyuSbin+ockX2jLevqz/DbTGiOO5
 kuOrwYdrrUt2yth5d1v9FACxiEUMH3zujfDYKIddG/Q3a4HYxfMhlpWwNj2Jdy5GFmr7
 Wx5oyXpLoWD8xx3qcrWTkrSNpZEw/htdQpzpvP1CUY+hcVBQDUhj8XeOh1e/EV9Pf1eg
 J4kkWDqGIcncS7ljtVpvNegxtDW6RTAuigYvBP++2BrDWYPvHnQgooUmWk+uHpiLGwxx
 /bOA==
X-Gm-Message-State: AHQUAuZNK+HMAxnOwAC3B7WsQfI2W33i+x2aYthtAfUHVlTW1utuVg0R
 fwRKlzq4jm7J4Y3wYGH9KmjMLelivmU=
X-Google-Smtp-Source: AHgI3IaSm+HwccoB907u8tmFFhbBuDxQbefcd8XcqFIX5g7wQrNvYlBsoQrKL8rzPNOQMnT5Ab0foA==
X-Received: by 2002:a2e:a289:: with SMTP id k9-v6mr635722lja.24.1548873406952; 
 Wed, 30 Jan 2019 10:36:46 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com.
 [209.85.167.42])
 by smtp.gmail.com with ESMTPSA id a11sm415934lff.68.2019.01.30.10.36.46
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 10:36:46 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id b20so369761lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:36:46 -0800 (PST)
X-Received: by 2002:a19:8c1b:: with SMTP id o27mr23773604lfd.90.1548872984375; 
 Wed, 30 Jan 2019 10:29:44 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
 <1546314952-15990-8-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-8-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 Jan 2019 10:29:08 -0800
X-Gmail-Original-Message-ID: <CAE=gft7ZVjJH-9f=ryoiegkjt+=Tnig=DRhc0z_5j=O7v4dQxg@mail.gmail.com>
Message-ID: <CAE=gft7ZVjJH-9f=ryoiegkjt+=Tnig=DRhc0z_5j=O7v4dQxg@mail.gmail.com>
Subject: Re: [PATCH v5 07/20] iommu/mediatek: Add bclk can be supported
 optionally
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_103649_240034_89E706BB 
X-CRM114-Status: GOOD (  10.98  )
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
> In some SoCs, M4U doesn't have its "bclk", it will use the EMI
> clock instead which has always been enabled when entering kernel.
>
> This also is a preparing patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
