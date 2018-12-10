Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6782C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:27:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FAF205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fbPEFxfI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfrxoLjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FAF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lf5SYciSmCImklb5gGS+cWUKTq3a7KFD1GAvNGy6Wxk=; b=fbPEFxfI9O2/H0
	9IRNaavHYd/HBg53y8oh8/iQRz+VhyLu01SHxcn18pz/HvwaYNp3uPOEENbhGUTZHTolC1RMVoOIP
	dapqm1GCEs17DXTrGMr0XrMIGhBq9eHMMTdHZXT+Lbmgmdh83FGuaUwaFk+RdKZbBmeqljYjTCZeR
	54V+dJtwYeLyzapPEhS+Nk+alPYkxVZWP4KViGZOCT/HDbl+B3CL8nvn9q+rVibM44+ThyFqcUmxy
	WR1emsCQx5+D+pph5CSPpfzM18bFwZy7uomaD+RtB5WeMgArukRjMwPNVGS3CUcR81cmnshsgdDoJ
	cEbSWoYmFI73VrBKZe9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWF2S-0004j8-Ct; Mon, 10 Dec 2018 06:27:32 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWF2P-0004i7-Ed
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 06:27:30 +0000
Received: by mail-wm1-x344.google.com with SMTP id m22so9917747wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 22:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=2PELzzroORYeHOg/chz31p17911EI6xKHpBZH2713G0=;
 b=IfrxoLjp+TWvaGp+JCyqyc6meCpHbs0nhnIaPFGs0BucQ0w38ivBUwSfZJ8GBeK0q/
 ubsI/2fxyH2aOgpI89/7Hzx4KtHjq9kf0QAywxZtPtyF6H6a2t1xxabOXRSC8Jtk8nNO
 uWny2z/QLv+KuK7oWlWc3w8RzvdQFTsFgMtbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=2PELzzroORYeHOg/chz31p17911EI6xKHpBZH2713G0=;
 b=UoutrSxzMG/d2UtwRj5RiqhLNwtv2mlCGVxLb7tH3kFPYWWmAsSSaQFV+5lszKqg74
 EGjbsL4uGFLiYCNYOtfAlRvfsNe9t9NTmpphbOVAauWfhiUT9UHmorKgDMSCdU+znOsp
 VNMfG4Eiu9iVYbs/ZtYygCs1+eHHY/dLEEtVbwaipGiorkzBCf2ZtoLv6NqLo8lTlpuM
 bnQ8NvCj3AQftgltU6z1WOS3iC0k0/v0QyyJE1KQ1MNZyyJSzp/26vzRMm9L664d+W0x
 mfFGFUwbIwl1nMRpY7nAIZYmIOzD5rM4hP/nIC38g3C/HL6opxyEgxWgPXFCZneqgxkc
 bwQQ==
X-Gm-Message-State: AA+aEWYda22l+ok38GtRbNEzrh4mb4+DV+3kSF7XsRj/vCUf3hCVq8rX
 xhUVUcaeP6cgBU0TgbkqTIJEVQ==
X-Google-Smtp-Source: AFSGD/UEZqFHqxnczTuX1+GOSXHNWxT1E2vtYTnL7Upj1jE4ZHRTUEL+++W8+wjv/iczAXHIKeRUmA==
X-Received: by 2002:a1c:4046:: with SMTP id n67mr8876909wma.123.1544423237463; 
 Sun, 09 Dec 2018 22:27:17 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com.
 [109.155.202.221])
 by smtp.gmail.com with ESMTPSA id a18sm12075050wrp.13.2018.12.09.22.27.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 22:27:16 -0800 (PST)
Date: Mon, 10 Dec 2018 06:27:18 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181210062718.GO26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
 <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
 <20181207192237.GK26661@dell>
 <20181208150526.uceviwfwqskfwovm@qschulz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181208150526.uceviwfwqskfwovm@qschulz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_222729_513834_054801D0 
X-CRM114-Status: GOOD (  21.82  )
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
 devicetree <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU2F0LCAwOCBEZWMgMjAxOCwgUXVlbnRpbiBTY2h1bHogd3JvdGU6Cgo+IEhpIExlZSwKPiAK
