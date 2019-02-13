Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75685C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:24:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490C0218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mCBf/s8F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fClHDp+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490C0218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zGbVNaT6cTmNEi6WiIg9KJDkRKd993vtoUQCUxziZII=; b=mCBf/s8FOP9KPW
	fnmcYcAVYF/Gh/UKe19q4kCg31/EOmUI9VwCMGL3UsZttXtvZyPB8bGtjQsQup0BOyzOlj+fhxBLz
	sLbbgcTNvn73/B1mgXyDWSdmeXrQAq+Z7veWNyJN1iAwBbnQBie3p4+ePi7osYjbu4+z+zrDTdVa4
	jiruIr5okzH1JCm2EdVKAKzVTO05BKgjonBIAqVnUgw2W/RzsXD6zuaVQukDNyJ4/84lWN0gMmiH1
	FClIIjr397v67ZdubC4wJFRaUSWoH4F1CJYa7UQjBYNPWi6JE/WvOXWc1LfsiqQ46Kr0BFG9iHLnr
	L+QRwXgVTaWBBvdQSbBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtyGz-000672-Cw; Wed, 13 Feb 2019 17:24:37 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtyGw-00066S-Ip
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:24:36 +0000
Received: by mail-ed1-x541.google.com with SMTP id x7so2618249eds.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 09:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tg0wqevx6W7ZMY5x/CJFj4fx8BvWdWVk8GTaSGdDvUo=;
 b=fClHDp+cbtYqOrK0V2124KYyZ9jWZe6mo5OYSmfna7+tHXmVdeCiACPAJ4FL2f5aM6
 vUCma7VeYu9p3cbtU2qSphoDUUo6tv5wo+Nh2cIU0i2kli/Y852og7aHQO1YjjeNygZj
 bhHeUz1POl76F4FoONi1V2rUJfa7D0zPDhIGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tg0wqevx6W7ZMY5x/CJFj4fx8BvWdWVk8GTaSGdDvUo=;
 b=hd7mWLOBjSOJ3hr33IugwS/6lo5fnNOpxnOXVwiJY9+oQYUql/82FhPzCDCdiz5Nb7
 oDKM6Ee4oHRophLlKs6lYssPFZ8Xp8ZUjoBHlYobiiG7+d7GPY5voNJMc9TcMPA3Ytk0
 eH6K8FcOKL528pyOJihyRYH9wdojObxyyrO/J28qRVstTo5o0eukPRkZVFXfPCRCIKRp
 LSQtZfqCZ+5ofkd8196L7GbfATak9xgIsPHvpPFWvfi4wzL4q9z1MtlhU2iHov7GtDME
 DO3QpMXa7z6seDI+9gnYvM6oyJx2U4Wng/8FaC3gWYTLPidYixWjNjyAlZoMORK/zuBs
 YTIA==
X-Gm-Message-State: AHQUAub9RZ39OH6hO/OEmmbgHJNwRgHQFcSsza3WEJG9W+nqCzi5d+sO
 fyuOavz+s7thYhbFJ60NWK4/xw==
X-Google-Smtp-Source: AHgI3IbUyRBFiezO7SAYRILH00mDXNYDKba0+lB7zbPliimW1AVoBzoNvQ+zBB8QANToFgFMAbfRHg==
X-Received: by 2002:a17:906:4344:: with SMTP id
 z4mr1144782ejm.27.1550078672263; 
 Wed, 13 Feb 2019 09:24:32 -0800 (PST)
Received: from [10.67.48.220] ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id k13-v6sm3887600ejk.50.2019.02.13.09.24.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 09:24:31 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: BCM5301X: Change Ethernet switch management port
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, linux-arm-kernel@lists.infradead.org
References: <20190213042600.27729-1-f.fainelli@gmail.com>
 <43f75739-b592-35d3-e711-13f05218133d@gmail.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Openpgp: preference=signencrypt
