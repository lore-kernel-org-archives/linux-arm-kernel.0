Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D102C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:12:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B1B206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sVkUKPTs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgpSHsyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B1B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2h11MM6gXaO5xuM7NEcvILnlV0mYe1KtawT2JPvb4T0=; b=sVkUKPTsufLbMy
	5C04NVtbDnZqoThTu3GERJIScRfcWYjXn2yiRdx6VpMBXWuDwzWqOhuByvEd52qWjdykiuKgCwoLn
	QO4WfyKXk/hAl6C43q17cPoAY5XD3uhMObSNcf02aNm0LelbIanawZrJxSO2+6OHFuhAoX2ckadQC
	k9z85lYA0GLU91NLxS6uxLLCG3AoW6iXCf3uMAz4b5Y66a6XmvSeeQmeW5GxybSNJ5ZdmiB1Kxcz+
	vkCN1dIEwT2qywb2oua5p1syfhjYVI4AFPY693uNP3TpvDeX8XgCW2cwPMXVPSmQov2nNbzbEqglt
	yo0xMT8Y4RHXw1wojHvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXflm-0004KI-9K; Fri, 14 Dec 2018 05:12:14 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXfli-0004JM-7I; Fri, 14 Dec 2018 05:12:12 +0000
Received: by mail-ot1-x343.google.com with SMTP id v23so4274160otk.9;
 Thu, 13 Dec 2018 21:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n8doylIzi8abXLgg/31g00Bs9s7hcD79O8dvOGYekzs=;
 b=RgpSHsyNSHGxp5yz+L4KTekjL0kvkx42OSw+5GZJs7hmsZ3xgY11Mcq8KgLzGMDzpe
 2TbgMwKR3XhRleSLa8qKFp9wRFsAiLn/xHEyQKeJ1wMcFA9m70QsM27PStP7N5dyVjRA
 YGwCijfDJu6lE+Z+qRk48KsV6syyjduGmuOmr9wTzhNNbIwnuRMVOx5KvJyzosjcCHQv
 liR07ELm2v60LyBiM0APNV/rpsHYbTiGVf1k4or74xIIzTTTFRlqZSghOhvfSkXRMr03
 Z6BraFFgCXm9RYUPYBE3pxu4Ty3JJ7JijcZD+weC+4SHxEPUQ30w8NAtasW5fRgPuTe/
 9IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=n8doylIzi8abXLgg/31g00Bs9s7hcD79O8dvOGYekzs=;
 b=K8rluk7/HgMu8CjYYmDVwpPt5aJRLJhQABlMo2alWUheJZknmVAtqhBsHsKjMTa6St
 rfInilcspumkEWXSIohatNJJaKVOhCZ/cGx7Q/dopYajoIvrrML3u5bf3ONBaoFH6Kp6
 WAgIFHMvKD8PYDl4ndYrBVsa8miFhsNk7+ulB3O0hdgbasNvXIpSM/E3JSPmkLBXO+dn
 X+gWA5oPrMs84aZdynDnbanYmbcba/0SVjCzGgxXXgQayiTuLWdnmfJQrqMXl0BY2dtL
 TCtEQVPKR6g6ifhbwxvM8d0diM0pLPCb3xz61u8h4jj13lfud+VrjpIHi40vdpo7yAKK
 O8Ig==
X-Gm-Message-State: AA+aEWad+IimbdcvfaLpWIhPESs1oUZVsC+Fk57kh6bnnV7rFuag4mSd
 9gICGnSn7po/qhHqMOI/cbg5ONQc
X-Google-Smtp-Source: AFSGD/VrtvKCcU1Uw91jr/5thS8AaF5ULQm/x5k3eVsMld/gFAKvJVSFrWdv2GfdUykZQ7rpEXAYSg==
X-Received: by 2002:a9d:1715:: with SMTP id i21mr1080464ota.149.1544764318351; 
 Thu, 13 Dec 2018 21:11:58 -0800 (PST)
