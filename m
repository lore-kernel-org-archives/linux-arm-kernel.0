Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B9BC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:46:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5840F2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HCamlVi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5840F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HOu7qr62D2HX3HA5ToClygo+qtkXr7hVpI96cUmYn44=; b=HCamlVi0lqI00F
	WV/WgtqGX1acD6bibp0zMup2xue6loN7vzL2990LrYV710qOWJgOUeardzPWOqCjeA35/Z6jgHhQp
	UFUYEEANbk61QT74zvA+S7/1b61iXIslpAFa8aDY5CvEOZoun9D6pI2DLOZPRzKfVV5UvVgCxrcjY
	65AzibfgsElv3fkTGfHqKJ+341X9H/bBhBbdH6GHgjbvgTo0BOWTSfY8L86uAW1EJjsy1K+RrKNld
	CY4vQklQJJpM5XZXkzJbFoEwRtcSZ0fuf8lw3vgfrv3EvYOZ8S4DJO5lZwqj6IgLFkHPss1HiOjNv
	Zw+PU9CrbrsdcyI9e3Tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWqms-0006QJ-Cf; Tue, 11 Dec 2018 22:45:58 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWqmg-0006GY-3l; Tue, 11 Dec 2018 22:45:47 +0000
Received: by mail-ot1-f65.google.com with SMTP id v23so15763224otk.9;
 Tue, 11 Dec 2018 14:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0dWTg9ooH5/ZUcwb3VJnMt5qfYKp8zo1y2roSzqTnGQ=;
 b=bUB1OsLk1ZHTvDPyzmh5MlCMwVBwezQnvXhIoWOlvoYBF5rz79ar8cTA2X7GZ3vgkJ
 eZk1yt6tSGKc7YjJZI/WDWEK+H9V9in1ma1MNAbXjPUeqPi752pL2ZWx4q7nsXWH7Nvr
 WxaH0R9eADlLSD27AqI4V6T03rj/KqcvCWcdvWT82xPSk/5zo1OjnwF+N39WGGUDcIN/
 HNlxGwd/R3KGpEU6F/TmxLT2EYgttDZM3BUDb9TYAtiF7lT9JtHORlwKuw14JCO3Vbat
 mqjjmIwwvq5+2F3yEct6FL52GzVVFoay7wu7gYnkVK/roKDgZXOh07JrEQabtY644TWz
 L1nw==
X-Gm-Message-State: AA+aEWYUSvQi5I4fDGb4DjP3B4XWeYVXEfgCDQJ5ZMSMIPOMG+F8+EST
 xrBz9U3OIYiX8aN6YkUHAQ==
X-Google-Smtp-Source: AFSGD/XIAd2psJdg54TVpUi7izp5QbMc23Yd8erug8cvQCInN8z0PY3sv7m4eSv0jJE1VP8ZaHf/6A==
X-Received: by 2002:a9d:871:: with SMTP id 104mr12521641oty.189.1544568335008; 
 Tue, 11 Dec 2018 14:45:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 102sm8782727otj.65.2018.12.11.14.45.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 14:45:34 -0800 (PST)
Date: Tue, 11 Dec 2018 16:45:33 -0600
From: Rob Herring <robh@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [RESEND PATCH 1/4] dt-bindings: mtd: mtk-quadspi: update
 bindings for MT7629 SoC
Message-ID: <20181211224533.GA2363@bogus>
References: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <235ade9c5cda19fb0c9356913e3f56ad86600f59.1543472168.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_144546_156239_629954DA 
X-CRM114-Status: GOOD (  10.25  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 29 Nov 2018 14:29:53 +0800, Ryder Lee wrote:
> This updates bindings for the MT7629 SPI-NOR controller.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mtd/mtk-quadspi.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