PiBPbiBGcmksIERlYyAwNywgMjAxOCBhdCAwNzoyMjozN1BNICswMDAwLCBMZWUgSm9uZXMgd3Jv
dGU6Cj4gPiBPbiBGcmksIDA3IERlYyAyMDE4LCBWYXNpbHkgS2hvcnV6aGljayB3cm90ZToKPiA+
IAo+ID4gPiBPbiBGcmksIERlYyA3LCAyMDE4IGF0IDg6NDAgQU0gTGVlIEpvbmVzIDxsZWUuam9u
ZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4gPiA+IAo+ID4gPiA+IE15IE9DRC1kYXIgaXMgZ29pbmcg
Y3JhenkuCj4gPiA+ID4KPiA+ID4gPiBXaHkgaGF2ZW4ndCB5b3UgdXNlZCB0aGUgc2FtZSBhbGln
bm1lbnQgYXMgaXMgYWxyZWFkeSB0aGVyZT8KPiA+ID4gPgo+ID4gPiA+IElmIGl0IHN0YXJ0cyB0
byBydW4gb3ZlciA4MC1jaGFycyB0aGVuIGJyaW5nIHRoZSBvdGhlcnMgYmFjay4KPiA+ID4gPgo+
ID4gPiA+IEFsc28gd2h5IGlzIHRoZXJlIGEgc2luZ2xlIGxpbmVyIHNob3ZlZCBpbiB0aGUgbWlk
ZGxlIG9mIHRoZQo+ID4gPiA+IG11bHRpLWxpbmUgZW50cmllcz8gIFBsZWFzZSBtb3ZlIHRoZSBz
aW5nbGVzIHRvIHRoZSB0b3Agb3IgdGhlCj4gPiA+ID4gYm90dG9tLgo+ID4gPiAKPiA+ID4gSGkg
TGVlLAo+ID4gPiAKPiA+ID4gQ291bGQgeW91IHBsZWFzZSByZWZvcm1hdCBpdCBpbiB0aGUgd2F5
IHRoYXQgbWFrZXMgeW91ciBPQ0QtZGFyIGhhcHB5Pwo+ID4gPiBJdCB3b3VsZCBiZSByZWFsbHkg
bmljZSB0byBnZXQKPiA+IAo+ID4gSSdtIGFmcmFpZCBub3QsIGZvciBhIG11bHRpdHVkZSBvZiBy
ZWFzb25zLgo+ID4gCj4gPiBUaGUgbW9zdCBpbXBvcnRhbnQgb2Ygd2hpY2ggc3Vycm91bmQgdGVz
dGluZy4KPiA+IAo+ID4gPiBBQyBhbmQgYmF0dGVyeSBzdXBwb3J0IGZvciBBUFg4eDMgbWVyZ2Vk
IC0tIGl0J2xsIG1ha2UgUGluZWJvb2sgYW5kCj4gPiA+IFRlcmVzLUkgcHJldHR5IHdlbGwgc3Vw
cG9ydGVkIGJ5IG1haW5saW5lIGtlcm5lbC4KPiA+IAo+ID4gVGhhdCdzIGdyZWF0LiAgQSB3b3J0
aHkgY2F1c2UgaW5kZWVkLiAgU28gSSdtIHN1cmUgeW91IGd1eXMgd2lsbCB3YW50Cj4gPiB0byB0
dXJuIHRoZSBwYXRjaCBhcm91bmQgaW4gc2hvcnQgb3JkZXIgc28gdGhhdCBpdCdzIGFwcGxpZWQg
aW4gdGltZQo+ID4gZm9yIHRoZSBuZXh0IG1lcmdlIHdpbmRvdy4KPiA+IAo+IAo+IEFyZW4ndCB0
aGUgTUZEIGNlbGxzIHByb2JlZCBpbiBvcmRlcj8KPiAKPiBJbiB0aGF0IGNhc2UsIGl0IG1ha2Vz
IGxpdHRsZSBzZW5zZSB0byBzaG9ydCBvcmRlciB0aGVtIGZvciB0aGlzCj4gcGFydGljdWxhciBk
ZXZpY2UgKFgtUG93ZXJzIFBNSUNzIGluIGdlbmVyYWwpLiBJdCB3aWxsIGp1c3QgbWFrZSB0aGUK
PiBzeXN0ZW0gYm9vdCBzbG93ZXIgYmVjYXVzZSBvZiBwcm9iZSBkZWZlcnJpbmcuCj4gCj4gV2h5
PyBBcyBleHBsYWluZWQgYnkgQ2hlbi1ZdSBpbiB2M1sxXSwgYXhwLWdwaW9zIGNhbiBiZSBtdXhl
ZCBhcwo+IHJlZ3VsYXRvcnMsIHRodXMgc2hvdWxkIGJlIHByb2JlZCBiZWZvcmUgYXhwLXJlZ3Vs
YXRvcnMuIGF4cC1hZGMgaXMKPiBvZnRlbiB1c2VkIGJ5IGF4cC1iYXR0ZXJ5LCBheHAtdXNiLXBv
d2VyLCBheHAtYWMtcG93ZXIsIHRodXMgc2hvdWxkIGJlCj4gcHJvYmVkIGJlZm9yZWhhbmQgYXMg
d2VsbC4KCklmIHRoZXJlIGFyZSBpbnRlci1kZXBlbmRlbmNpZXMgYmV0d2VlbiB0aGUgZGV2aWNl
cywgaXQgbWFrZXMgc2Vuc2UgdG8Ka2VlcCB0aGVtIGluIHRoZSBtb3N0IGVmZmljaWVudCBvcmRl
ci4KCj4gRm9yIHRoZSBhbGlnbm1lbnQgdGhhdCBhbHNvIHRyaWdnZXJlZCB5b3VyIE9DRCwgSSBj
YW4gc2VuZCB5b3UgYSBwYXRjaAo+IHRoZSBkYXkgeW91IG1lcmdlIHRoaXMgb25lIGlmIGl0IGNh
biBoZWxwLiBJIHNlbnQgYSBmZXcgcGF0Y2hlcyBmb3IgdGhpcwo+IGRyaXZlciB0aGF0IGRpZG4n
dCByZXNwZWN0IHRoZSBhbGlnbm1lbnQgc28gSSdtIGZpbmUgZml4aW5nIHRoZSBtZmQKPiBjZWxs
cyAoYW5kIGV2ZW50dWFsbHkgcmUtb3JkZXIgdGhlbSBhcyBJIHNhdyBhIGZldyBheHAtZ3BpbyBj
ZWxscyBiZWluZwo+IGRlY2xhcmVkIGFmdGVyIGF4cC1yZWd1bGF0b3JzKS4KClRoYXQncyBmaW5l
LiAgUGxlYXNlIHNlbmQgdGhlIHBhdGNoIChiYXNlZCBvbiB0aGlzIHNldCkgcmlnaHQgYXdheS4K
Cj4gRG9lcyB0aGF0IG1ha2UgdGhpcyBwYXRjaCBPSyBmb3IgeW91LCBMZWU/CgpZZXMsIHRoYW5r
IHlvdS4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNlcnZpY2VzIFRlY2huaWNh
bCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpG
b2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
