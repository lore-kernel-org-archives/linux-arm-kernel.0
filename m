Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6C5C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:33:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A69321738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TYao7h1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A69321738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=itOmYi5in/ZYbBxekije7vAByu/+1bjPAaFWhVxkpW0=; b=TYao7h1sR7b9rP
	vNzzAjAzPTVKYg5TgcYI2y/NDv5caO/RTAvaECBiUeARX0uD3xKJ0CCQmr7w8S4d3dFhUO4Ys1M0n
	dubN7SgN6+VBOY7nWh/3Gm1S4OpSPgzgJ6E3df1kB3M6G9j9adRj0yLB3Ww0ip39FVPOzS2WThJGo
	E9kAvTuCo4W72BS6ER9y6CWigEdPCTk6A5vHybMWonIbOsU5pwj2isnRXIYRebPoKI6i8/YfeB4+t
	lfd6PUoIZVNE/JaznUbH9kWjfWb+PQJDAEpwJCKXBkZjXpFPT9woYfPl/1YwNfWMo2oG1H5gYimqZ
	QeS+ToiTX5LZC0h6laCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvlrb-00041a-Vm; Mon, 18 Feb 2019 16:33:51 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvlrU-000404-8k; Mon, 18 Feb 2019 16:33:49 +0000
Received: by mail-ot1-f67.google.com with SMTP id b3so29252118otp.4;
 Mon, 18 Feb 2019 08:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/3OTtw+XimbN3zuGxZJlMD8HX9wbXSnJdqnMGNSEaO0=;
 b=ekvfVSKGrc0gF2SbhquN2u9dwxezKnTVj1T4ORhtylFLbWWZhQNqaXPSoBYGnGInIl
 o28lWLTVgPls5VyS6VWkYvRIZGuGct1N3ep2dkOy1k/BfTQgpy+kzxkuwNFdu6J7y39s
 J+I1lsHaOONjLMrHTn1gACdt/cjmBW4Q8KPkeIb9Sfy2W2vLo2UQNS6ji+7VVI42MZzn
 tli5NXXYllkin0D3QHvwFX1lEcqIxPhZLfbtCs+L7qbPuaQvzm9YIO/C4pqX0cxqKM2+
 /ikegJnrSew/fNu4sAefsbZakErCMMcaw31eD6Pok5DYnTKrAUt4CLI3cX8QPv429pa/
 oXaQ==
X-Gm-Message-State: AHQUAuZIPbeHiQcl27mY2eWSdjWdalcmhLIaNzWghKBI1lJwEbrvInKy
 m4ryATWtwxrqpzy7hItfHA==
X-Google-Smtp-Source: AHgI3Ia77PdVDQPtBsuUkPNc0UKt1rxr5mMlVLuVXmIc0fOQ927DI6NDVQ/XIZyfkht6kBngYUUVsw==
X-Received: by 2002:a9d:22a4:: with SMTP id y33mr3595921ota.218.1550507623523; 
 Mon, 18 Feb 2019 08:33:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m84sm867636oig.49.2019.02.18.08.33.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 08:33:42 -0800 (PST)
Date: Mon, 18 Feb 2019 10:33:42 -0600
From: Rob Herring <robh@kernel.org>
To: Erin Lo <erin.lo@mediatek.com>
Subject: Re: [PATCH v7 5/6] arm64: dts: mt8183: add pintcrl file
Message-ID: <20190218163342.GA12014@bogus>
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-6-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550210558-30516-6-git-send-email-erin.lo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_083348_158798_176FE6C1 
X-CRM114-Status: GOOD (  14.93  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>,
 linux-kernel@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
 mars.cheng@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Thomas Gleixner <tglx@linutronix.de>,
 eddie.huang@mediatek.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 02:02:37PM +0800, Erin Lo wrote:
> This patch adds pinctrl file for mt8183.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h | 1120 +++++++++++++++++++++++++
>  1 file changed, 1120 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h b/arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> new file mode 100644
> index 0000000..768e41e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> @@ -0,0 +1,1120 @@
> +// SPDX-License-Identifier: GPL-2.0

Run checkpatch. It will tell you that this should be /* */ comments.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
