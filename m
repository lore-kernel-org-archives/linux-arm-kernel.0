Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5CFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEE420870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iHu2TK90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEE420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a0Ew7hQZ2MyOD2ZN/1blbQAODpBUqEfqxut+otKGsTQ=; b=iHu2TK90mAl4EA
	u8878CxBfNH2uH9rV2QVUP+6rM0htr/yRI+u2CkVywC8cJ3Nnj4/WfX/l1qtBnyTj5CcrdxWcb0E0
	csuWHgxlBLKGk2PMgK43hhjDN18LeSF02JThNT+JmtIlpTkL+sBnO/zzGpunJOoKur8hprvVflY8Q
	kxHo2N4KfdNWZnajbOEwgPuAyWJF5W3nZE1nM6qfwc+wI0puo10dF64ghN3Ot65THF4d+Pv0d/Gvt
	0kYj6TGsAa17dqpqwC20nZI0pNiJKzhJjO6H9mNmTxKauAlci13+uPAzvart7BtO65fHfaDdBOGql
	LyIAOLpQp40Tm0Mmopsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyCc-0000h8-IP; Fri, 11 Jan 2019 14:54:30 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyCZ-0000gd-GE; Fri, 11 Jan 2019 14:54:29 +0000
Received: by mail-ot1-f65.google.com with SMTP id k98so13322177otk.3;
 Fri, 11 Jan 2019 06:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AxBTm/miHcpzTWrZ6oK4vYugnLB4OJ4qPCXeYxBcs9I=;
 b=Mv2WyFRYXgJz1hkmq4Uv//TofBqnJANyWTVsoZmzWdVJBgiIl6uPtId4mnJZ14mqHZ
 2J5V3t9E5vQYWrSneGFFtsTKhGGk5cfY7OFhcjx6lI4qB+oadS/AperYRRLCnW+lvxbj
 xqHyRF2412Zswpco6mAGY46BLlKAi+4bsptVI9HWEs6pDXaUbG2ooduuMRpj6MGamJQZ
 1FPYO8NoQE5F0fjiRGutQnUVThyukZew1jJgWQcKvou+Av/ZeHVGzd+ZEuOBGWnQZn9w
 G5AVwImOXp/sgv6hZhx0k/oA+r5//fSitrIHWFsu43nSMPA9HoK7shOxWUYFlNZEGJR3
 OShw==
X-Gm-Message-State: AJcUukc4sqTyP3lAs7ltGp5ugg3ppQdOI7mC2geJkB2SXWDaaRcxj3h9
 LNrqelWhQJ2B1vz+Mvu4Lg==
X-Google-Smtp-Source: ALg8bN7V0LmbKUmrNricS3ji6iXmjFN22dEwo5X+zsrnshlMFJPUSzs6OlleaePLksTmKgNq0jURtg==
X-Received: by 2002:a9d:4b0f:: with SMTP id q15mr5119413otf.201.1547218465767; 
 Fri, 11 Jan 2019 06:54:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d3sm35589465otb.79.2019.01.11.06.54.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 06:54:24 -0800 (PST)
Date: Fri, 11 Jan 2019 08:54:24 -0600
From: Rob Herring <robh@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 3/7] drm: rockchip: vop: add rk3066 vop definitions
Message-ID: <20190111145424.GA21604@bogus>
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <20181229133318.18128-4-jbx6244@gmail.com>
 <154632658.xpTMZOjgxT@phil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154632658.xpTMZOjgxT@phil>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_065427_584301_A2E22A2A 
X-CRM114-Status: GOOD (  14.72  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org,
 Johan Jonker <jbx6244@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 30, 2018 at 06:22:00PM +0100, Heiko Stuebner wrote:
> Hi Johan,
> 
> Am Samstag, 29. Dezember 2018, 14:33:14 CET schrieb Johan Jonker:
> > From: Mark Yao <mark.yao@rock-chips.com>
> > 
> > This patch adds the rk3066 VOP definitions.
> > 
> > The VOP or LCD Controller serves as interface between
> > framebuffer memory and a display device (LCD panel or TV set).
> > 
> > This SOC has two symmetrical LCDC's for a dual panel application.
> > 
> > A LCDC has 5 display layers.
> > Only 3 are used here.
> > 
> > - Video layer 0 (Win0)
> > - Video layer 1 (Win1)
> > - OSD layer     (Win2)
> 
> Patch itself looks good, we'll need to wait a bit to give Rob a chance
> to look at the (simple) dt-binding change and I'll drop the paragraph
> about the display layers when applying.

Don't wait on me for simple oneline compatible additions.

Acked-by: Rob Herring <robh@kernel.org>

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
