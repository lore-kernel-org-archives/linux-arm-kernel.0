Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4E5C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:54:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4884E2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qQa+qNND";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MimCXGW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4884E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VEf6Yv0uCeLfu+OrXEb29nNVDJ5jO0Ky7WH+MHUrG5o=; b=qQa+qNNDCVK9s/
	7mt4qfB+03b+9SQaVrlAufxAnK8TtZh0MxUIbbbmlPamagBSYuIr6fQed6GeUJ9J3rKW7HGAs3QCA
	57dFxHwfe/BTB5QjCBpJ59CrOLnyKwxGslw1D3ba2oQvXpjsCA9sTMzXKjXu4OznAOM5Cl3XPiaxr
	ha82lkq35NHqXptuSROIsMMvTRRK1X16zGoZB9dpYxgb5qp+8iDU81MQjUuXitnmXYGvWSCL6h4Lt
	jzlJA3IwVlqhHRktWx19q28Rm0DTwFzwOD39Oenj29ywToyNSH+DzLUOvtJHjBFfOIGF2EFzrmVNl
	ceCSTiHBVwEKP9eC9yiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gralf-0003NX-IE; Thu, 07 Feb 2019 03:54:27 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grala-0003MF-K3
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 03:54:24 +0000
Received: by mail-pg1-x542.google.com with SMTP id g189so3918979pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 19:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=dzXRzhNeAJaEDDw2bDa7ru6nYvSSdEcmyz9Bav3YOBU=;
 b=MimCXGW0Zu7FeWTSBR9d1/YF9E7VPhv36ttKdTrQaqDHEbHFsoysktz5aHAAUGMXYJ
 /2/oDvpnfjxcMKyQKw14aSa6rKxUbQedk2Wjk/J4PARs2y5LdKQM0yYN7T9lah6SaCqc
 Y6/EqGrAmZPBka4qczbSkvPOOXVK2vc28xDSBMQn+5Klx/p+fPtXsmOj6pMLN/RtgdLu
 4utt1CO3kzBRchYjNnnbd8LSe2et8Ye+jbM5KnsWbxxet6I4NkZqr9/Uax1YjoQCtNrM
 ZNsfXL7W4m5lqeknrJP/oXvjZym6zfla0cgjpvKR/4Oa0m6rSvRXmuL/0Y74tsr65l7F
 ErMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=dzXRzhNeAJaEDDw2bDa7ru6nYvSSdEcmyz9Bav3YOBU=;
 b=uWOoyMIwQOHdAOKxOafTsOCxrMJ6QpfnEaITRpNXR1jxaKPsU1Eviouy3xC4h9ALhB
 lGQPydjUu0RwVRpd9jOpUbqVgS4fRQOR9I0rR+EW9Yc3tVK62EASddqCIvSXV/gxU8Al
 AmnrKyu7TJkwA2zF5Fbmm0SB+JNI339jXX9laLjuM9bAjkGh/D4rXTGUc2AkiOZK6vOA
 TmrtTYpVOCadx8ptyQBE6LIRW5TNBBTBrtOFJO7UaWAjM2Vgg4cpRoWdVdUk+StSNl8S
 Magz9fggIIhXy6sZyTHswoKt4rHF+0uE5Z/bJNc7MnJ5/YxUxiCWsUQtls/ylnHuki02
 VfQg==
X-Gm-Message-State: AHQUAuZJ1DYCoX/E73+07HE7JqDZBk3Hw2mfJ1msT8HVFy6aOEmCtnkP
 UMpaU4ST4cwatJh9YL8U6Wrhxg==
X-Google-Smtp-Source: AHgI3IZlRGwVgh2CPfMev7H+GxPlpUtK2D9w1DvuR8UVW0yabk9i1txXo7EmDTCJQLHIK4+xYu4BSg==
X-Received: by 2002:a65:60c5:: with SMTP id r5mr8369118pgv.427.1549511662023; 
 Wed, 06 Feb 2019 19:54:22 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
 by smtp.googlemail.com with ESMTPSA id l70sm10201707pgd.20.2019.02.06.19.54.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 19:54:21 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 0/2] ARM: meson: do not select COMMON_CLK_AMLOGIC
In-Reply-To: <20190128182252.32589-1-jbrunet@baylibre.com>
References: <20190128182252.32589-1-jbrunet@baylibre.com>
Date: Wed, 06 Feb 2019 19:54:19 -0800
Message-ID: <7himxwgsno.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_195422_659989_7451C085 
X-CRM114-Status: UNSURE (   8.92  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The patchset remove the selection of CONFIG_COMMON_CLK_AMLOGIC.
> This CONFIG symbol:
> * Is already selected by controller driver which requires it.
> * Is being removed by this changeset [0]
>
> Whether or not series [0] is merged, selecting CONFIG_COMMON_CLK_AMLOGIC
> is not necessary and it is safe to remove it.
>
> [0]: https://lkml.kernel.org/r/20190128180430.28689-1-jbrunet@baylibre.com

Queued for v5.1 (branch: v5.1/soc)

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
