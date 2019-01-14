Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9FAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:57:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E9E20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XDhR6VPb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8Uogyfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E9E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BWQsUdSHUZfd/N9FZpfeDuCEzdrL3HGgmtBHUco0LiE=; b=XDhR6VPbsEFAeT
	UhEFBI7KXC9ZumvEwXHEwHNv7iEBcqp9ZmpDzp+wCRel5cAIY6PMO+S2rsviMzy4d9jnzUKeCkVgq
	RzhNe8n0OvnhCxsgMcLG5PnehXaIDn5J0djuTxh3pN5hM/LWpA7oYO8y+3iczK/LN+iO/x427x43/
	fvY6dg8FBJRL1j8jCDxPRogAhmc2+78eD166E5PgV9fuEIKrd+YErqkfEbeSimDyn+FQpQePLZh4L
	wDmaZ0GvD+RlDYeQvcjWecJZeYJUQxqwbxiZ0y/O42JxdA9JtojjZmrl0V8Xy74ZEfLJjpAn14CS+
	5s96K7dsflNUWEp8PQ4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj1nc-0005Wf-B2; Mon, 14 Jan 2019 12:57:04 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj1nY-0005VY-RU
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 12:57:02 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so8807319wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 04:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eE6TJ5VZ3Nk1FjdARea1smiBFbzx1XYTfg4oJ2JGHJs=;
 b=g8UogyfyF0r7CuNlezSUf9iYT+RPRjoDO3uSz6mkbnuX//PjptXFIYAVK7rVeOrQ24
 5nMTLDJRVxI34R3QTHgPQHZe/r5rYJ1EVouM7l+ZQGaIU2hq9N1IG2uiUdOTLV/EQ0yI
 RKztBsreD1gDWBPCG0c+aPZIToZ0LEDFqzkGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eE6TJ5VZ3Nk1FjdARea1smiBFbzx1XYTfg4oJ2JGHJs=;
 b=o7sYqNuD7Qg/oM9oh8H1NeaphrBq3mRuDWxA9CdaVEvZ/qA5og+IlhERX6TNhqIpXt
 9CP0lzr++m83OTTnrSZ9/ILc94nm0zYISX1p+IP/TKExgJseQP6pJqMszFEmP/T35SAL
 lbY05UIQEpMmLzqJYxUiSxK0T62+drG0SRgKvMiEXxlFIKoXq9NRmsXtFWtSoUx7fbwh
 QKUGWuC27AXNwn3OrZIi+saoIY8PDOSapUzUhAvH263sbaWHaypr/cEndXtdKeilP0Ny
 RTLL7gwKVyH4q7T86sziK4A5Ir9uiXTO6VM8IqGBfeWTv+0WmSbY/ICZ/Rvx56v69m8W
 twdw==
X-Gm-Message-State: AJcUukegUpnHmku+TQH8ofR5VkK2gumCqJ0s33M2CL+B46dAma+MxhDc
 InIjW5ieeMp0jxsiIzPiOPRn4A==
X-Google-Smtp-Source: ALg8bN5NhSGY+TVdXYyzaakXfLtjuIvc/XiBQFmC7Emp99x4wNII47joUaHwiYlnjHKyGw4Iw3Eozg==
X-Received: by 2002:a1c:834c:: with SMTP id f73mr11802641wmd.126.1547470617138; 
 Mon, 14 Jan 2019 04:56:57 -0800 (PST)
Received: from [192.168.0.41] (45.70.136.77.rev.sfr.net. [77.136.70.45])
 by smtp.googlemail.com with ESMTPSA id 129sm45849167wmd.18.2019.01.14.04.56.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 04:56:56 -0800 (PST)
