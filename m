Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048E1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:28:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FDD2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qAu+EtSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FDD2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qd80EBmQa0ojtv/5ADSPXMBwdRvBer4UfqBD+dyhl88=; b=qAu+EtSI/Tm+Gc
	AFfaAFOZwuYBDPiBR9aCeGsCkT2eWTvWkpavR56m/PloJPTWzPSB3sMgXpLF+jTBGoI/F1VNgzm8O
	qwvMuqJ1i56sFv5Ao80RJBYK9Hn1+KpkLOvUNyBNZhlSCStaLWV6FvgTqHtruGnla114ZAWrhMtUN
	kK7etU/9uhoE02PM+9w267B7CdW8wLZIBG2wccwCftAyv2e6Er6ZqhKFs7SuYO5QY914Gk/XxoBSF
	i8wbZBgXhJDtzZc1Z4cK6ksqynMJtf3OCuX89GTMpBwTPADWyiCjY82JP1ls3GgQ2/PoMyc5/i38J
	kN0uINVmkqbnGh2mTZQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggbW4-0000r3-Tb; Mon, 07 Jan 2019 20:28:56 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggbW1-0000qM-8z
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 20:28:54 +0000
Received: by mail-ed1-f67.google.com with SMTP id h15so2153094edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 12:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=5FUUy9QxOAvNRrn5yLSmlniZufkJ2IedBnmLzKvsHUY=;
 b=R9eL9nuq/qapcW4sttQ0Coj3wfCwxxb6h29mnPGSszEW4tLBJ2TkiVCZzjnAkxMPLG
 N75MNsBYGbAgcTBjEYYqlHeySDnTgkDV30lbcF4YJY/hZ17LX4yjRRCeT85b+0wQLUPS
 Z8QlN7hIxeswRclEMaxut9GBpNpW1YQD6khwCqOgQQZjj43apsXUg9xV9kRugMMYYxf3
 lEYstMqr0pr3ExvtG2kUU5WzlMPOYwFZ9KuRNxTqm4AkzqHvJ2iQAzBBFf2evdrM2y0z
 QmWVEyrpYzjItYjJPhGpCOqtInMpTq2GBYdyq/bVXbqlv8jC1s6U/yfbaxudxatY7kLr
 bpGQ==
X-Gm-Message-State: AA+aEWaxsPD9Bz4J3ezpiJFsM4xl8TDdXAlm0Ys2TAI/VZhEZZxyc0JV
 4DGF4/X0/zSXXEbDAHY2NKc=
X-Google-Smtp-Source: AFSGD/W/pQSSnN79S40lIwsXQcy9RiqXDfJgZX5EruRIrCPU/s6LCQFeGElVQD/Qi2Ap5W9rz8iJHg==
X-Received: by 2002:a17:906:828b:: with SMTP id
 h11-v6mr47378031ejx.115.1546892931594; 
 Mon, 07 Jan 2019 12:28:51 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
 by smtp.googlemail.com with ESMTPSA id v20sm31461549edm.29.2019.01.07.12.28.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 07 Jan 2019 12:28:50 -0800 (PST)
Date: Mon, 7 Jan 2019 21:28:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 1/6] ARM: dts: s5pv210: Use correct fimd variant
Message-ID: <20190107202848.GA21920@kozik-lap>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228161819.18931-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228161819.18931-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_122853_314792_6DB8F4C1 
X-CRM114-Status: GOOD (  10.27  )
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

T24gRnJpLCBEZWMgMjgsIDIwMTggYXQgMDU6MTg6MTRQTSArMDEwMCwgUGF3ZcWCIENobWllbCB3
cm90ZToKPiBTaW5jZSB3ZSBoYXZlIHNlcGFyYXRlIGNvbXBhdGlibGUgZm9yIG91ciBTT0MsCj4g
bGV0J3MgdXNlIGl0IHJhdGhlciB1c2luZyBvbmUgZnJvbSBleHlub3M0MjEwLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4K
PiAtLS0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC5kdHNpIHwgMiArLQoKVGhhbmtzLCBh
cHBsaWVkLgoKQmVzdCByZWdhcmRzLApLcnp5c3p0b2YKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
