Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C460BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:25:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD5A20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X2wtSP3x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/bRv4dV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD5A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sUoEfhwv6876gGOoBgepkNBxEvI+fIi0EZK0IPDLr4Y=; b=X2wtSP3xOoP6eu
	9+5HjcCKBI0oqmW8hVd2/86kM4AaQywkPvjB0EAsyfJKGsZZBXeCMSSp+wQ7agnLMv0/2gYl7aVHz
	0RU2NBgAsSaTPgNlxGCDtfLlpvQipLZHguozACRT8Sq2WcC+n9FRmShEe6cd3iDuUHy07VLf35nMX
	nyiE29yz/Sx/dGPekXofvqwiPsYuuq5/JP7RBbCfdpCsySyEEGH8edUyvY8yVb4q2gjaNdzr9SJBT
	LDhXIQuhOBNpM4rxntEbOxkpjziwHSh/ymzcxzgDr416vyr1kuk92rhqpiKxSePoMgpeOEsSt4ezf
	OowtfTKOIlgjdQwDdGLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUmAW-0005ZS-GO; Thu, 06 Dec 2018 05:25:48 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUmAQ-0005YW-NI
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 05:25:47 +0000
Received: by mail-it1-x144.google.com with SMTP id c9so24040020itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 21:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TvJlEDqqd0kl7auh37IuRFvQbjHwkz0wJzn0om8j0qY=;
 b=p/bRv4dVdy4hioMO2mXeMNN6rZQee/yI3fH6aZfFHT7INIEzHvkrjGtFafTrqmr1+9
 m3Xyptf+RV+CcS0AhgcUJzE22+EhBg8g30Tyw0bds8LVdh9ToEUN8k6uID4D40s7OdMn
 04uyqnaEgIC4n///axqKfLykvywIkSy+HSM1egR6le3OM6e3r8Inr/uiok62grnv67wf
 mhivvfKfUnlYrcvsuIiwSUW6hJgocCZbnYukSQcnaS/3wxGYxJcYzfHvSqc5GtUn+nRE
 vKeZefq0I9d3wmLVJF5476aRhyWN1nggfY0gBss+L9bcIJDSjqjqF7nbWpKpW2bT/loz
 SqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TvJlEDqqd0kl7auh37IuRFvQbjHwkz0wJzn0om8j0qY=;
 b=VoWmtQn2zhpNq0Sl73iJ1vTGhA7Jc1+7A+ZpwKlMmQlzJVGMTpRi8tZ+pesusQK3Yv
 nw8hpVAVY9+OOox6hSe2H4rVbRc0FrnZ4dIdt4kKDDn3maB+UQVnRgimsFBa+9DIUYB4
 7ph0GM3wdrvvyTlL9JuEYN+GmFve4gyq43Day+vCG3vtVPNRMnLdgQz6RKHvvdIEfejG
 QcFLAEvsQzkHvXJarB3V0GVfz2sob5ee+Oe9UXwlV6Sul2kw+ylDRrctgs5zZjn2OaGG
 niEEuSZhZfeBsmyqvCbcBp5uv3oEv5AZiNxxPgFkxHwUY6mrnCywoitMLvQzWxkHjAc1
 rGag==
X-Gm-Message-State: AA+aEWb6jy1uputHP+dyZikQNGeMx2acuGlWZU75W2Zhvw1OI2tDgAsk
 4jXN+VmwUyXD2q/DDmWq2huE1h0C6INAUi+njl4=
X-Google-Smtp-Source: AFSGD/Uh63Cl0kP4bBXQ0SjSXuMkA+HsO5ka8QXCU0Uc3R5q4zKRpb3nRv8iLteEB0VvavmlH9HgSC6KwR4Uw5RsudE=
X-Received: by 2002:a02:7a58:: with SMTP id z24mr25472227jad.22.1544073930895; 
 Wed, 05 Dec 2018 21:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-20-robh@kernel.org>
