Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E3FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:20:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14578206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gwdvNnPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14578206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IefgVmedptmna2SfWo+bAjCHdojXuAcA4rWHG7S6E7U=; b=gwdvNnPafdgO4b
	4bSgp60dxTR37f1Wzagm7sGXuYXszbMNwMCN9aP8ywRFB5gJW3zHTuDPRJSoTp1xLlCWL08TCdlk3
	YwAQfT6xdOmXlQl0lCYag2VA/VtDcAJ0gR1rVPS/CKBywSVUDRi7FihvHZxz0bKVMfH1Z4kSatCLL
	esQOQ489UHJdvYA9bQD7vPKskHRcUoS+iYh9pYBzrqNk6pPu8yqepXbCQvqMTt6jbYn81Q4BQ8rvS
	HyppyFCy5/Fu6wrAGze+MAqZgjfsHT8GmA0YLi5pC74LF2JyRVbdIoEbleqPyIEulhIiFn6kLfO13
	FTjoQ2JPueNrhAjvpceQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggaRu-0004iw-Vo; Mon, 07 Jan 2019 19:20:34 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggaRr-0004iK-NP
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 19:20:33 +0000
Received: by mail-ed1-f67.google.com with SMTP id h15so1980967edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 11:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=9OtQndmec6bQR1I6yUSMhLSXVuG78p4NcJxwO3xOt5c=;
 b=Zqy5etTWt4hvs7WKFasLbLaW6Cmiu66wkTdIOqWvbSFC4P0zQnni3bx1bs4b/nSCdE
 9H5iDvnuuSfT57r4wOHSv7MIDtyHcFSWm0R5bV0hJ+KBjgNQx35jxrttw54BWjOuJDqR
 qMpcFKyCOXGVBVf8Aohem8Gcp18lnLamh78gk2izFgdmv9MezAk2JerR97DW20C0P1Q1
 Qrp1cv4G6jLV8LcH5aLDEqh7Qg8k5G22I+0CK3NSiLkOpHUSQf7r3UdYMBkzRpMgX+n2
 n6ywkSbyONvb4nBcL8PLpc+CF2ZBjBgunJH1154b4thFrx00nKrNZdos/IlJTwpfgncn
 /JQg==
X-Gm-Message-State: AA+aEWbANePLUZLvIhRwNWMOdaPeSEolPQMInCq8Am8EZXa2TUdHLyKQ
 mBR9joNdfshWpdsJ/OJzOPI=
X-Google-Smtp-Source: AFSGD/VwN5WrwNZ7SC2N9eKCOO12rnO6kY7zq35N+Moi0rAbNdosYqVFzdzQnXgeAowuCZ0uy9ucCA==
X-Received: by 2002:a05:6402:796:: with SMTP id
 d22mr58406782edy.81.1546888829438; 
 Mon, 07 Jan 2019 11:20:29 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
 by smtp.googlemail.com with ESMTPSA id n29sm30613041edd.40.2019.01.07.11.20.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 07 Jan 2019 11:20:28 -0800 (PST)
Date: Mon, 7 Jan 2019 20:20:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 2/6] ARM: dts: s5pv210: galaxys: Remove hardcoded bootargs
Message-ID: <20190107192026.GA3313@kozik-lap>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228161819.18931-3-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228161819.18931-3-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_112031_790671_AE880A2D 
X-CRM114-Status: UNSURE (   9.93  )
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

T24gRnJpLCBEZWMgMjgsIDIwMTggYXQgMDU6MTg6MTVQTSArMDEwMCwgUGF3ZcWCIENobWllbCB3
cm90ZToKPiBTaW5jZSB3ZSBoYXZlIHVib290IChmbGFzaGVkIGluIHBsYWNlIG9mIHN0b2NrIGtl
cm5lbCksCj4gaXQncyBub3QgbmVlZGVkIGFueW1vcmUgdG8gaGFyZGNvZGUgYm9vdGFyZ3MuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21h
aWwuY29tPgo+IC0tLQo+ICBhcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLWdhbGF4eXMuZHRzIHwg
NyAtLS0tLS0tCgpUaGFua3MsIGFwcGxpZWQuCgpCZXN0IHJlZ2FyZHMsCktyenlzenRvZgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
