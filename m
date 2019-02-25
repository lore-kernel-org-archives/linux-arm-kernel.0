Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C40C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:39:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC08F2146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C6HcY8by"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC08F2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=giNZHRJeRgksHblUUE3Z+fzRSRquyGdzew9zQRx0ox8=; b=C6HcY8by50taTV
	pR2hGZF7galy7UVOguyoDWAL/F1Hu0U0K3r7UzuDMNCJl+lY3H/QQ9Ar3x7H/5J1SvVjxodNKTcJC
	TsASHR+ojz8CYQxq3xzfoZJdCTZlLoY9Qw2T4q/Dz9yjxJFbFPMRlzE87xItfwPX1yB7/Z2bkEAUx
	PfZLf2LwZ3Pq5Ggl9RTPeousXDgclvBXUbwQsX1/yWrRsLf6RYHWBDQ1T95ikkSzPU5U/+ism+PBP
	yqRdhU0Hr5HoBHFBkQzDoVZG6TDSdn4yvOZKjsaEyunuutCYWdx8prjRpVPtV7l91D++EaAUbK0FN
	t9rDv/VjQzGWEuRvfThg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyHQ3-00079l-OM; Mon, 25 Feb 2019 14:39:47 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyHQ0-000790-Qy; Mon, 25 Feb 2019 14:39:46 +0000
Received: by mail-ot1-f67.google.com with SMTP id i5so7965674oto.9;
 Mon, 25 Feb 2019 06:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fVnoIzx6swz+tWUg/1uvpeP6seGZ7cfS1owZ9VHY8Ls=;
 b=tE1SJp02NTO+R7DEf1Thsi/p2v1IR6f1cuereFzuUqoiVTijkiCgU6cRjIbBRUPXBh
 7dM4xfSC6ZQiCvsQrrCjETs2xfOEruwrOevLY0F8GGA91qwz7k7pzIeUit03H7OdvsI4
 F+0MVFpqsN4SUrOpGLGioksz85dWbOE5MlghBg5an/zmybcTbMKZv/UW+kmSmKzXZgyw
 GxRvDDvkMsqe8OxRT+bAYyltD1gKeuA31QcD91ssUKhsJJDnVRprZeoaZmEjDZC5Pco3
 TnA9wiC2GSiuy+nZcDxrCeJ0u8/cY02eSyLtEOTkDOLEFioadzM9kpFZmUJ8sQhYO6XM
 2Ujw==
X-Gm-Message-State: AHQUAua/9B1EOLS50xkAxHBysTvTdypeyMyYNr277fJFcSIueLWnLCDq
 l736qEaHy4SDAH9TEAjGAw==
X-Google-Smtp-Source: AHgI3Ia4F5ncFC5rCjglsRliCrAlehxLCwP1DaDoQr/3pb3wy7JHIe26hXEFCUyHr9/rSjFtnl6roQ==
X-Received: by 2002:a9d:610a:: with SMTP id i10mr12260969otj.186.1551105583736; 
 Mon, 25 Feb 2019 06:39:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 3sm1346433ots.75.2019.02.25.06.39.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 06:39:43 -0800 (PST)
Date: Mon, 25 Feb 2019 08:39:42 -0600
From: Rob Herring <robh@kernel.org>
To: Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: Re: [PATCH 02/10] dt-binding: gce: add gce header file for mt8183
Message-ID: <20190225143942.GA13388@bogus>
References: <1548747128-60136-1-git-send-email-bibby.hsieh@mediatek.com>
 <1548747128-60136-3-git-send-email-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548747128-60136-3-git-send-email-bibby.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_063944_867431_FE8CD309 
X-CRM114-Status: GOOD (  11.52  )
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
Cc: Daniel Kurtz <djkurtz@chromium.org>,
 Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Bibby Hsieh <bibby.hsieh@mediatek.com>, YT Shen <yt.shen@mediatek.com>,
 Frederic Chen <Frederic.Chen@mediatek.com>, devicetree@vger.kernel.org,
 kendrick.hsu@mediatek.com, Sascha Hauer <kernel@pengutronix.de>,
 Daoyuan Huang <daoyuan.huang@mediatek.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Houlong Wei <houlong.wei@mediatek.com>,
 CK HU <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
 ginny.chen@mediatek.com, Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 29 Jan 2019 15:31:59 +0800, Bibby Hsieh wrote:
> Add documentation for the mt8183 gce.
> 
> Add gce header file defined the gce hardware event,
> subsys number and constant for mt8183.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mtk-gce.txt        |   6 +-
>  include/dt-bindings/gce/mt8183-gce.h               | 177 +++++++++++++++++++++
>  2 files changed, 180 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/gce/mt8183-gce.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
