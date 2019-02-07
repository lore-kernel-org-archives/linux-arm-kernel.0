Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933C1C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:08:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6095E217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CxjrctAC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K4LnwqpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6095E217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wvmywUCN3E/+dK784WQ2JP4wbpRa/+xbFxL4LrQnPvY=; b=CxjrctACzG0seI
	lFt48nAxkVbhxK8q0dRQnPUCLlsmsMd5Y58uXqW2p8W4/2LhBzC6rylCMa61U/F88ahGAcMl0E2YD
	HPkxAyqXoD54z6ZXApQ7c4l+k8fdSmkt9Yu6ulVYXJLpgaNrR3BstBOyqQUtUaBQsZjwUiZSKaJxr
	Cl6aM0DvF09lBXcx0F9EjoYzYfYQ//fj/Iy00msyZ82MuBeiwui8y3EsSxmT3QT++tklKr+uuvi8L
	FfmscH5wb26/Wu2Xu17DGiEMAT0M4MCjuqFA6sLA7hb2j8+MtQ88cyqvYvxwcN1g82J/jxmPC1HQX
	qnyu0O92y+y6Ii4CORGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gra3H-0003Z5-Cd; Thu, 07 Feb 2019 03:08:35 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gra3E-0003YU-Nj
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 03:08:33 +0000
Received: by mail-pf1-x441.google.com with SMTP id w73so4104872pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 19:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=bjV0pff0+Yorv72/l3DDEcnxgGGPgV5xTdNHYgPwYFE=;
 b=K4LnwqpL6tzwKU4ZPpvlqSm1yFcsKqzT2cDka9owHlzN2RqWzelCEYr3m3paVrufpg
 F4a81ac7cUy6Bk1fJJJ7uZQO2EdEV0BoMEtbhcI6HMq5s0UWw5XRLxtWaG5+9y/mIFUv
 k8kOsBDxa4kklUgf9EZRSQPWL1aHNgapHz79+dSmgn2/3s8ZoxUadWhbW7lgOtleaq/f
 OqJBEY4D0u2WA+rGjP3VTMxmfZbb4wugWu6acBXvUwuWhFrUFsx+z5QosEvH9MbqP7PG
 41gNNaZxvFk7tHMf/Kt2EaKA0k4TyMVMs6KEtnm2WtUZn5Mvevwz8hJ9snrN/IYT7KbZ
 UFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=bjV0pff0+Yorv72/l3DDEcnxgGGPgV5xTdNHYgPwYFE=;
 b=mXunx4X1uDY9/c8aPXV9Ts4fYwNvoBOKk9tC6uF9OGaZhYk4/DrUiEym32j7zcG1Ut
 vVKjbUgtBvur2JQnWmPyCae5f21SA30N7yo0FFJWHELI7YfOYA4SBF7M08HJfLa64SQD
 E4db73jgqsx/UfwTUHTKSW6aifLZQwoQPY+9wL0bA6/DeVnZiwVMNzlQ4mm9UYb23lwK
 YqZ5hsmpxwry4K/+kbdaGhRDGjGCIm3LRxlyQ/3ox/eCsLLWbhL2BwXzl4tsO+/BwnTu
 NDSY5o9tOPtRKlsDRrz9CwPOFi1WiMN0ocUYwJ2dq5TtrTlGY/e5MxflBVQqUkhu9IhM
 hj0w==
X-Gm-Message-State: AHQUAuZj+9y2QP8sBdbxS6xMynKYcG9UBsEwaZn/1fr/BmA1wEq8FQZt
 L+KLEvFtO68pw4TpLLO5jAwBGA==
X-Google-Smtp-Source: AHgI3IagxwSg3I87aQnZ4KoOTdbI3Nt3Ewl+l409hzNH/tn8WUnTA+wOxbRVBd3r3RZLtGbv/J9dOA==
X-Received: by 2002:a62:1e87:: with SMTP id
 e129mr13798221pfe.221.1549508911915; 
 Wed, 06 Feb 2019 19:08:31 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
 by smtp.googlemail.com with ESMTPSA id a10sm9303427pfi.138.2019.02.06.19.08.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 19:08:31 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3] dt-bindings: reset: meson: add g12a bindings
In-Reply-To: <20190201125003.25022-1-jbrunet@baylibre.com>
References: <20190201125003.25022-1-jbrunet@baylibre.com>
Date: Wed, 06 Feb 2019 19:08:30 -0800
Message-ID: <7h8sysi9ch.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_190832_791714_1D99818A 
X-CRM114-Status: UNSURE (   6.97  )
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add device tree bindings for the reset controller of g12a SoC family.
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