Received: from [192.168.1.2] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
 by smtp.googlemail.com with ESMTPSA id
 r184sm1833286oif.56.2018.12.13.21.11.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 21:11:57 -0800 (PST)
Subject: Re: [v7, PATCH 1/2] net:stmmac: dwmac-mediatek: add support for mt2712
To: biao huang <biao.huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
 <1544666173-5121-2-git-send-email-biao.huang@mediatek.com>
 <20181213123346.GF1605@lunn.ch> <1544756477.24219.164.camel@mhfsdcap03>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Message-ID: <f3427cac-88b2-1464-8f92-4692a7125674@gmail.com>
Date: Thu, 13 Dec 2018 21:11:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544756477.24219.164.camel@mhfsdcap03>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_211210_264016_0874540C 
X-CRM114-Status: GOOD (  21.38  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nelson.chang@mediatek.com,
 netdev@vger.kernel.org, liguo.zhang@mediatek.com, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, joabreu@synopsys.com,
 linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
 matthias.bgg@gmail.com, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TGUgMTIvMTMvMTggw6AgNzowMSBQTSwgYmlhbyBodWFuZyBhIMOpY3JpdMKgOgo+IERlYXIgQW5k
cmV3LAo+IAlUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuCj4gCj4gT24gVGh1LCAyMDE4LTEyLTEz
IGF0IDEzOjMzICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToKPj4gSGkgQmlhbwo+Pgo+Pj4gKwlj
YXNlIFBIWV9JTlRFUkZBQ0VfTU9ERV9SR01JSToKPj4+ICsJCS8qIHRoZSBQSFkgaXMgbm90IHJl
c3BvbnNpYmxlIGZvciBpbnNlcnRpbmcgYW55IGludGVybmFsCj4+PiArCQkgKiBkZWxheSBieSBp
dHNlbGYgaW4gUEhZX0lOVEVSRkFDRV9NT0RFX1JHTUlJIGNhc2UsCj4+PiArCQkgKiBzbyBFdGhl
cm5ldCBNQUMgd2lsbCBpbnNlcnQgZGVsYXlzIGZvciBib3RoIHRyYW5zbWl0Cj4+PiArCQkgKiBh
bmQgcmVjZWl2ZSBwYXRoIGhlcmUuCj4+PiArCQkgKi8KPj4KPj4gV2hhdCBpZiB0aGUgUENCIGRl
c2lnbmVkIGhhcyBkZWNpZGVkIHRvIGRvIGEga2luayBpbiB0aGUgY2xvY2sgdG8gYWRkCj4+IHRo
ZSBkZWxheXM/IEkgZG9uJ3QgdGhpbmsgYW55IG9mIHRoZXNlIGRlbGF5cyBzaG91bGQgZGVwZW5k
IG9uIHRoZSBQSFkKPj4gaW50ZXJmYWNlIG1vZGUuIEl0IGlzIHVwIHRvIHRoZSBkZXZpY2UgdHJl
ZSB3cml0ZXIgdG8gc2V0IGJvdGggdGhlIFBIWQo+PiBkZWxheSBhbmQgdGhlIE1BQyBkZWxheSwg
YmFzZWQgb24ga25vd2xlZGdlIG9mIHRoZSBib2FyZCwgaW5jbHVkaW5nCj4+IGFueSBraWNrcyBp
biB0aGUgdHJhY2tzLiBUaGUgZHJpdmVyIHNob3VsZCB0aGVuIGRvIHdoYXQgaXQgaXMgdG9sZC4K
Pj4KPiBPcmlnaW5hbGx5LCB3ZSByZWNvbW1lbmQgZXF1YWwgdHJhY2UgbGVuZ3RoIG9uIFBDQiwg
d2hpY2ggbWVhbnMgdGhhdAo+IFJHTUlJIGRlbGF5IGJ5IFBDQiB0cmFjZXMgaXMgbm90IHJlY29t
bWVuZGVkLiBzbyBvbmx5IFBIWS9NQUMgZGVsYXkgaXMKPiB0YWtlbiBpbnRvIGFjY291bnQgaW4g
dGhlIHRyYW5zbWl0L3JlY2VpdmUgcGF0aC4KPiAKPiBhcyB5b3UgZGVzY3JpYmVkIGFib3ZlLCBt
YXliZSB0aGUgZXF1YWwgUENCIHRyYWNlIGxlbmd0aCBhc3N1bXB0aW9uIGlzCj4gbm90IHJlYXNv
bmFibGUsIGFuZCB3ZSdsbCBvbmx5IGhhbmRsZSBNQUMgZGVsYXktcHMgaW4gb3VyIGRyaXZlciBi
YXNlZAo+IG9uIHRoZSBkZXZpY2UgdHJlZSBpbmZvcm1hdGlvbiBubyBtYXR0ZXIgd2hpY2ggcmdt
aWkgaXMgc2VsZWN0ZWQuCgpFeHBlY3RpbmcgaWRlbnRpY2FsIFBDQiB0cmFjZXMgaXMgc29tZXRo
aW5nIHRoYXQgaXMgaGFyZCB0byBlbmZvcmNlIHdpdGgKZXh0ZXJuYWwgY3VzdG9tZXJzLCBmb3Ig
aW50ZXJuYWwgcmVmZXJlbmNlIGJvYXJkcywgYWJzb2x1dGVseSB0aGV5CnNob3VsZCBoYXZlIHRo
b3NlIHRyYWNlcyBvZiBlcXVhbCBsZW5ndGguCgo+IAo+IFNpbmNlIERhdmlkIGFscmVhZHkgYXBw
bGllZCB0aGlzIHBhdGNoLCBJJ2xsIHNlbmQgYW5vdGhlciBwYXRjaCB0byBmaXgKPiB0aGlzIGlz
c3VlLgo+Pj4gKwlpZiAoIW9mX3Byb3BlcnR5X3JlYWRfdTMyKHBsYXQtPm5wLCAibWVkaWF0ZWss
dHgtZGVsYXktcHMiLCAmdHhfZGVsYXlfcHMpKSB7Cj4+PiArCQlpZiAodHhfZGVsYXlfcHMgPCBw
bGF0LT52YXJpYW50LT50eF9kZWxheV9tYXgpIHsKPj4+ICsJCQltYWNfZGVsYXktPnR4X2RlbGF5
ID0gdHhfZGVsYXlfcHM7Cj4+PiArCQl9IGVsc2Ugewo+Pj4gKwkJCWRldl9lcnIocGxhdC0+ZGV2
LCAiSW52YWxpZCBUWCBjbG9jayBkZWxheTogJWRwc1xuIiwgdHhfZGVsYXlfcHMpOwo+Pj4gKwkJ
CXJldHVybiAtRUlOVkFMOwo+Pj4gKwkJfQo+Pj4gKwl9Cj4+PiArCj4+PiArCWlmICghb2ZfcHJv
cGVydHlfcmVhZF91MzIocGxhdC0+bnAsICJtZWRpYXRlayxyeC1kZWxheS1wcyIsICZyeF9kZWxh
eV9wcykpIHsKPj4+ICsJCWlmIChyeF9kZWxheV9wcyA8IHBsYXQtPnZhcmlhbnQtPnJ4X2RlbGF5
X21heCkgewo+Pj4gKwkJCW1hY19kZWxheS0+cnhfZGVsYXkgPSByeF9kZWxheV9wczsKPj4+ICsJ
CX0gZWxzZSB7Cj4+PiArCQkJZGV2X2VycihwbGF0LT5kZXYsICJJbnZhbGlkIFJYIGNsb2NrIGRl
bGF5OiAlZHBzXG4iLCByeF9kZWxheV9wcyk7Cj4+PiArCQkJcmV0dXJuIC1FSU5WQUw7Cj4+PiAr
CQl9Cj4+PiArCX0KPj4+ICsKPj4+ICsJbWFjX2RlbGF5LT50eF9pbnYgPSBvZl9wcm9wZXJ0eV9y
ZWFkX2Jvb2wocGxhdC0+bnAsICJtZWRpYXRlayx0eGMtaW52ZXJzZSIpOwo+Pj4gKwltYWNfZGVs
YXktPnJ4X2ludiA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChwbGF0LT5ucCwgIm1lZGlhdGVrLHJ4
Yy1pbnZlcnNlIik7Cj4+PiArCW1hY19kZWxheS0+ZmluZV90dW5lID0gb2ZfcHJvcGVydHlfcmVh
ZF9ib29sKHBsYXQtPm5wLCAibWVkaWF0ZWssZmluZS10dW5lIik7Cj4+Cj4+IFdoeSBpcyBmaW5l
IHR1bmUgbmVlZGVkPyBJZiB0aGUgcmVxdWVzdGVkIGRlbGF5IGNhbiBiZSBkb25lIHVzaW5nIGZp
bmUKPj4gdHVuZSwgaXQgc2hvdWxkIHVzZSBmaW5lIHR1bmUuIElmIG5vdCwgaXQgc2hvdWxkIHVz
ZSByb3VnaCB0dW5lLiBUaGUKPj4gZHJpdmVyIGNhbiB3b3JrIHRoaXMgb3V0IGl0c2VsZi4KPiAK
PiBmaW5kIHR1bmUgaGVyZSByZXByZXNlbnRzIGEgbW9yZSBhY2N1cmF0ZSBkZWxheSBjaXJjdWl0
IHRoYW4gY29hcnNlCj4gdHVuZSwgYW5kIGl0J3MgYSBwYXJhbGxlbCBjaXJjdWl0IG9mIGNvYXJz
ZSB0dW5lLgo+IEZvciBtb3N0IGRlbGF5LCBib3RoIGZpbmUgYW5kIGNvYXJzZSB0dW5lIGNhbiBt
ZWV0IHRoZSByZXF1aXJlbWVudC4KPiBJdCdzIHVwIHRvIHRoZSB1c2VyIHRvIHNlbGVjdCB3aGlj
aCBvbmUuCj4gCj4gQnV0IG9ubHkgb25lIG9mIHRoZW0gY2FuIHdvcmsgYXQgdGhlIHNhbWUgdGlt
ZSwgc28gd2UgbmVlZCBhIHN3aXRjaAo+IGZsYWcoZmluZV90dW5lIGhlcmUpIHRvIGluZGljYXRl
IHdoaWNoIG9uZSBpcyB2YWxpZC4KPiBEcml2ZXIgY2FuIGhhcmRseSB3b3JrIG91dCB3aGljaCBv
bmUgaXMgd29ya2luZyBhY2NvcmRpbmcgdG8gZGVsYXktcHMuCj4gCj4gUGxlYXNlIGNvcnJlY3Qg
bWUgaWYgYW55IG1pc3VuZGVyc3RhbmRpbmcuCgpZb3UgYXJlIGdpdmluZyBhIGxvdCBvZiBvcHRp
b25zIGZvciB1c2VycyBvZiB0aGlzIEV0aGVybmV0IGNvbnRyb2xsZXIgdG8Kc2hvb3QgdGhlbXNl
bHZlcyBpbiB0aGUgZmVldCBhbmQgc3BlbmQgYSBnb29kIGFtb3VudCBvZiB0aW1lIGRlYnVnZ2lu
Zwp3aHkgdGhlaXIgUkdNSUkgY29ubmVjdGlvbiBpcyBub3QgcmVsaWFibGUgb3IgaGF2ZSB0aW1p
bmcgdmlvbGF0aW9ucy4KLS0gCkZsb3JpYW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
