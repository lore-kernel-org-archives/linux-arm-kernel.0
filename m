Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C82AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:47:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D15A2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mDcVoYrQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e58j5W0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D15A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XU/iUXQMZIAQD5t/j88VVmGONh03j9yCqI9vfiwhpyg=; b=mDcVoYrQH5J+ym
	zLm3RC7MmYdIWAjarw2C5/xs8kQ2HYCSClxuWMcsqvZJl4EScLfilLemnaPr73BJyOic1r26757oG
	xCS303TDBHH88LoPPaGRufR97A2ceKikHJZXkjxnFoR9rYQoO6t9KJwcfuToBL6BdS8vrE2R/zmoS
	QAoJGc3RSjljtJjDBw2Z4lErRy7v75InVQcbH2Z9zKz/3UHXwPIs9GZ3idyeMmBLV4rZriV5+0rfc
	zT8m5Fu6MPbl1VoFQpdbLtKxhe7rpW5oRtA2JpEXHfKc7WhLe0DXkbXSOfQqm3RAUzPrVARZEeCJp
	MitTbnQJ2JXP8XjFNw8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcl8-0002lp-7A; Tue, 11 Dec 2018 07:47:14 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcl4-0002l7-79
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:47:11 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so12995402wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 23:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=4Rm21wiT2xwkpRL/nKWNEA7SX93smuHg4UNbEyGCk1c=;
 b=e58j5W0Y5Zq+ugEJUtS8+SdtzBXxsRHlNrXehdHNATY7EGLuMAbdlxLVp4egcl9aO8
 kysmkgr5y/7tgKPTiTWinuNP8/ZDc3cGRT0EuLcnTO8BDHOqv9iIsFRZwKomWxZX4RyP
 DcJwWKod+cGfcLHpPYZpWReNLlgWnd+w+vgpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=4Rm21wiT2xwkpRL/nKWNEA7SX93smuHg4UNbEyGCk1c=;
 b=QromV4/glxA2+rDxBhlvSIpA4LoVaIQSUeLWwC6vIym4BTXWta5QfDD5wqBOHE8he9
 Rwr5DHTu57XkDh07CQad/pXuLkeflBTpNJidKqFyxe4RaIJQRcu2+bL9XjZc9wB6Fts4
 RtRBbWwJmr2zCh0B4fM249f2TPM5amR7/VLc8h/fk+HC1mBQ7LnvwEL3IISO/eXDJBVS
 VUyRazu8cs02YkKHZ1/6snZBAlwibIUMdHDZ0WdVSmPVEsILXZT+EzsuPPQkLpvceLm9
 JmT3MLeloyT/5S/qkRpUKHnWE7BpfCa0m21hUyAKmYXDKYPvKbaG2Tz1Pc+6mpPQFwkB
 LRRg==
X-Gm-Message-State: AA+aEWZH5OeXiQqnicP464iaTxfjQX+8H1WQT2g4AZyEf27UMmhhhf7u
 cO7dR8+u1y3P1PzaJJUVgx//LA==
X-Google-Smtp-Source: AFSGD/Wz6hfKcKq5o0BXWB6d9XzuSDUCA4v1kLCP6d6SX/2lsPo30tanpir59MzDFQ0KqkK5qohKhQ==
X-Received: by 2002:adf:c888:: with SMTP id k8mr13492292wrh.6.1544514417849;
 Mon, 10 Dec 2018 23:46:57 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com.
 [109.155.202.221])
 by smtp.gmail.com with ESMTPSA id q9sm12825131wrp.0.2018.12.10.23.46.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 23:46:56 -0800 (PST)
Date: Tue, 11 Dec 2018 07:46:54 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [linux-sunxi] [PATCH 0/8] This is a second edition of a series
 that implements voltage
Message-ID: <20181211074654.GF4497@dell>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
 <20181211071137.k3rqwctnibg6tyc2@plaes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211071137.k3rqwctnibg6tyc2@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_234710_262262_6C97F917 
