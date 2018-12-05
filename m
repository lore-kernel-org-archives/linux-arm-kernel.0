Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAAEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:50:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A87D206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uv1OgMgG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d2YLNgZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A87D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e0necSdspxf/3G1MRpLGn4ECR2OqMMCflwDKgAdu63c=; b=uv1OgMgGZXv3As
	YhenDy/Wb3AlpqhT0e3qTYFDYh5lSRLnZhK5BO6CYMucrj1Vktvq5t12fE4UZuLDb+QIoJPaA2qcS
	QntSexPf027L4FADAO3wChkoMzTqUnYRgTqsht/txu4TeImhTaZdROAi9kMpmYjYWROMqdms1p4RH
	JIteNbPMgUU3VaITXet91veSmMJnXDHaOS+5755xXXUUdnIADWol+Sp7XM99XR7PYV6PJIT1POU9x
	OD/oArzckPoiePzW1y9QvaH1hxEsKZWeZ8uD2t0b0joxavxRqDnpEfteRENmjrly7Z980xgSO2tVu
	d2XATMJzAJtHm1lU6zIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUYVp-0003E0-6C; Wed, 05 Dec 2018 14:50:53 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUYVm-0003DF-6H
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 14:50:52 +0000
Received: by mail-wm1-x342.google.com with SMTP id f81so10728468wmd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 06:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:date:in-reply-to:references:user-agent
 :mime-version:content-transfer-encoding;
 bh=4EJRkB9Wt6wOzHmSHibiY7tYXFP2z+KuFu6wp2XHUxs=;
 b=d2YLNgZpvDaxpxHNFcSjCet9O1sp26Cc7VNcZjNQWd6rZoEgYh9+BDXsM9Qhlje8fk
 Pj3WabsBMopf6iYagXz5PE/ataFWpE40GaDz4h6480Ap5+7Rn2LVFn51hxtvJFY/DV/G
 lOiS3G9qqcpaeTbDdlVHAd1gWKWKj5aCtdWJQwKDETBmkAao0Ni2rw2zTXoBpB+EreMH
 pLmK4b+ocjnpAGmOAOUmBu25fGQ3aGwIzDFksirgk37Hy+lJg2wwWrk3yMrwT5DRGt0p
 Mukpq3S4Egwp8xXCOzjyAvdg4ISStLU57aNjyZdvK2I+xnWz/lpwAza05tjMPkmIEA7l
 ghXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=4EJRkB9Wt6wOzHmSHibiY7tYXFP2z+KuFu6wp2XHUxs=;
 b=ksOwhUnb7QEuhRQY+7bylEJKDbeGeikQNOg+2lUMvqUZCsPUN6QGzKmovz2lqj9eZ/
 qibPFH8eF3izuhRFRpWa9+km1eKRZ/zbDdrjShyXh7Bhi7qNWX4+XsB/M0ou6atsvrUv
 ljqH6cl/PR6qSDvbA3ci5SMugqc9mM+ZH0tPbJiEuSnRg6lEvwwmQhvKDbbC2dwOPh0r
 wU+CrqUbQjQnwaQVF9UHZ/KQJD6UiClDvEKfKLqQWe47z2+uq0OOkDXUqIpmR04htJdr
 JvpLc3YFYO4LbmIIaVliVTK9SYcwRs+LHu++e8Si/iFhgSYTObi6UrH16bs1RU/v3alz
 gUrg==
X-Gm-Message-State: AA+aEWb67Z3GTw+xGFeKfNeSoBACgc+MdMIqCVEU2PZzgARtISvLoO+i
 SvNHjQStEv2QREqhzk04S5gO1A==
X-Google-Smtp-Source: AFSGD/UDw5utdfFbYKvohR5I6dbOv7cxIYORvM0LvtdjDh4Kqmx+4idDFJ6reJZSIViW1xqIKQJPaA==
X-Received: by 2002:a1c:f71a:: with SMTP id v26mr13812333wmh.131.1544021436254; 
 Wed, 05 Dec 2018 06:50:36 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.gmail.com with ESMTPSA id
 a62sm11673725wmf.47.2018.12.05.06.50.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 06:50:35 -0800 (PST)
Message-ID: <809e8f9945d55cb8b9583f0a50f502c6922b35fe.camel@baylibre.com>
Subject: Re: [PATCH v2] arm64: dts: meson-axg: Enable GPIO interrupt controller
From: Jerome Brunet <jbrunet@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, 
 khilman@baylibre.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Date: Wed, 05 Dec 2018 15:50:31 +0100
In-Reply-To: <20181201164301.17274-1-ccaione@baylibre.com>
References: <20181201164301.17274-1-ccaione@baylibre.com>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_065050_262216_17B5952A 
X-CRM114-Status: UNSURE (   9.34  )
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

On Sat, 2018-12-01 at 16:43 +0000, Carlo Caione wrote:
> Enable the GPIO interrupt controller for the AXG SoCs.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Jerome Brunet <jbrunet@baylibre.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