In-Reply-To: <20181205195050.4759-20-robh@kernel.org>
From: Tomasz Figa <tomasz.figa@gmail.com>
Date: Wed, 5 Dec 2018 21:25:17 -0800
Message-ID: <CA+Ln22Gj=1PovdRT9HCun4vkZmHfGh2t6ouOTrFqSZHiNvK1Zw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Use of_node_name_eq for node name comparisons
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_212542_762321_D845F2F6 
X-CRM114-Status: GOOD (  13.44  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 "moderated list:SAMSUNG SOC CLOCK DRIVERS"
 <linux-samsung-soc@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MjAxOOW5tDEy5pyINeaXpSjmsLQpIDExOjUxIFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
Ogo+Cj4gQ29udmVydCBzdHJpbmcgY29tcGFyZXMgb2YgRFQgbm9kZSBuYW1lcyB0byB1c2Ugb2Zf
bm9kZV9uYW1lX2VxIGhlbHBlcgo+IGluc3RlYWQuIFRoaXMgcmVtb3ZlcyBkaXJlY3QgYWNjZXNz
IHRvIHRoZSBub2RlIG5hbWUgcG9pbnRlci4KPgo+IENjOiBUb21hc3ogRmlnYSA8dG9tYXN6LmZp
Z2FAZ21haWwuY29tPgo+IENjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+
Cj4gQ2M6IFN5bHdlc3RlciBOYXdyb2NraSA8cy5uYXdyb2NraUBzYW1zdW5nLmNvbT4KPiBDYzog
TGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPgo+IENjOiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzogbGludXgtc2Ftc3VuZy1zb2NAdmdlci5r
ZXJuZWwub3JnCj4gQ2M6IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnCj4gU2lnbmVkLW9mZi1i
eTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KPiAtLS0KPiAgZHJpdmVycy9waW5jdHJs
L3NhbXN1bmcvcGluY3RybC1zYW1zdW5nLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3Ry
bC9zYW1zdW5nL3BpbmN0cmwtc2Ftc3VuZy5jIGIvZHJpdmVycy9waW5jdHJsL3NhbXN1bmcvcGlu
Y3RybC1zYW1zdW5nLmMKPiBpbmRleCBlZTZlZTIzMzg2MDYuLmRlMDQ3N2JiNDY5ZCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3BpbmN0cmwvc2Ftc3VuZy9waW5jdHJsLXNhbXN1bmcuYwo+ICsrKyBi
L2RyaXZlcnMvcGluY3RybC9zYW1zdW5nL3BpbmN0cmwtc2Ftc3VuZy5jCj4gQEAgLTEwNzEsNyAr
MTA3MSw3IEBAIHNhbXN1bmdfcGluY3RybF9nZXRfc29jX2RhdGEoc3RydWN0IHNhbXN1bmdfcGlu
Y3RybF9kcnZfZGF0YSAqZCwKPiAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiAg
ICAgICAgICAgICAgICAgYmFuayA9IGQtPnBpbl9iYW5rczsKPiAgICAgICAgICAgICAgICAgZm9y
IChpID0gMDsgaSA8IGQtPm5yX2JhbmtzOyArK2ksICsrYmFuaykgewo+IC0gICAgICAgICAgICAg
ICAgICAgICAgIGlmICghc3RyY21wKGJhbmstPm5hbWUsIG5wLT5uYW1lKSkgewo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChvZl9ub2RlX25hbWVfZXEobnAsIGJhbmstPm5hbWUpKSB7Cj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBiYW5rLT5vZl9ub2RlID0gbnA7Cj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgICAgICAgICAgICAg
ICAgICB9Cj4gLS0KPiAyLjE5LjEKPgoKUmV2aWV3ZWQtYnk6IFRvbWFzeiBGaWdhIDx0b21hc3ou
ZmlnYUBnbWFpbC5jb20+CgpCZXN0IHJlZ2FyZHMsClRvbWFzegoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