Subject: Re: [PATCH v3 0/2] Allwinner A64 timer workaround
To: Samuel Holland <samuel@sholland.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <Mark.Rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <marc.zyngier@arm.com>
References: <20190113021719.46457-1-samuel@sholland.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9738319a-4154-62be-2325-2873dfb326dc@linaro.org>
Date: Mon, 14 Jan 2019 13:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190113021719.46457-1-samuel@sholland.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_045700_907072_3EC942D7 
X-CRM114-Status: GOOD (  20.51  )
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
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTMvMDEvMjAxOSAwMzoxNywgU2FtdWVsIEhvbGxhbmQgd3JvdGU6Cj4gVGhpcyBpcyB0aGUg
dGhpcmQgdmVyc2lvbiBvZiBhIHBhdGNoIHNlcmllcyB0byBmaXggc3lzdGVtIGNsb2NrIGp1bXBz
Cj4gYW5kIG90aGVyIHRpbWVyIGluc3RhYmlsaXR5IG9uIHRoZSBBbGx3aW5uZXIgQTY0IFNvQy4g
SXQgaGFzIG5vdyBiZWVuCj4gdGVzdGVkIGZvciBhIHdlZWssIGFuZCBJJ3ZlIHJlY2VpdmVkIG5v
IHJlcG9ydHMgb2YgZGF0ZSBqdW1wcyB3aXRoIHRoaXMKPiB2ZXJzaW9uLiBTbyB0aGlzIGlzLCBh
cyBmYXIgYXMgSSBjYW4gdGVsbCwgYSBjb21wbGV0ZSB3b3JrYXJvdW5kLgo+IAo+IFNlZSB0aGUg
Y29tbWl0IG1lc3NhZ2VzIGZvciBhIGRldGFpbGVkIGRlc2NyaXB0aW9uIG9mIHRoZSBpc3N1ZSwg
YnV0IHRoZQo+IHN1bW1hcnkgaXMgdGhhdCwgd2hlbiBhIGhpZ2ggY291bnRlciBiaXQgcm9sbHMg
b3ZlciwgaW5kZXRlcm1pbmFuY2UgaW4KPiB0aGUgbG93IGJpdHMgY2F1c2VzIENOVFBDVC9DTlRW
Q1QgYW5kIHRoZWlyIHJlc3BlY3RpdmUgVFZBTCByZWdpc3RlcnMgdG8KPiBqdW1wIGZvcndhcmQg
b3IgYmFja3dhcmQuIEJhY2t3YXJkIGp1bXBzIChvciB0aGUgbmV4dCByZWFkIGFmdGVyIGZvcndh
cmQKPiBqdW1wcykgYXJlIHNvbWV0aW1lcyBzZWVuIGJ5IHRoZSBrZXJuZWwgYW5kIGludGVycHJl
dGVkIGFzIHRoZSB0aW1lcgo+IHdyYXBwaW5nIGFyb3VuZCBhZnRlciAyXjU2IGN5Y2xlcy4gVGhp
cyBjYXVzZXMgdGhlIHN5c3RlbSBjbG9jayB0byBqdW1wCj4gZm9yd2FyZCBhcHByb3hpbWF0ZWx5
IDkxIHllYXJzLgo+IAo+IGNoYW5nZXMgc2luY2UgdjI7Cj4gLSBSZWR1Y2VkIHdvcmthcm91bmQg
dGhyZXNob2xkIGZyb20gMTEgdG8gMTAgYml0cyBiYXNlZCBvbiByZXBvcnRzIGZyb20KPiAgIG90
aGVyIGhhcmRhcmUgYW5kIHRoZSBVLUJvb3QgdmVyc2lvbiBvZiB0aGlzIHdvcmthcm91bmQKPiAt
IEFkZGVkIFRWQUwgaGFuZGxpbmcgYmFzZWQgb24gTWFyYydzIHN1Z2dlc3Rpb24KPiAtIEFkZGVk
IGVycmF0dW0gZG9jdW1lbnRhdGlvbiBhbmQgcmVuYW1lZCBzeW1ib2xzIHRvIG1hdGNoCj4gLSBB
ZGRlZCBNYXhpbWUncyBBY2tlZC1ieQo+IAo+IGNoYW5nZXMgc2luY2UgdjE6Cj4gLSBBZGQgYW4g
aXRlcmF0aW9uIGxpbWl0IGxpa2UgbW9zdCBvdGhlciBhcmNoIHRpbWVyIHdvcmthcm91bmRzCj4g
LSBBZGRlZCBBbmRyZSdzIFRlc3RlZC1ieQo+IAo+IFNhbXVlbCBIb2xsYW5kICgyKToKPiAgIGFy
bTY0OiBhcmNoX3RpbWVyOiBXb3JrYXJvdW5kIGZvciBBbGx3aW5uZXIgQTY0IHRpbWVyIGluc3Rh
YmlsaXR5Cj4gICBhcm02NDogZHRzOiBhbGx3aW5uZXI6IGE2NDogRW5hYmxlIEE2NCB0aW1lciB3
b3JrYXJvdW5kCj4gCj4gIERvY3VtZW50YXRpb24vYXJtNjQvc2lsaWNvbi1lcnJhdGEudHh0ICAg
ICAgICB8ICAyICsKPiAgYXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTBpLWE2NC5k
dHNpIHwgIDEgKwo+ICBkcml2ZXJzL2Nsb2Nrc291cmNlL0tjb25maWcgICAgICAgICAgICAgICAg
ICAgfCAxMCArKysrCj4gIGRyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGltZXIuYyAgICAg
ICAgICB8IDU1ICsrKysrKysrKysrKysrKysrKysKPiAgNCBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNl
cnRpb25zKCspCj4gCgpBcHBsaWVkLiBUb29rIHRoZSBvcHBvcnR1bml0eSB0byBhZGQgdGhlIHN0
YWJsZUAgdGFnLgoKVGhhbmtzCgogIC0tIERhbmllbAoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJv
Lm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoK
Rm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZh
Y2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0
cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
