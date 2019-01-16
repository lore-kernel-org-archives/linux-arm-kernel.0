Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E192C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:14:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E45D20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g353uA5b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A9yfAR5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E45D20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ak5CRcmKeWZe/cbkV866aTBc7gjh38mOon7y/HQUqec=; b=g353uA5bRSly+dCTZL8/K7qpa
	ftINTaT8J+zQtGzoGM81p5wdkqYNRtK3EI+Zq8RBqp84T/kkgA0+uUPKUUQwHcoL6NRLVfRbzK8mn
	V6Ro/5i8RcKgBALYck5usuP/zWatkfrUobPcYIZISdAQEyc+6d2JwAs8gk9kLPqYcIb326iCcpOhn
	BiEA8NFwNKmvN5Orf5QxvmW7ZjcQrMn3o/QkqrRKIa/KgEeHsVDs3mGz1yYqM17pv/iyuvv10wG//
	ym23JKCbkZkli54gzkol0HfjbkCL7KX7hYIseSVwLb6ilYVTl79ViRJLahmD3VY2u0XBG+VGEiYkI
	upYzpt4EA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjYqp-00039U-6f; Wed, 16 Jan 2019 00:14:35 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjYqk-00038c-SQ
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 00:14:32 +0000
Received: by mail-pf1-x443.google.com with SMTP id b85so2108780pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 16:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ZA20ebCNbHqeH+NvZr746IlKnzu2haXNYszOlgma2HQ=;
 b=A9yfAR5h0fZfr9gAbSLybL81lgfUym/wQcT6X0/PAHuGeU2zHXqxCwvF/kacUe9ONz
 VIUYQyCgTAtp73Z1J8IVcwL9FxkLYdxWYVVa1WekbPiXXpyiy0e7HnAs7UoADDnX0cVO
 yxDOuJb1LtV5cLOIdw8UKDTy3AwE/tWhG3amM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ZA20ebCNbHqeH+NvZr746IlKnzu2haXNYszOlgma2HQ=;
 b=ATXW99TndWlsGo8cTbzszVJzfVVgYa3DBPnLutGbhJNRbC5yTkbu143FBSybPhhcKw
 9d5oOCRLJon8r0Bp+aw2XDUA461VMDovdRGuf+eAGozrd+EP1u9gd1PJaKiY0HxSout7
 4UHXCUUsNXbB9zDy8cZ7e7jMX0p7OaC0KX6R1dLvTfyk+yOEdrpqilq1rKtyJAAdul73
 JFoNbQCKditYi3oq4SM+sIl+9jL+us0vXKzcAO6H4xkXD61LwbCFwBL5e5FkKpJKL9uD
 rEmKH++Dw620Z+0ngjUgDHrc9lGZOIgTe4MaPth8AU9Ad3Z7SZHMhTknMDHoKsGRmI0e
 q9nA==
X-Gm-Message-State: AJcUukfe7axTuZz6xrJRHfY6LPiuLLmjOwWSuKIt+Poneej+m+jz1LpM
 owfO+bDbKE2j/5UgbR62Bm2uiw==
X-Google-Smtp-Source: ALg8bN521l1NRwW8yuyctaZqkY8KD2IwR4iVboInTLhR3OIAgolSZCAy6yn2Cgok3Fd56d1DnbsVmg==
X-Received: by 2002:a63:1013:: with SMTP id f19mr6251463pgl.38.1547597666850; 
 Tue, 15 Jan 2019 16:14:26 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id d18sm5194007pfj.47.2019.01.15.16.14.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 16:14:25 -0800 (PST)
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
 <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
 <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
 <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <faadc46d-94b5-a32c-79ae-4206fbc26608@broadcom.com>
