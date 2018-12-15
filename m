Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C2BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:23:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B4B206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 16:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E8DYydnr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxmV1vr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B4B206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UnJD0nyT9zEu3pzQGYxNd5Haf12ZgDaB+SFT24/j8q8=; b=E8DYydnrRip7IZ
	j2HZRfbnCAJUg1KJLKr4Q1wM6dKZNgqYxPryz/f7m04A8BOojMSE7A7Qa0jXMkyX6vjl+A+ZdKbVW
	6mvyLkPFe+P01cV522IIhg4mOqKXkI9WQlxrH0guenTZToWec4+LKElhGk3ry0A0mX3Rwf9cK1PEM
	8tN/XZ7ZRcvgW1hwUwWA0ThAfC3Zx0P6eRECsCHObsJRaGlRKW1wx+XmfLqvi1DsSotNIrwAPULcN
	c4AGWqphinpwiBsaQuiCyYCfy7i7nrDMnPH6+lsODWzEAZQ6geMS9bDO8USMP89/otUC3GFPKugCQ
	O69VnVlah1yH1Ev/RHXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYCjH-000467-Ik; Sat, 15 Dec 2018 16:23:51 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYCjC-00044n-OH; Sat, 15 Dec 2018 16:23:49 +0000
Received: by mail-pg1-x542.google.com with SMTP id n2so4112440pgm.3;
 Sat, 15 Dec 2018 08:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XEm2PpBIQgpJh9GL6682ebASDp09765BQCtLbhH+b1Y=;
 b=qxmV1vr3BMNbwNfeFATWXws7cjf9CqjjxdJzFEmnlYcMqVa6N3JWmON78A6GvusAWf
 BjnTR8JXrrV42UNZEFas+90miyBrln1P7GkzsEmeJN3tCMQKl6oI2nrJ0Ew1+H8gHmlU
 48pmfkFwrLoib/NEPt3af6o/C32E1RJXU4YkYkOGpENLGUBrExhpc/VSq9/EPTH85Qvg
 Gjeo3BzK7u8n7pcQg3S2AqW8GC08FlYj2c4VFIXJ6rg1PgozjARYsYEPojiyle2brxj6
 qb6IzSWhOCe1u29DCNe169HWanLB95lDQvg9KWpUR133ayMeMyRN0GSZjw8kGISOUPKd
 ZngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=XEm2PpBIQgpJh9GL6682ebASDp09765BQCtLbhH+b1Y=;
 b=Ud0mk1qpvdJdwaEE+n3EUR4HT3QbXHwXZTaezcRJOQCqw03DIxeWDmo8N3GyQ5w3R2
 iURt0xvDnRxLm1pzX6uDvy39qIM1oHk1ujDgex4XOHJhjH7lzDvDvJykKjP74P0PYeYE
 Gq3P9OTZx/BQVkKAhKcToptW1CqiJ/Zm/HBUd2lY+V/VAbTK3XRqJNvFu3yVHdF/IAUp
 0I9c2D96JDOG1jjO8ZTOeUeXGGpZBAQ44NhDnnq76b/FwqTjSCpBgzslEO3ses00VXCM
 vX32iMDkvc/cc6bAk6NTDXVOdI+t7+w+NEu8Q8yo8hmYY7bY9WY46YJPkw50Nk4/HgHC
 vOfA==
X-Gm-Message-State: AA+aEWYAPUcnWML4SUxfKdGdtdw+EX1Fkfs/ikP6uw4PfUXS4CkyV0BV
 hd8kWzaWSQCmlr4QxSy/L1k=
X-Google-Smtp-Source: AFSGD/XfUPrWsHO376KJp2m+hT3VAujWA0Nnp1hEK/3b91dMyxJZQFoyXHdaNNu1JzA/pWEtthtZzQ==
X-Received: by 2002:a63:f710:: with SMTP id x16mr6568257pgh.322.1544891015157; 
 Sat, 15 Dec 2018 08:23:35 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id r6sm19873893pgk.91.2018.12.15.08.23.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 15 Dec 2018 08:23:34 -0800 (PST)
Date: Sat, 15 Dec 2018 08:23:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: dt-bindings: watchdog: update bindings for MT7629 SoC
Message-ID: <20181215162332.GA30762@roeck-us.net>
References: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_082346_790382_A7D5B788 
X-CRM114-Status: GOOD (  14.01  )
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
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 07, 2018 at 03:10:36PM +0800, Ryder Lee wrote:
> This updates dt-binding documentation for MT7629 SoC
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index 859dee1..8682d6a 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -8,6 +8,7 @@ Required properties:
>  	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
>  	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
>  	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
> +	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
>  
>  - reg : Specifies base physical address and size of the registers.
>  

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