Autocrypt: addr=florian.fainelli@broadcom.com; prefer-encrypt=mutual; keydata=
 mQENBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAG0MEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPokB
 xAQQAQIArgUCW382iBcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFrZXktdXNh
 Z2UtbWFza0BwZ3AuY29tjjAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2RpbmdAcGdw
 LmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29tLmNvbQUb
 AwAAAAMWAgEFHgEAAAAEFQgJCgAKCRCBMbXEKbxmoFYGB/9qN5VL6f/88+qtDaDhUKvwBgF8
 koryGCH/gw6FBW5h5hwW0m6946WnsBnqKnZ8OYr8qsCgeJewCh0BEN9rIg8SC5oU7WdcmNg5
 KTv4/V1CmBo6dQaSHA8yQoeHsrw0gQ9HK4EYjhAU60RYXxX7/LFAy0rJMLf0qGKdWW2f5EkN
 dS5GwWOrTp477WL2g+R0khhP57qpejxlMN+Mtvin52UjbAcr1PAx8Zt2rXpFIZsXVWADpZDd
 qIb6PZPdcP/lD1v5it4sTN7D27FgjvbvAgj/D3NmyOjIUsbN9ZDJDfgv431RsJ9LOd6ySaNr
 yuje7L0dbiYrcOi3CN6S+zE1UJsLuQENBFPAG8EBCACsa+9aKnvtPjGAnO1mn1hHKUBxVML2
 C3HQaDp5iT8Q8A0ab1OS4akj75P8iXYfZOMVA0Lt65taiFtiPT7pOZ/yc/5WbKhsPE9dwysr
 vHjHL2gP4q5vZV/RJduwzx8v9KrMZsVZlKbvcvUvgZmjG9gjPSLssTFhJfa7lhUtowFof0fA
 q3Zy+vsy5OtEe1xs5kiahdPb2DZSegXW7DFg15GFlj+VG9WSRjSUOKk+4PCDdKl8cy0LJs+r
 W4CzBB2ARsfNGwRfAJHU4Xeki4a3gje1ISEf+TVxqqLQGWqNsZQ6SS7jjELaB/VlTbrsUEGR
 1XfIn/sqeskSeQwJiFLeQgj3ABEBAAGJAkEEGAECASsFAlPAG8IFGwwAAADAXSAEGQEIAAYF
 AlPAG8EACgkQk2AGqJgvD1UNFQgAlpN5/qGxQARKeUYOkL7KYvZFl3MAnH2VeNTiGFoVzKHO
 e7LIwmp3eZ6GYvGyoNG8cOKrIPvXDYGdzzfwxVnDSnAE92dv+H05yanSUv/2HBIZa/LhrPmV
 hXKgD27XhQjOHRg0a7qOvSKx38skBsderAnBZazfLw9OukSnrxXqW/5pe3mBHTeUkQC8hHUD
 Cngkn95nnLXaBAhKnRfzFqX1iGENYRH3Zgtis7ZvodzZLfWUC6nN8LDyWZmw/U9HPUaYX8qY
 MP0n039vwh6GFZCqsFCMyOfYrZeS83vkecAwcoVh8dlHdke0rnZk/VytXtMe1u2uc9dUOr68
 7hA+Z0L5IQAKCRCBMbXEKbxmoLoHCACXeRGHuijOmOkbyOk7x6fkIG1OXcb46kokr2ptDLN0
 Ky4nQrWp7XBk9ls/9j5W2apKCcTEHONK2312uMUEryWI9BlqWnawyVL1LtyxLLpwwsXVq5m5
 sBkSqma2ldqBu2BHXZg6jntF5vzcXkqG3DCJZ2hOldFPH+czRwe2OOsiY42E/w7NUyaN6b8H
 rw1j77+q3QXldOw/bON361EusWHdbhcRwu3WWFiY2ZslH+Xr69VtYAoMC1xtDxIvZ96ps9ZX
 pUPJUqHJr8QSrTG1/zioQH7j/4iMJ07MMPeQNkmj4kGQOdTcsFfDhYLDdCE5dj5WeE6fYRxE
 Q3up0ArDSP1L