Date: Tue, 15 Jan 2019 16:14:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_161430_921641_B926F53C 
X-CRM114-Status: GOOD (  25.51  )
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
Cc: linux-pwm@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Praveen Kumar B <praveen.b@broadcom.com>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVXdlLAoKT24gMjAxOS0wMS0xMiA3OjA1IGEubS4sIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3Rl
Ogo+IEhlbGxvIFNjb3R0LAo+Cj4gT24gRnJpLCBKYW4gMTEsIDIwMTkgYXQgMDE6Mjg6NDVQTSAt
MDgwMCwgU2NvdHQgQnJhbmRlbiB3cm90ZToKPj4gT24gMjAxOS0wMS0xMSAxMjo0OCBwLm0uLCBV
d2UgS2xlaW5lLUvDtm5pZyB3cm90ZToKPj4+IE9uIEZyaSwgSmFuIDExLCAyMDE5IGF0IDEwOjUx
OjE0QU0gKzA1MzAsIFNoZWV0YWwgVGlnYWRvbGkgd3JvdGU6Cj4+Pj4gRnJvbTogUHJhdmVlbiBL
dW1hciBCIDxwcmF2ZWVuLmJAYnJvYWRjb20uY29tPgo+Pj4+Cj4+Pj4gQWRkIG5ldyBjb21wYXRp
YmxlIHN0cmluZyBmb3IgbmV3IHZlcnNpb24gb2YgcHdtLWtvbmEKPj4+Pgo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFByYXZlZW4gS3VtYXIgQiA8cHJhdmVlbi5iQGJyb2FkY29tLmNvbT4KPj4+PiBSZXZp
ZXdlZC1ieTogUmF5IEp1aSA8cmF5Lmp1aUBicm9hZGNvbS5jb20+Cj4+Pj4gUmV2aWV3ZWQtYnk6
IFNjb3R0IEJyYW5kZW4gPHNjb3R0LmJyYW5kZW5AYnJvYWRjb20uY29tPgo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFNoZWV0YWwgVGlnYWRvbGkgPHNoZWV0YWwudGlnYWRvbGlAYnJvYWRjb20uY29tPgo+
Pj4+IC0tLQo+Pj4+ICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vYnJj
bSxrb25hLXB3bS50eHQgfCAyICstCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9icmNtLGtvbmEtcHdtLnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vYnJjbSxrb25hLXB3bS50eHQKPj4+PiBpbmRleCA4ZWFl
OWZlLi5kMzdmNjk3IDEwMDY0NAo+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wd20vYnJjbSxrb25hLXB3bS50eHQKPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcHdtL2JyY20sa29uYS1wd20udHh0Cj4+Pj4gQEAgLTMsNyArMyw3
IEBAIEJyb2FkY29tIEtvbmEgUFdNIGNvbnRyb2xsZXIgZGV2aWNlIHRyZWUgYmluZGluZ3MKPj4+
PiAgICBUaGlzIGNvbnRyb2xsZXIgaGFzIDYgY2hhbm5lbHMuCj4+Pj4gICAgUmVxdWlyZWQgUHJv
cGVydGllcyA6Cj4+Pj4gLS0gY29tcGF0aWJsZTogc2hvdWxkIGNvbnRhaW4gImJyY20sa29uYS1w
d20iCj4+Pj4gKy0gY29tcGF0aWJsZTogc2hvdWxkIGNvbnRhaW4gImJyY20sa29uYS1wd20iIG9y
ICJicmNtLGtvbmEtcHdtLXYyIgo+Pj4gSXMgdjIgdXNlZCBvbiBhIG5ld2VyIGdlbmVyYXRpb24g
b2Yga29uYSBTb0NzPyBPbiBpLk1YIHRoZXNlIHZhcmlhbnRzCj4+PiBhcmUgdXN1YWxseSBuYW1l
ZCBhZnRlciB0aGUgZmlyc3QgU29DIHRoYXQgY2FtZSB3aXRoIHRoZSBuZXcgdmFyaWFudC4gSXMK
Pj4+IHRoaXMgc2Vuc2libGUgaGVyZSwgdG9vPwo+PiBJdCBkb2Vzbid0IG1ha2UgYXMgbXVjaCBz
ZW5zZSBoZXJlIGFzIGRpZmZlcmVudCByZXZzIG9mIHRoZSBJUCBibG9jayBhcmUKPj4gcGlja2Vk
IHVwIGJhc2VkIG9uIHZhcmlvdXMgZGVjaXNpb25zLgo+Pgo+PiBBIG5ldyBTb0MgY291bGQgZGVj
aWRlIHRvIHVzZSBhbiBvbGQgdmVyc2lvbi4KPiBJTUhPIHRoaXMgaXMgbm8gcmVhc29uIHRvIG5v
dCB1c2UgdGhlIG5hbWUgb2YgdGhlIG9sZGVzdCBTb0Mgd2l0aCB0aGlzCj4gdmFyaWFudC4gSSBk
b24ndCBrbm93IGhvdyB0aGUgU29DIG5hbWVzIGFyZSBpbiB0aGUgYnJvYWRjb20gZmFtaWx5LCBi
dXQKPiBpZiB0aGV5IHdlcmUgKGluIG9yZGVyIG9mIGFnZSwgb2xkZXN0IGZpcnN0KToKPgo+IAlh
bnQKPiAJYmVhcgo+IAljcm9jb2RpbGUKPgo+IGFuZCBhbnQgYW5kIGNyb2NvZGlsZSB1c2UgdGhl
IHNhbWUgSVAgYmxvY2sgd2Ugd291bGQgaGF2ZQo+Cj4gYSkgd2l0aCB2MSwgdjI6Cj4KPiAJYW50
Ogo+IAkJY29tcGF0aWJsZSA9ICJicmNtLGtvbmEtcHdtLXYxIjsKPiAJYmVhcjoKPiAJCWNvbXBh
dGlibGUgPSAiYnJjbSxrb25hLXB3bS12MiI7Cj4gCWNyb2NvZGlsZToKPiAJCWNvbXBhdGlibGUg
PSAiYnJjbSxrb25hLXB3bS12MSI7Cj4KPiA7IGFuZAo+Cj4gYikgd2l0aCB0aGUgU29DIG5hbWlu
ZzoKPgo+IAlhbnQ6Cj4gCQljb21wYXRpYmxlID0gImJyY20sa29uYS1hbnQtcHdtIjsKPiAJYmVh
cjoKPiAJCWNvbXBhdGlibGUgPSAiYnJjbSxrb25hLWJlYXItcHdtIjsKPiAJY3JvY29kaWxlOgo+
IAkJY29tcGF0aWJsZSA9ICJicmNtLGtvbmEtY3JvY29kaWxlLXB3bSIsICJicmNtLGtvbmEtYW50
LXB3bSI7Cj4KPiAoSWYgeW91IHdhbnQsIGRyb3AgImJyY20sa29uYS1jcm9jb2RpbGUtcHdtIiwg
YnV0IGtlZXBpbmcgaXQgaXMgbW9yZQo+IGRlZmVuc2l2ZS4pCj4KPiBJIGxpa2UgYikgKHdpdGgg
Ii4uLi1jcm9jb2RpbGUtLi4uIikgYmV0dGVyIHRoYW4gYSkuIGNyb2NvZGlsZSB1c2luZwo+ICIu
Li4tYW50LS4uLiIgaXMgbm90IG1vcmUgdWdseSB0aGFuIGNyb2NvZGlsZSB1c2luZyAiLi4uLXYx
Ii4gVGhpcyBpcwo+IGFsc28gYSB0YWQgbW9yZSByb2J1c3QgYmVjYXVzZSBpZiBicm9hZGNvbSBy
ZWxlYXNlcyBrb25hLWRvbHBoaW4gYW5kCj4gc29tZW9uZSBmaW5kcyBhIG1pbm9yIGRpZmZlcmVu
Y2UgYmV0d2VlbiB0aGUgSVBzIHVzZWQgb24gYW50IGFuZAo+IGNyb2NvZGlsZSBpdCBkZXBlbmRz
IG9uIHRoZSBvcmRlciBvZiB0aGVzZSBldmVudHMgd2hvIGdldHMgdjMsIHdoaWxlCj4gd2l0aCB0
aGUgU29DIG5hbWluZyB0aGUgcmVzdWx0IGlzIGNsZWFyLgo+Cj4gKE9LLCBhbmQgZ2l2ZW4gdGhh
dCAiYnJjbSxrb25hLXB3bSIgaXMgYWxyZWFkeSBmaXhlZCwgYm90aCBhcHByb2FjaGVzCj4gbmVl
ZCBzbGlnaHQgYWRhcHRpb24sIGJ1dCBJIGd1ZXNzIHlvdSBzdGlsbCBnZXQgd2hhdCBJIG1lYW50
LikKClRoYW5rcyBmb3IgeW91ciB0aG91Z2h0cyBhbmQgZXhwbGFuYXRpb24uCgpJdCBpcyB1bmZv
cnR1bmF0ZSBkZXZpY2V0cmVlIGhhcyBubyBwcm9wZXIgZ3VpZGVsaW5lcyBvciBkb2N1bWVudGF0
aW9uIG9uCgpiaW5kaW5nIG5hbWluZy7CoCBJbiB0aGUgaW50ZXJlc3Qgb2YgZ2V0dGluZyB0aGlz
IHVwc3RyZWFtIHdlIGNhbiBuYW1lIGl0CgoiYnJjbSwgb21lZ2EtcHdtIi7CoCBXZSBjYW4gZHJv
cCBrb25hIGZyb20gdGhlIGJpbmRpbmcgbmFtZSBhcyB0aGF0IAphcmNoaXRlY3R1cmUKCmlzIHJl
YWxseSBubyBtb3JlIC0gb25seSBJUCBkZXJpdmVkIGZyb20gaXQgaXMgLSBoZW5jZSB0aGUgbmFt
ZSBrb25hLXYyIApwcmV2aW91c2x5LgoKPgo+IEJlc3QgcmVnYXJkcwo+IFV3ZQo+Cj4KQ2hlZXJz
LApTY290dAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
