Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7DBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:20:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB0A2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a011V/sH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB0A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vhEo5yC7qwqAUnUoIMmDLxManhaOtR4jbYcqM5WAh4Q=; b=a011V/sHE+zDZr
	t/y2OdizVvZrllvd7QO0hjY/YFqM1oDxWut7zdpA05Vh3gnSlFoSJZeAQaLwza9rCRX+s7pqUWrY7
	RtVXTe1hwgeSrtgv7sDlUzaBqoeffvkmAapk+HNxE0KMBKLLgUFDsrwLrIRdbb/0HcyfJakINehG6
	d3xo/BViLIjxOjVCaqh/x+QVycazq9VEcFoDH9E63j//gQKAVJGyG0kWaTahus6N0jmEUn757qmKa
	rLlQKZw6gzqiM5Fd6P+t9zudrefS1iCk0eC6kypcGcTSxU8njojJAtZqjorCVfkP45kX8euR6L+uQ
	ztYHw700xKnq/Of8ODSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggaSA-0004y5-JR; Mon, 07 Jan 2019 19:20:50 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggaS7-0004w3-3Y
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 19:20:48 +0000
Received: by mail-ed1-f67.google.com with SMTP id g22so1959182edr.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 11:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Nl0Z9EafKqQqrKQci4F+vWW4MhrhhwLk1NoFDyQP8pE=;
 b=UKfxqCjG3gLNl3iyse3eNpAJSz86zG842wqCeSvFSbj9lWW/C9tec8BK26CWQ0eHZr
 ibH5a4Cge1I+AZUqB/cDxtMulJjUeZ7hU05PDMcn9xpW0v9psPz+xOWhasK0J+ubPwOU
 sH+BHdi+7xRfPM0bjZFs0QIK39FBEY87jXUMY3Ac6Cq1gCmuIiBA5QuVPPbqTJbSHK0i
 y975LmodqfnpdOljCy+DNkEsprJIX5fX4vLNW1h9lYdbN6VcsbSsqMg7boWySIHrA5iS
 nRKLM4UzvCrbAkk9thqJdxwtQzy9Dl0mH8sITspmjONIVTBTvP1vfJEUli/Ms6NTkkf3
 OwbA==
X-Gm-Message-State: AA+aEWY+kMVAXTGHCgO5XC+jLn2vCTgrAiKJD2fYTXxqv79ci9PmbCPL
 OWASrcbUsmI7AEMqbmJ+k76+FVXhJfU=
X-Google-Smtp-Source: AFSGD/UWXXYdSPjrWpbPYJ4eV30SIQWA/9R7v+ETW3S5KZ6FgWgby8fC9zyE+kLB1wn16OKOd4S44w==
X-Received: by 2002:a50:b7ad:: with SMTP id h42mr57616117ede.210.1546888845683; 
 Mon, 07 Jan 2019 11:20:45 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
 by smtp.googlemail.com with ESMTPSA id f6sm36926894ede.53.2019.01.07.11.20.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 07 Jan 2019 11:20:45 -0800 (PST)
Date: Mon, 7 Jan 2019 20:20:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 3/6] ARM: dts: s5pv210: fascinate4g: Remove hardcoded
 bootargs
Message-ID: <20190107192042.GB3313@kozik-lap>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228161819.18931-4-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228161819.18931-4-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_112047_192756_9F73CEA5 
X-CRM114-Status: UNSURE (   9.84  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, xc-racer2@live.ca, linux@armlinux.org.uk,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBEZWMgMjgsIDIwMTggYXQgMDU6MTg6MTZQTSArMDEwMCwgUGF3ZcWCIENobWllbCB3
cm90ZToKPiBTaW5jZSB3ZSBoYXZlIHVib290IChmbGFzaGVkIGluIHBsYWNlIG9mIHN0b2NrIGtl
cm5lbCksCj4gaXQncyBub3QgbmVlZGVkIGFueW1vcmUgdG8gaGFyZGNvZGUgYm9vdGFyZ3MuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21h
aWwuY29tPgo+IC0tLQo+ICBhcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLWZhc2NpbmF0ZTRnLmR0
cyB8IDcgLS0tLS0tLQoKVGhhbmtzLCBhcHBsaWVkIChzcXVhc2hlZCB3aXRoIHByZXZpb3VzIG9u
ZSkuCgpCZXN0IHJlZ2FyZHMsCktyenlzenRvZgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
