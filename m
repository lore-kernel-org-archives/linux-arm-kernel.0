Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090C6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:43:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D1121906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TSJJecK+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHt0u4mO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D1121906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P0pTOA9M5S5zLfiYkUnFQfkrYZsbFI95hY/nxqGwmwM=; b=TSJJecK+PU8qBQ
	UgfnXPT5teJfoxxO1ofX8LzTnUq+QdwzJ9Eb5M3B5g24sPj3m4EIpPZ0u6FqrHeVPKAFBhkvHWP7f
	xgwvv4ew6iSpuyU6wY7KcftMnw5o2aXaIOJyxKzKqn8RcTlvFRCAR/BY0BuNRODJz0oyGbA6IhqYv
	nk34bL8jyCjKeA9UBlCO5hbWSiG+gNJCgDLaNLYeyR88FSZ8A4tn/J1dgAkiYN+F1tcm3wDmikmD/
	5iOIC7zc4hvkShP0qSacUBkw1D6zZvIWTUm3eIrRX6300VJpuZN+pgdV1GYS+UdfOvvB8BWKHLOTi
	ErO8VzZVkJRYu/4zuFvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaIGu-0000g3-17; Fri, 21 Dec 2018 10:43:12 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaIGm-0000PT-MM
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:43:10 +0000
Received: by mail-wr1-x442.google.com with SMTP id x10so4717682wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 02:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=mAtp5c+TuQv/n4xrRqKvadlhKP80qAdoimAqxu30Goc=;
 b=SHt0u4mO+p7IX3QDIjrQ1BEpmvC/mMwy85GdSmHyxMTkHa7LzA9mjwqPXWV0Shy8+N
 qcMrTaa5a7IoUbSc//IS7PeBsexFomtGgD9FuQA7ox486aMRN/EvIvINKHpZoz7b4Ygn
 TJVURg5wEAv2OzuNHPdGBapRe2LftOpKL0bsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=mAtp5c+TuQv/n4xrRqKvadlhKP80qAdoimAqxu30Goc=;
 b=kP3u6bR0bpvzSUPR8dLcsylI11ZgsvlufWBT9oNu7vt6i8fRNdThsuoTD+v/tE5KFa
 9r8ZRpPWaXsXduxEcPyeVnFHVdoL1n4XaQzJJKyuSCe9vgEP76ObvPGXuiHc2AEQuz1H
 FI71AqCsuA9ZZ4r9ItXZ7UBYLSeMa2pG70KGiMN0xsDbW0kyjK4xqVf5h4hGHe3lA3tV
 WSUyc3HWjzmxumOru+d2u6XO2j7UmhiRN7CLKLcBM1G5r20PdA+WR8W+MUSADJLZ9UGZ
 TSB/j2vI5F34FNYzSFABTTGNmZDDY267qX+n6ZB7zx/GJpOAUgnhMTH1pVRZvyK+4/c9
 EDlw==
X-Gm-Message-State: AJcUukdn67RaPGepJVuXcTP/Iy+S7tL5MQAFY2GOqReRckKUAIiyIIoB
 jICtgxca+2F+YFBdKxN3akhc5A==
X-Google-Smtp-Source: ALg8bN7v9Vw2+R3QXTA6qNCZlBDkZHF5FIKNgt6Db9t7Z78rXRg7A+Gwfaux6H/MRiHOwJu3RhvUqQ==
X-Received: by 2002:adf:f984:: with SMTP id f4mr2057888wrr.234.1545388973022; 
 Fri, 21 Dec 2018 02:42:53 -0800 (PST)
Received: from dell ([95.149.164.119])
 by smtp.gmail.com with ESMTPSA id q185sm13291719wmg.14.2018.12.21.02.42.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Dec 2018 02:42:52 -0800 (PST)
Date: Fri, 21 Dec 2018 10:42:50 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH v4 3/8] mfd: stmpe: preparations for STMPE ADC driver
Message-ID: <20181221104250.GM13248@dell>
References: <20181212130649.15146-1-dev@pschenker.ch>
 <20181212130649.15146-3-dev@pschenker.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212130649.15146-3-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_024304_728177_612572D2 
X-CRM114-Status: GOOD (  20.12  )
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
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, marcel.ziswiler@toradex.com,
 linux-kernel@vger.kernel.org, stefan@agner.ch,
 Philippe Schenker <philippe.schenker@toradex.com>, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Max Krummenacher <max.krummenacher@toradex.com>,
 linux-stm32@st-md-mailman.stormreply.com, jic23@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCAxMiBEZWMgMjAxOCwgUGhpbGlwcGUgU2NoZW5rZXIgd3JvdGU6Cgo+IFRoaXMgcHJl