Message-ID: <56eae00a-0090-0b57-8615-0a331bc1c984@broadcom.com>
Date: Wed, 13 Feb 2019 09:24:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <43f75739-b592-35d3-e711-13f05218133d@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_092434_628564_144D2130 
X-CRM114-Status: GOOD (  18.05  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMi8xMy8xOSAxMjowNyBBTSwgUmFmYcWCIE1pxYJlY2tpIHdyb3RlOgo+IE9uIDEzLjAyLjIw
MTkgMDU6MjUsIEZsb3JpYW4gRmFpbmVsbGkgd3JvdGU6Cj4+IEJDTTUzMDFYIGhhcyAzIEV0aGVy
bmV0IGNvbnRyb2xsZXJzOiBHTUFDMCwgMSwgMiB3aGljaCBtYXAgdG8gcG9ydHMgNSwgNwo+PiBh
bmQgOCByZXNwZWN0aXZlbHkgb2YgdGhlIGludGVybmFsIHN3aXRjaC4gRnV0dXJlIGNoYW5nZXMg
d2lsbCB0dXJuIG9uCj4+IG1hbmFnZW1lbnQgbW9kZSBpbiB0aGUgRXRoZXJuZXQgc3dpdGNoIGRy
aXZlciAoYjUzKSB3aGljaCB3aWxsIHJlcXVpcmUKPj4gdXMgdG8gdXNlIHBvcnQgOC4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+Cj4+
IC0tLQo+PiDCoCBhcmNoL2FybS9ib290L2R0cy9iY200NzA4LXNtYXJ0cmctc3I0MDBhYy5kdHMg
fCAxMSArKysrKysrKy0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYmNtNDcw
OC1zbWFydHJnLXNyNDAwYWMuZHRzCj4+IGIvYXJjaC9hcm0vYm9vdC9kdHMvYmNtNDcwOC1zbWFy
dHJnLXNyNDAwYWMuZHRzCj4+IGluZGV4IDNmY2VkM2I3ZjFhOC4uYWZmYTljYzc0MjJkIDEwMDY0
NAo+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9iY200NzA4LXNtYXJ0cmctc3I0MDBhYy5kdHMK
Pj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYmNtNDcwOC1zbWFydHJnLXNyNDAwYWMuZHRzCj4+
IEBAIC0xNTAsMTAgKzE1MCwxNSBAQAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsYWJl
bCA9ICJ3YW4iOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPj4gwqAgLcKgwqDCoMKgwqDCoMKg
IHBvcnRANSB7Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDw1PjsKPj4gK8KgwqDC
oMKgwqDCoMKgIHBvcnRAOCB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDw4PjsK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGFiZWwgPSAiY3B1IjsKPj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZXRoZXJuZXQgPSA8JmdtYWMwPjsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZXRoZXJuZXQgPSA8JmdtYWMyPjsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBmaXhlZC1saW5rIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGVlZCA9
IDwxMDAwPjsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmdWxsLWR1cGxleDsK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4+
IMKgwqDCoMKgwqAgfTsKPj4gwqAgfTsKPiAKPiBJJ20gbm90IGV4YWN0bHkgc3VyZSBob3cgTGlu
dXggc3dpdGNoIGRyaXZlciB3b3JrcywgYnV0IGZyb20gRFQKPiBwZXJzcGVjdGl2ZSBJIHRoaW5r
IHdlIHNob3VsZCByYXRoZXIgaGF2ZSAqaGFyZHdhcmUqIGRlc2NyaWJlZCBpbnN0ZWFkCj4gb2Yg
YSBjb21tb24gTGludXggY2FzZS4KPiAKPiBJZiBJJ20gcmlnaHQsIHdlIHNob3VsZCByYXRoZXIg
aGF2ZSBhbGwgMyBzd2l0Y2ggcG9ydHMgZGVzY3JpYmVkICg1LCA3LAo+IDgpIGFuZCBoYXZlIExp
bnV4IGp1c3QgdXNlIHRoZSBvbmUgaXQgbmVlZHMuCgpZZXMsIGxldCdzIGRvIHRoYXQuCi0tIApG
bG9yaWFuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