X-CRM114-Status: GOOD (  17.71  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Mark Brown <broonie@kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Olliver Schinagl <oliver@schinagl.nl>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAxMSBEZWMgMjAxOCwgUHJpaXQgTGFlcyB3cm90ZToKCj4gT24gTW9uLCBEZWMgMTAs
IDIwMTggYXQgMDg6NDI6MTFQTSArMDIwMCwgUHJpaXQgTGFlcyB3cm90ZToKPiA+IHJhbXBpbmcg
Zm9yIEFYUDIwOSBEQ0RDMiBhbmQgTERPMyByZWd1bGF0b3JzIGFuZCBzb2Z0d2FyZQo+ID4gYmFz
ZWQgc29mdC1zdGFydCBmb3IgQVhQMjA5IExETzMgcmVndWxhdG9yLgo+IAo+IFVnaC4uIG1hbmFn
ZWQgdG8gYm90Y2ggdGhpcyBzZXJpZXMuIEknbGwgc2VuZCBhIGZpeGVkIG9uZQo+IHRvZGF5LgoK
V2hpbGUgeW91J3JlIGF0IGl0LCBwbGVhc2UgZG9uJ3QgZm9yZ2V0IHRvIGFkZCB0aGUgdmVyc2lv
biBudW1iZXIgaW4KdGhlIHBhdGNoIHN1YmplY3QgbGluZXMuICBFYWNoIHBhdGNoIHNob3VsZCBo
YXZlIHJlYWQgIltQQVRDSCB2Ml0KPC4uLj4iIGluIHRoaXMgc3VibWlzc2lvbi4KCj4gPiBCb3Ro
IGZlYXR1cmVzIGFyZSBuZWVkZWQgdG8gd29yayBhcm91bmQgYSBQTUlDIHNodXRkb3duIHdoZW4K
PiA+IHRvZ2dsaW5nIExETzMgb24gY2VydGFpbiBib2FyZHMgd2l0aCBoaWdoIGNhcGFjaXRhbmNl
IG9uIHRoZQo+ID4gTERPMyBvdXRwdXQuCj4gPiAKPiA+IFNpbWlsYXIgZmVhdHVyZXMgKG9yIHdv
cmthcm91bmRzKSBoYXZlIGJlZW4gYWxzbyBpbXBsZW1lbnRlZAo+ID4gb24gdS1ib290IHNpZGUg
WzFdLgo+ID4gCj4gPiBDaGFuZ2VzIHNpbmNlIHYxOgo+ID4gLSBSZWJhc2VkIG9uIHRvcCBvZiBu
ZXh0IGFuZCBkcm9wcGVkIGFscmVhZHkgbWVyZ2VkIHBhdGNoZXMuCj4gPiAtIERyb3BwZWQgTERP
NCBmdWxsIHJhbmdlIGRldmljZXRyZWUgY2hhbmdlIGZvciBMaW1lMiAocHJldiBwYXRjaCA5KQo+
ID4gICBpbiBmYXZvciBvZiBnZW5lcmFsIHBpbi1iYW5rIHJlZ3VsYXRvciBkZXBlbmRlbmN5IFsy
XS4KPiA+IC0gRml4ZWQgcGF0aHMgaW4gZGV2aWNldHJlZSBiaW5kaW5ncyAocGF0Y2ggMykKPiA+
IC0gQWRkZWQgbm90ZSBhYm91dCBzb2Z0d2FyZSBiYXNlZCBzb2Z0LXN0YXJ0IGZvciBMRE8zIChw
YXRjaCA1KQo+ID4gCj4gPiBbMV0gaHR0cHM6Ly9saXN0cy5kZW54LmRlL3BpcGVybWFpbC91LWJv
b3QvMjAxOC1Ob3ZlbWJlci8zNDg2MTIuaHRtbAo+ID4gWzJdIGh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL3BpcGVybWFpbC9saW51eC1hcm0ta2VybmVsLzIwMTgtRGVjZW1iZXIvNjE4NDU5Lmh0
bWwKPiA+IAo+ID4gT2xsaXZlciBTY2hpbmFnbCAoOCk6Cj4gPiAgIG1mZDogYXhwMjB4OiBuYW1l
IHZvbHRhZ2UgcmFtcGluZyBkZWZpbmUgcHJvcGVybHkKPiA+ICAgcmVndWxhdG9yOiBheHAyMHg6
IGFkZCBzdXBwb3J0IGZvciBzZXRfcmFtcF9kZWxheSBmb3IgQVhQMjA5Cj4gPiAgIGR0LWJpbmRp
bmdzOiBtZmQ6IGF4cDIweDogYWRkIHN1cHBvcnQgZm9yIHJlZ3VsYXRvci1yYW1wLWRlbGF5IGZv
ciBBWFAyMDkKPiA+ICAgcmVndWxhdG9yOiBheHAyMHg6IGFkZCBzb2Z0d2FyZSBiYXNlZCBzb2Z0
X3N0YXJ0IGZvciBBWFAyMDkgTERPMwo+ID4gICBkdC1iaW5kaW5nczogbWZkOiBheHAyMHg6IEFk
ZCBzb2Z0d2FyZSBiYXNlZCBzb2Z0X3N0YXJ0IGZvciBBWFAyMDkgTERPMwo+ID4gICByZWd1bGF0
b3I6IGR0czogZW5hYmxlIHNvZnQtc3RhcnQgYW5kIHJhbXAgZGVsYXkgZm9yIHRoZSBPTGludVhp
bm8gTGltZTIKPiA+ICAgbWZkOiBheHAyMHg6IENsZWFuIHVwIGluY2x1ZGVkIGhlYWRlcnMKPiA+
ICAgbWZkOiBheHAyMHg6IHVzZSBleHBsaWNpdCBiaXQgZGVmaW5lcwo+ID4gCj4gPiAgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9heHAyMHgudHh0IHwgICA5ICstCj4gPiAg
YXJjaC9hcm0vYm9vdC9kdHMvc3VuN2ktYTIwLW9saW51eGluby1saW1lMi5kdHMgIHwgICAyICst
Cj4gPiAgZHJpdmVycy9tZmQvYXhwMjB4LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDEzICstCj4gPiAgZHJpdmVycy9yZWd1bGF0b3IvYXhwMjB4LXJlZ3VsYXRvci5jICAgICAgICAg
ICAgIHwgMTQyICsrKysrKysrKysrKysrKy0KPiA+ICBpbmNsdWRlL2xpbnV4L21mZC9heHAyMHgu
aCAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKy0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDE2
MSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBiYXNlLWNvbW1pdDogMTRj
ZjhjMWQ1YjkwYTBjZjZhOGJhNTFlZjU5ZGI4ZGE4YzdhMjYyMgoKLS0gCkxlZSBKb25lcyBb5p2O
55C85pavXQpMaW5hcm8gU2VydmljZXMgVGVjaG5pY2FsIExlYWQKTGluYXJvLm9yZyDilIIgT3Bl
biBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwg
VHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