cGFyZXMgdGhlIE1GRCBmb3IgdGhlIFNUTVBFIEFEQyBkcml2ZXIuIFRoaXMgY29tbWl0IGludHJv
ZHVjZXMKPiBkZXZpY2V0cmVlIHNldHRpbmdzIHRoYXQgYXJlIHVzZWQgYnkgdGhlIEFEQyBhbmQg
YWRkcyBhbiBpbml0IGZ1bmN0aW9uLgo+IENvbW1vbiBBREMgc2V0dGluZ3MgdGhhdCBhcmUgc2hh
cmVkIHdpdGggdGhlIHRvdWNoc2NyZWVuIGRyaXZlciBjYW4gbm93Cj4gcmVzaWRlIGluIHRoZSBv
dmVybHlpbmcgTUZELgo+IAo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBBZ25lciA8c3RlZmFuQGFn
bmVyLmNoPgo+IFNpZ25lZC1vZmYtYnk6IE1heCBLcnVtbWVuYWNoZXIgPG1heC5rcnVtbWVuYWNo
ZXJAdG9yYWRleC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxp
cHBlLnNjaGVua2VyQHRvcmFkZXguY29tPgo+IC0tLQo+IAo+IEkgbW92ZWQgbm93IGFsbCBlbmFi
bGVzIGJhY2sgdG8gdGhlIHN1YmRldmljZXMuIFRoZSBkaXNhYmxlIG9mIEFEQwo+IGJsb2NrIGlz
IG5vdyBkb25lIGF0IHJlbW92ZSBvZiBtZmQuIEkga25vdyB0aGlzIGlzIG5vdCBwYXJ0aWN1bGFy
bHkKPiByaWdodCwgdGhlIHJpZ2h0IHdheSB0byBkbyB0aGlzIHdvdWxkIGJlIHdpdGggYSByZWZj
b3VudGVyLgo+IAo+IEJ1dCBJIGRvbid0IGtub3cgaG93IHRvIGltcGxlbWVudCB0aGlzIGluIHRo
aXMgZHJpdmVyLiBJZiBzb21lb25lIGRvZXMKPiBub3QgYWdyZWUgdG8gZGlzYWJsZSBhZGMgaW4g
cmVtb3ZlIG9mIG1mZCwgcGxlYXNlIGdpdmUgbWUgc29tZSBhZHZpY2UKPiBpbiBob3cgdG8gZG8g
aXQgd2l0aCByZWZjb3VudGVyLgo+IAo+IENoYW5nZXMgaW4gdjQ6Cj4gIC0gTmV3IHBhdGNoOiBz
cGxpdCBtZmQgY2hhbmdlcyBpbnRvIHRoaXMgcHJlY3Vyc29yIHBhdGNoCj4gIC0gRXhwb3J0IHRo
ZSBhZGRlZCBzdG1wZTgxMV9hZGNfY29tbW1vbl9pbml0IGZ1bmN0aW9uCj4gIC0gRGlzYWJsaW5n
IGFkYyB3aGVuIG1mZCBpcyByZW1vdmVkCj4gCj4gQ2hhbmdlcyBpbiB2MzogTm9uZQo+IENoYW5n
ZXMgaW4gdjI6Cj4gIC0gTW92ZSBjb2RlIHRvIHNldHVwIEFEQyB0byBNRkQgZGV2aWNlLCBhcyBp
dCBpcyB1c2VkIGJ5IGJvdGggZHJpdmVycwo+ICAgIGFkYyBhbmQgdG91Y2hzY3JlZW4KPiAKPiAg
ZHJpdmVycy9tZmQvS2NvbmZpZyAgICAgICB8ICAzICstCj4gIGRyaXZlcnMvbWZkL3N0bXBlLmMg
ICAgICAgfCA2OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgaW5j
bHVkZS9saW51eC9tZmQvc3RtcGUuaCB8IDEwICsrKysrKwo+ICAzIGZpbGVzIGNoYW5nZWQsIDgw
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCkZvciBteSBvd24gcmVmZXJlbmNlOgogIEFj
a2VkLWZvci1NRkQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgotLSAKTGVl
IEpvbmVzIFvmnY7nkLzmlq9dCkxpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZApMaW5hcm8u
b3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzog
RmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
