Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DC2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:09:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE3420879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SWmFQWzv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gbbeTV77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE3420879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5K5E4B2sTh6JbCeCsThzXDlZKkiWW+j7cHv8PqlXOuA=; b=SWmFQWzv6Pzc7z
	pJ6N1S9D04xSTT/r4pjR4K5JzHR3ZACZYcxRd3VZq1G3vYPVFeiwhVbqDAloBEd7m2cF1kphtsReh
	f8HiRo/8G+dCe2nMdDSlx65qDRv8pytaK5UiYZXzaxY4FuqrejKmgXzkYtbaObwawtDlLqhTCGyMm
	smEMREBxM6FCSnzLUXLori5DRxDDJKUzsTmMvT5e4z1fbn0UY8SoknHHAQGxVtYBswXbnHNNjKiDX
	DwQdKFRQnkAeNu0BUPKFoNFSzav2KZmkXQH8WKza3Qv/K8lJTo9H+nMcndeaFfh6f7SAfh3olLCN3
	U2me5ZHzk4tVXIiMaOVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUagL-0005HW-1M; Wed, 05 Dec 2018 17:09:53 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUagH-0005Gf-9K
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 17:09:50 +0000
Received: by mail-pf1-x441.google.com with SMTP id c123so10328883pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
 bh=HdIHSdWTFt3eFj0/ZApUX56Z/3w9BZvgVJif9koRvLU=;
 b=gbbeTV77bR8vlqTWidilXQWi8XbeNdlyu2q25sNUROsjU9SjbY5WLX3txSRKWNB0Of
 v9wMrYZ5n3SBnNFMyNGvNq9ZykeuVc5S/YH95WwhJIFUCMthu0Nsn3PP0NXH9Oicdu3x
 jB6J5Dn88X+qaU/GHOVa9Pe6M52H1BNIjDTeU1/oB40Iq5/iv6WYNZzqOSlBYhzm1FSA
 4CsyaaQs9VH0gXkZCHpKK7PZliKZWVhQYP0lK0iLuM9UYkvVgC0srELd0Okbu9gQ4pun
 McpOtt5TDHl5nBZtSUxXVZ+XNQAJIohb8ANfxA3neVEhrXAnDTQaHBp+lWgmwhqoNtuK
 eKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=HdIHSdWTFt3eFj0/ZApUX56Z/3w9BZvgVJif9koRvLU=;
 b=uaTgNDqonz8L7VSgoSG9EMUxOHUFFRbZ8CdxRVVOG5L90/PkAwWjxeUAZcttPFx/9W
 NCmCHS3yQnKSGYG+AbQLUwoM1G0GWrUVCR+u0NMEEY7U2ZD7cybK3T/SyvM1c5KHxxZO
 m/aijkAcamE4giw3E0OhpjieeYBdAOxSHgn+FaFMc89lCZSet7iagXUmzKOt7pb++s9e
 JU2IGfTEJ5gZPnEFOyLK9k6XJIq8B6TIWtBfoIlLVV9hSc+By+BjE7s10Hig+BEAY2Jq
 3WkpSTJqe5Nl9RvqDS3rGEtqTdkUuoSFQm0xRLi9+WyPKGQMV14rajDTFpuQ+cA5jlDA
 qaJw==
X-Gm-Message-State: AA+aEWb1cSy06ABeqMSxKv8n76BJAfEk4GQH5Gat5cU4xf9xjiCiiVZG
 wYw1L7q00bM0t+1Nt3Ao9w4KGw==
X-Google-Smtp-Source: AFSGD/X4KxgWev8Fizi5DfhHXkb0/69KlU2n3jL6Kx3FRQbWGoavWFE+cylRIe01+aDhxMu59eqmCQ==
X-Received: by 2002:a63:f201:: with SMTP id v1mr19764096pgh.232.1544029778103; 
 Wed, 05 Dec 2018 09:09:38 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 d80sm71295445pfm.146.2018.12.05.09.09.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 09:09:37 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: meson-axg: Enable GPIO interrupt controller
In-Reply-To: <809e8f9945d55cb8b9583f0a50f502c6922b35fe.camel@baylibre.com>
References: <20181201164301.17274-1-ccaione@baylibre.com>
 <809e8f9945d55cb8b9583f0a50f502c6922b35fe.camel@baylibre.com>
Date: Wed, 05 Dec 2018 09:09:36 -0800
Message-ID: <7hh8frlx2n.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_090949_423506_A3E9DC28 
X-CRM114-Status: UNSURE (   8.57  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Sat, 2018-12-01 at 16:43 +0000, Carlo Caione wrote:
>> Enable the GPIO interrupt controller for the AXG SoCs.
>> 
>> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v4.21 with Jerome's tags (branch: v4.21/dt64)

Thanks,

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
