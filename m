Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755A1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:41:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3114A2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pE2iSqLX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5bfLM8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3114A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bIh+XckvOQGg2MVhZ41qpOlZijGez6vZgYAp0ly+RvA=; b=pE2iSqLXXwgg2O
	0WDDCA7rl+VolG6CwVtyhAnLEfkyYaSp8KP8IRcTj2s2Q+I91fCB8PL7OGLjAx5e6y2LuRViZ9/Ud
	x4+6vqcEJUDsnAPrrC9AxQE0Hrb62D2S3Hs0bwS6GOAO8KwLw1EaDcUfyyIracZKPXnzQpbR8IQHy
	hUXH98pEjkcje1X6HBZqk7gd7/fpv/Fj44TM4QIA31u/N7UStnRwn9K4zNdNvr3daO7DspM7hlfvn
	Y1Uj+xFoZBuLtjkDbjYgnDOQFpMica2+yssWYexE0YwYXBSldlAhGZXxL69FD41amPklnSu9eZONe
	BX0llvxU5woUt8Iutsuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVJBV-0003yi-Rn; Fri, 07 Dec 2018 16:41:01 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVJBS-0003xS-21
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 16:40:59 +0000
Received: by mail-wr1-x441.google.com with SMTP id r10so4373702wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 08:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=0S+N6XO0NSZ7wv+BOTf/5P2MlBdfSNlts/jfDT2XT2c=;
 b=X5bfLM8QiKBj9TElLojRnSNCiUBK8XJq8+wFn9ctJ5Geqh9Kwv+ABWskn6leZb7f4o
 g12RLlvZ04iaeNep6WyZvmcSFGLp3UCjVB8+jzpNKyrpOIrXjBNXjYke7Sq2FTdL/9li
 G603o4ktQAxLpuxFGPBTkMMz8scFAPRXq1zso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=0S+N6XO0NSZ7wv+BOTf/5P2MlBdfSNlts/jfDT2XT2c=;
 b=etCbB39stKBmhtkSpx2u4bf6ULDBLHG3UXLB//ld5qgfVzOE1pnoe//pg4+ehMrsc1
 5/msFtbKZv0MKnCfqoc3HxjnHPMgTLzzgifXIZFL5WuGGqMnASrktSMsxdyn8SP5Pq2s
 rNHPyiAimQv9Tc4TU1bE4qxDll0ics7CohOtYitvAgGdcSoV44PoGb8IBTOjjiVr9QsK
 EUzOyV583YuhCfP6Ru/Vcj6JVpcndURHwGpw1neheSbvAP6QatsWzWUh5FzDjQ4RM+BF
 SPfeSe9hO0ZeY3Q4PhcKxlel0zs1wEVUCEGfML9trCUtyolBkce/9J5jRuYbNO1mfqOF
 dpxw==
X-Gm-Message-State: AA+aEWaxKDwJQjEYOWxTpbi9qfk7SJNHPARwEfMNy1vzT/AvjGb4RFPX
 JtRYROGBnGjyJRlvrUni3f1sAQ==
X-Google-Smtp-Source: AFSGD/VAD7+Ju+1VzEyiCIkPqo+/RTkAGef0t5aan2oLb6iPlPnYt34baXM5DgCZlXYGQmjMsF2dZw==
X-Received: by 2002:adf:9467:: with SMTP id 94mr2361113wrq.305.1544200846726; 
 Fri, 07 Dec 2018 08:40:46 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com.
 [109.155.202.221])
 by smtp.gmail.com with ESMTPSA id e16sm5365720wrn.72.2018.12.07.08.40.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 08:40:46 -0800 (PST)
Date: Fri, 7 Dec 2018 16:40:44 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Oskari Lemmela <oskari@lemmela.net>
Subject: Re: [PATCH v6 7/8] mfd: axp20x: Add AC power supply cell for AXP813
Message-ID: <20181207164044.GJ26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-8-oskari@lemmela.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181120175211.3913-8-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_084058_093662_D9683264 
X-CRM114-Status: GOOD (  10.80  )
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
 Quentin Schulz <quentin.schulz@bootlin.com>, linux-pm@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMCBOb3YgMjAxOCwgT3NrYXJpIExlbW1lbGEgd3JvdGU6Cgo+IEFzIGF4cDIweC1h
Yy1wb3dlci1zdXBwbHkgbm93IHN1cHBvcnRzIEFYUDgxMywgYWRkIGEgY2VsbCBmb3IgaXQuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogT3NrYXJpIExlbW1lbGEgPG9za2FyaUBsZW1tZWxhLm5ldD4KPiBS
ZXZpZXdlZC1ieTogUXVlbnRpbiBTY2h1bHogPHF1ZW50aW4uc2NodWx6QGJvb3RsaW4uY29tPgo+
IFJldmlld2VkLWJ5OiBDaGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+Cj4gVGVzdGVkLWJ5OiBW
YXNpbHkgS2hvcnV6aGljayA8YW5hcnNvdWxAZ21haWwuY29tPgo+IC0tLQo+ICBkcml2ZXJzL21m
ZC9heHAyMHguYyB8IDUgKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoK
QXBwbGllZCwgdGhhbmtzLgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpMaW5hcm8gU2Vydmlj
ZXMgVGVjaG5pY2FsIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9y
IEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
