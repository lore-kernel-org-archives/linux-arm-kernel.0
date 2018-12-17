Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F69C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:45:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41776214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gOj/iZuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41776214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Msr4nx8/4EgIF8otnDFsz1HJABz6Jz8UAZC9FQ4j8iA=; b=gOj/iZuJPE/Sv8
	TzBK3ySsh1aLf6JHYvMOtc8RPzOoWk8zKUoIkiGqg+/INFRFa/isH77Umhddr1DSGQEPiRG67yIr5
	M9Bga50HPe2PLs8ING4tGG/0OYehnFUOQbDlBrgVE2IyPn1KlVO8UL9uYrYWYr50NNGavx8K7XKIm
	HKxEEE63U8MGaDJkL3IDCIxGBdLDNNAphL4fPmu292gG77ChVz+gkZ6aIW3Bj8nkNREaLtfqNNkWK
	hadg6QG+1AY1BZ9tID5WhVZm0E3TPZse+kEgG4wl2Bwj5Z6ehaTlfqol67H/Sk8b8goP93DRleS03
	mwTKBaAOQ9ny4lLPLCiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ0hw-0004cD-BZ; Mon, 17 Dec 2018 21:45:48 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ0ht-0004aX-Kc
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 21:45:46 +0000
Received: by mail-ot1-f66.google.com with SMTP id i20so13710052otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 13:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=X3ip8IJBhBv6nCzaznwb9fZCS9wFPkUtMlMCsE9VYpU=;
 b=jTd0xdEPq8JC995BW11shfNDnKhV/tE7inrA4BU+5qYtBej1QJD4mo5YSiOSny9WKa
 DD1fPjgzdSH/lzIakQ5/vcY/S8NY2z7cEYVH3ta7DnwtCif1MXAbyGqMF+0XFu9SFpvL
 TLD7OMMbS1fRiWe6Tgif7YIdKnvZYwZAOXJWO2WDZv5G9+PBjGqsCCdSUqk/Q7nM+b2R
 EruS5ussX/BEMdiqp9ypqQrM8C3eXRtwAOdpyDhn49VTxh68Z2F9/VGBDwshMZaQoH9K
 kAmHufnFbLvdBOypbj4OLmzuvM+L0teJskGYNWWhl+RGi6bhv+kuuFOpCGU/Ko5XRKt0
 Dh8g==
X-Gm-Message-State: AA+aEWZdHgvc9YzEcySRWnZs8F8DGvSnQyRIb6e57LkssI2B9rvrOWLE
 CvR/NCVkDdmF0TYXe4Tyaw==
X-Google-Smtp-Source: AFSGD/W9ew08t4qX4htADcCW+UJSbCcEHxzIsU4j+F3qhZK/fSXICiSam6leIAVAxRJrk2qqPx1yZA==
X-Received: by 2002:a9d:7285:: with SMTP id t5mr9470958otj.228.1545083134467; 
 Mon, 17 Dec 2018 13:45:34 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com.
 [70.114.214.127])
 by smtp.gmail.com with ESMTPSA id o2sm8069351otj.2.2018.12.17.13.45.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Dec 2018 13:45:33 -0800 (PST)
Date: Mon, 17 Dec 2018 15:45:33 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4 3/6] dt-bindings: ap806: document the thermal
 interrupt capabilities
Message-ID: <20181217214533.GA22171@bogus>
References: <20181212093645.14752-1-miquel.raynal@bootlin.com>
 <20181212093645.14752-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212093645.14752-4-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_134545_670023_CD51EF9F 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Eduardo Valentin <edubezval@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
 David Sniatkiwicz <davidsn@marvell.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 12 Dec 2018 10:36:42 +0100, Miquel Raynal wrote:
> The thermal IP can produce interrupts on overheat situation.
> Describe them.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/arm/marvell/ap806-system-controller.txt       | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
