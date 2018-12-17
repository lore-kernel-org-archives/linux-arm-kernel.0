Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72CBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:19:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AED120874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AyOsT4ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AED120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FcZhCtftSAASt0Of6/pgjfoOh5bESX4A2XSlIh754bQ=; b=AyOsT4ugIe14Fc
	oU6PkyA5rqZDqhGpe37Vg/sWJ8hDRSmEpjrJW3v8UVlIzF+smzDZYzFN92KPlZxy21ALm8qTQ/zlA
	7SLsFrebjZQi/JmEOcBUcm7t3YDzhYrAtjDGk5eHugb9JecbuflKyOUbqcckhVi9lDCbQgzc3NOIt
	1XsMAuhOWOO76lWhaPqD57MqMkfoXf4JKnWNlGpcdd0SKWlu6DN+zVXXx9wQabfE+uuo3/HiiINrG
	ycMDb/VCd+l0/OTIilW/KeVHYKFR7SMQIxIUxkLVqbUjW07bQ1HHI9P3jRG+46W8X88l1b1/GXGFF
	hOKyDrWHZT2bQvpNLW0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtkD-0002PT-42; Mon, 17 Dec 2018 14:19:41 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtk9-0002Dl-Hd; Mon, 17 Dec 2018 14:19:39 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 403EEADDD;
 Mon, 17 Dec 2018 14:19:22 +0000 (UTC)
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
To: Xue Liu <liuxuenetmail@gmail.com>, Jian-Hong Pan <starnight@g.ncu.edu.tw>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
 <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
Date: Mon, 17 Dec 2018 15:19:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_061937_881877_9E014924 
X-CRM114-Status: GOOD (  14.24  )
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
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, netdev@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
 linux-lpwan@lists.infradead.org, Dollar Chen <dollar.chen@wtmec.com>,
 Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8gWHVlIExpdSwKCkFtIDE3LjEyLjE4IHVtIDA5OjUwIHNjaHJpZWIgWHVlIExpdToKPiBJ
IGhhdmUgYSBxdWVzdGlvbiBhYm91dCB0aGUgYXJjaGl0ZWN0dXJlIG9mIHlvdXIgbW9kdWxlLiBB
RkFJSyBMb1JhV0FOCj4gaXMgYWxyZWFkeSB0aGUgTUFDIExheWVyIGFib3ZlIHRoZSBMb1JhIHRl
Y2hub2xvZ3kuIFdoeSBkbyB5b3Ugd2FudCB0bwo+IG1ha2UgYSBuZXcgbGF5ZXIgY2FsbGVkICJt
YWNsb3Jhd2FuIiA/CgpJIGhhZCBhc2tlZCBKaWFuLUhvbmcgdG8gc2VwYXJhdGUgYmV0d2VlbiBo
aXMgc29mdC1NQUMgaW1wbGVtZW50YXRpb24KYW5kIHRoZSBjb21tb24gYml0cyBuZWVkZWQgdG8g
ZHJpdmUgaGFyZC1NQUMgaW1wbGVtZW50YXRpb25zIGZvdW5kIG9uCnNldmVyYWwgb2YgdGhlIGhh
cmR3YXJlIG1vZHVsZXMgbWFkZSBhdmFpbGFibGUgdG8gbWUuCgpUaGUgcHJlZml4ICJtYWMiIHdh
cyBjb3BpZWQgZnJvbSBtYWM4MDIxMSBhbmQgbWFjODAyMTU0OgpodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9uZXQK
CklmIHlvdSBoYXZlIGJldHRlciBpZGVhcyBmb3IgaG93IHRvIHN0cnVjdHVyZSB0aGlzLCBqdXN0
IGxldCB1cyBrbm93LAppZGVhbGx5IGFzIGlubGluZSBjb21tZW50IHdoZXJlIHlvdSBzZWUgaXQg
KG9yIG9uIHRoZSBjb3ZlciBsZXR0ZXIpLgoKT25seSBjb21tZW50IEkgaGF2ZSBmb3IgdGhpcyBw
YXRjaCBhdCB0aGUgbW9tZW50IGlzIHRoYXQgSSB3b3VsZCBwcmVmZXIKdG8gaGF2ZSB0aGUgS2Nv
bmZpZyBiaXRzIGJlIGluIHRoZSBwYXRjaGVzIGFkZGluZyB0aGUgY29kZSwgc28gdGhhdCB3ZQpj
YW4gYWN0dWFsbHkgYnVpbGQtdGVzdCB0aGVtIGJlZm9yZSA2LzYuCgpCZWVuIHVwZGF0aW5nIG15
IGxhYiB0byA0LjIwLXJjWCB3aXRoIHNvbWUgaGljY3Vwcy4gQmVuJ3MKcmVnbWFwX25vaW5jX3dy
aXRlIHN1cHBvcnQgbWFkZSBpdCBpbnRvIDQuMjAsIHNvIEkgZXhwZWN0IHRvIGhhdmUgQmVuJ3MK
cGVuZGluZyBicmFuY2ggZm9yIHN4MTMwMSBtZXJnZWQgaW50byByZWJhc2VkIGxvcmEtbmV4dCBi
ZWZvcmUgQ2hyaXN0bWFzCmFuZCBteSBzeDEyNzYgY29udmVyc2lvbiB0byBmb2xsb3csIGxlYXZp
bmcgdGhlIFBGX1BBQ0tFVCB2cy4gUEZfTE9SQQpkaXNjdXNzaW9uIGZyb20gRUxDRSAtIGhhdmVu
J3QgYXNzZXNzZWQgeWV0IGhvdyBtdWNoIHRoaXMgc2VyaWVzIHdvdWxkCmJlIGFmZmVjdGVkIGJ5
IHRoZSB1bmRlcmx5aW5nIGNoYW5nZXMsIGJ1dCBpZiB0aGUgYWJzdHJhY3Rpb24gd2FzIGRvbmUK
cmlnaHQgdGhlbiBvbmx5IG1hY2xvcmF3YW4gaW1wbGVtZW50YXRpb24gc2hvdWxkIGJlIGFmZmVj
dGVkLgoKUmVnYXJkcywKQW5kcmVhcwoKLS0gClNVU0UgTGludXggR21iSCwgTWF4ZmVsZHN0ci4g
NSwgOTA0MDkgTsO8cm5iZXJnLCBHZXJtYW55CkdGOiBGZWxpeCBJbWVuZMO2cmZmZXIsIEphbmUg
U21pdGhhcmQsIEdyYWhhbSBOb3J0b24KSFJCIDIxMjg0IChBRyBOw7xybmJlcmcpCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
