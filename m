Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94FFC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:15:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B843F21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eHes2Vnq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+M+GeOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B843F21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8+4PT1LK9aApKaIzSIRTAa7+SJpUE5Pf1US1BAbMOuA=; b=eHes2VnqTrgl+w
	rrh600iZizzRaXU1mCgdOp9MVD9LmcfP/yk0psS0WLee9uqytBi6IR2m8nQKu9gOk70mvjB6C1Bds
	ULcMfvVg5WUbVVm5nnwkG+Dz3a6b6/Qshk7P1zm4wPYnusRgkzYYGKxUSXVrhUc57J2A7USUCZFLM
	FYsjckrp6yW4TQI4wV48or6YMawb5cCNofhY0uMqCoX+tehJEzBYA6gSI51Juvp3516pN54zdzJeo
	p8bPXNLNrtv8O4E5qIAmuNxcBnNNIthoBreFoxy2tuWwPW/uQeqFAU+CI8TcKMOyegIAAE8UlvLTU
	4yKY89C6YCyVJU2UH7+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtUAE-0007rv-Er; Tue, 12 Feb 2019 09:15:38 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtUA2-0007jL-JJ
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 09:15:28 +0000
Received: by mail-wr1-x442.google.com with SMTP id t18so1820271wrx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 01:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=naHq3JAsKTQBTMdAufMA9vX5f6pogu5ad5BwYCVfZpY=;
 b=G+M+GeOqid2G2UraPPaIIMYijXMCnETN/+snpEXyLkbO9aOz/hiI+v5xRMAcytpBF5
 KmTjz80ZEpJFfHXRuKTKFtFYISBV4R64LxZmwK+8JEwxncx2vqwkgNGQFEsKmO3lHLLi
 0ThQqLDvy4VdtGGH+Pmwq/eiQhMPExm2xGd2wJg4rxUH+wGnAvd9aphsWRjD8o1IydrN
 SJQbksWYmBgqhnrvMw9PL6nYAFOEZkhK6dT2UwVgiy+8v/rl7N0BIuoRHLyu6DTCEW2n
 /a8ulIIg4JMfdjDad0+d0XNbIHsJP2MWcdTGVX57CTn+30AqC5RNZMgZyEHkz+4/T7nL
 RErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=naHq3JAsKTQBTMdAufMA9vX5f6pogu5ad5BwYCVfZpY=;
 b=g0BOSf3Xs2cqzb9myr3wm4kjw7AXhwXaSwcYw04wzNDJYcMwEI28P5K3RPnNioogEE
 Mno4sWFIww9daYpgeMd9d8vnMSH6l6aTa+VDRBV2eLoRiy5ENdgaplyoMRReQoepPvYn
 JbEEMJP4Sh5+zi4AVVK0zq23uVZ3vBYB5uXC/cjCUa5AP6bEbxoktYTACIodn71BioEw
 UMjCXam/Rc06ccSPKw+sAR8YjhbBZOm8PI4FoypU3UwK1YTtfom5V3itVveQMu1ZewcF
 1OZW3TLqrAkre2+B8FT+oYkqOHXhbz+IRhqBghp4+rWZIrKSmKhn/mIir+S4z9WjLjvf
 ZgPA==
X-Gm-Message-State: AHQUAubaP/IEbAGGrsZ3AssPiufcZS32KdVtK3wI7t62cLRjtrLYLa6h
 ZHjBJSsubYE07GNGOTAOmoM2DA==
X-Google-Smtp-Source: AHgI3IbAwWQgMs6yQy3m8ojm0owzi85MgfvkdRjSHPs06uBnTx/Vdgit+41ejd3NCGfKXFAwIBVz2w==
X-Received: by 2002:adf:8068:: with SMTP id 95mr2063500wrk.181.1549962924472; 
 Tue, 12 Feb 2019 01:15:24 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id v4sm2512202wme.6.2019.02.12.01.15.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 01:15:23 -0800 (PST)
Subject: Re: [PATCH] clocksource/arm_arch_timer: Store physical timer IRQ
 number for KVM on VHE
To: Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org
References: <20190124134612.7487-1-christoffer.dall@arm.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <49f5b2c1-8bbc-9475-e7bb-60857f622357@linaro.org>
Date: Tue, 12 Feb 2019 10:15:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124134612.7487-1-christoffer.dall@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_011526_647108_22B43745 
X-CRM114-Status: GOOD (  24.69  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Andre Przywara <andre.przywara@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjQvMDEvMjAxOSAxNDo0NiwgQ2hyaXN0b2ZmZXIgRGFsbCB3cm90ZToKPiBGcm9tOiBBbmRy
ZSBQcnp5d2FyYSA8YW5kcmUucHJ6eXdhcmFAYXJtLmNvbT4KPiAKPiBBIGhvc3QgcnVubmluZyBp
biBWSEUgbW9kZSBnZXRzIHRoZSBFTDIgcGh5c2ljYWwgdGltZXIgYXMgaXRzIHRpbWUKPiBzb3Vy
Y2UgKGFjY2Vzc2VkIHVzaW5nIHRoZSBFTDEgc3lzcmVnIGFjY2Vzc29ycywgd2hpY2ggZ2V0IHJl
LWRpcmVjdGVkCj4gdG8gdGhlIEVMMiBzeXNyZWdzIGJ5IFZIRSkuCj4gCj4gVGhlIEVMMSBwaHlz
aWNhbCB0aW1lciByZW1haW5zIHVudXNlZCBieSB0aGUgaG9zdCBrZXJuZWwsIGFsbG93aW5nIHVz
IHRvCj4gcGFzcyB0aGF0IG9uIGRpcmVjdGx5IHRvIGEgS1ZNIGd1ZXN0IGFuZCBzYXZlcyB1cyBm
cm9tIGVtdWxhdGluZyB0aGlzCj4gdGltZXIgZm9yIHRoZSBndWVzdCBvbiBWSEUgc3lzdGVtcy4K
PiAKPiBTdG9yZSB0aGUgRUwxIFBoeXNpY2FsIFRpbWVyJ3MgSVJRIG51bWJlciBpbgo+IHN0cnVj
dCBhcmNoX3RpbWVyX2t2bV9pbmZvIG9uIFZIRSBzeXN0ZW1zIHRvIGFsbG93IEtWTSB0byB1c2Ug
aXQuCj4gCj4gU2lnbmVkLW9mZi1ieTogQW5kcmUgUHJ6eXdhcmEgPGFuZHJlLnByenl3YXJhQGFy
bS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWFyYyBaeW5naWVyIDxtYXJjLnp5bmdpZXJAYXJtLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvZmZlciBEYWxsIDxjaHJpc3RvZmZlci5kYWxsQGFy
bS5jb20+Cj4gLS0tCj4gUGF0Y2hlcyBpbiBwcmVwYXJhdGlvbiBmb3IgbmVzdGVkIHZpcnR1YWxp
emF0aW9uIG9uIEtWTS9Bcm0gZGVwZW5kIG9uIHRoaXMKPiBjaGFuZ2UsIHNvIHdlIHdvdWxkIGxp
a2UgdG8gbWVyZ2UgdGhpcyB2aWEgdGhlIGt2bWFybSB0cmVlIG9yIGhhdmUgYSBzdGFibGUKPiBi
cmFuY2ggaW5jbHVkaW5nIHRoaXMgcGF0Y2guCj4gCj4gUGxlYXNlIGxldCB1cyBrbm93IHlvdXIg
cHJlZmVyZW5jZS4gIFRoYW5rcy4KCkhpIENocmlzdG9waGVyLAoKc29ycnkgZm9yIHRoZSBkZWxh
eS4gSSdtIGZpbmUgaWYgeW91IHdhbnQgdG8gdGFrZSBpdCB0aHJvdWdoIHlvdXIgdHJlZS4KCkFj
a2VkLWJ5OiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4KCgoKPiAg
ZHJpdmVycy9jbG9ja3NvdXJjZS9hcm1fYXJjaF90aW1lci5jIHwgMTEgKysrKysrKysrLS0KPiAg
aW5jbHVkZS9jbG9ja3NvdXJjZS9hcm1fYXJjaF90aW1lci5oIHwgIDEgKwo+ICAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGltZXIuYyBiL2RyaXZlcnMvY2xvY2tzb3Vy
Y2UvYXJtX2FyY2hfdGltZXIuYwo+IGluZGV4IDlhN2Q0ZGMwMGI2ZS4uYjkyNDNlMjMyOGI0IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGltZXIuYwo+ICsrKyBi
L2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGltZXIuYwo+IEBAIC0xMjA2LDYgKzEyMDYs
MTMgQEAgc3RhdGljIGVudW0gYXJjaF90aW1lcl9wcGlfbnIgX19pbml0IGFyY2hfdGltZXJfc2Vs
ZWN0X3BwaSh2b2lkKQo+ICAJcmV0dXJuIEFSQ0hfVElNRVJfUEhZU19TRUNVUkVfUFBJOwo+ICB9
Cj4gIAo+ICtzdGF0aWMgdm9pZCBfX2luaXQgYXJjaF90aW1lcl9wb3B1bGF0ZV9rdm1faW5mbyh2
b2lkKQo+ICt7Cj4gKwlhcmNoX3RpbWVyX2t2bV9pbmZvLnZpcnR1YWxfaXJxID0gYXJjaF90aW1l
cl9wcGlbQVJDSF9USU1FUl9WSVJUX1BQSV07Cj4gKwlpZiAoaXNfa2VybmVsX2luX2h5cF9tb2Rl
KCkpCj4gKwkJYXJjaF90aW1lcl9rdm1faW5mby5waHlzaWNhbF9pcnEgPSBhcmNoX3RpbWVyX3Bw
aVtBUkNIX1RJTUVSX1BIWVNfTk9OU0VDVVJFX1BQSV07Cj4gK30KPiArCj4gIHN0YXRpYyBpbnQg
X19pbml0IGFyY2hfdGltZXJfb2ZfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQo+ICB7Cj4g
IAlpbnQgaSwgcmV0Owo+IEBAIC0xMjIwLDcgKzEyMjcsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBh
cmNoX3RpbWVyX29mX2luaXQoc3RydWN0IGRldmljZV9ub2RlICpucCkKPiAgCWZvciAoaSA9IEFS
Q0hfVElNRVJfUEhZU19TRUNVUkVfUFBJOyBpIDwgQVJDSF9USU1FUl9NQVhfVElNRVJfUFBJOyBp
KyspCj4gIAkJYXJjaF90aW1lcl9wcGlbaV0gPSBpcnFfb2ZfcGFyc2VfYW5kX21hcChucCwgaSk7
Cj4gIAo+IC0JYXJjaF90aW1lcl9rdm1faW5mby52aXJ0dWFsX2lycSA9IGFyY2hfdGltZXJfcHBp
W0FSQ0hfVElNRVJfVklSVF9QUEldOwo+ICsJYXJjaF90aW1lcl9wb3B1bGF0ZV9rdm1faW5mbygp
Owo+ICAKPiAgCXJhdGUgPSBhcmNoX3RpbWVyX2dldF9jbnRmcnEoKTsKPiAgCWFyY2hfdGltZXJf
b2ZfY29uZmlndXJlX3JhdGUocmF0ZSwgbnApOwo+IEBAIC0xNTUwLDcgKzE1NTcsNyBAQCBzdGF0
aWMgaW50IF9faW5pdCBhcmNoX3RpbWVyX2FjcGlfaW5pdChzdHJ1Y3QgYWNwaV90YWJsZV9oZWFk
ZXIgKnRhYmxlKQo+ICAJYXJjaF90aW1lcl9wcGlbQVJDSF9USU1FUl9IWVBfUFBJXSA9Cj4gIAkJ
YWNwaV9ndGR0X21hcF9wcGkoQVJDSF9USU1FUl9IWVBfUFBJKTsKPiAgCj4gLQlhcmNoX3RpbWVy
X2t2bV9pbmZvLnZpcnR1YWxfaXJxID0gYXJjaF90aW1lcl9wcGlbQVJDSF9USU1FUl9WSVJUX1BQ
SV07Cj4gKwlhcmNoX3RpbWVyX3BvcHVsYXRlX2t2bV9pbmZvKCk7Cj4gIAo+ICAJLyoKPiAgCSAq
IFdoZW4gcHJvYmluZyB2aWEgQUNQSSwgd2UgaGF2ZSBubyBtZWNoYW5pc20gdG8gb3ZlcnJpZGUg
dGhlIHN5c3JlZwo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Nsb2Nrc291cmNlL2FybV9hcmNoX3Rp
bWVyLmggYi9pbmNsdWRlL2Nsb2Nrc291cmNlL2FybV9hcmNoX3RpbWVyLmgKPiBpbmRleCAzNDll
NTk1N2M5NDkuLjcwMjk2N2Q5OTZiYiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2Nsb2Nrc291cmNl
L2FybV9hcmNoX3RpbWVyLmgKPiArKysgYi9pbmNsdWRlL2Nsb2Nrc291cmNlL2FybV9hcmNoX3Rp
bWVyLmgKPiBAQCAtNzQsNiArNzQsNyBAQCBlbnVtIGFyY2hfdGltZXJfc3BpX25yIHsKPiAgc3Ry
dWN0IGFyY2hfdGltZXJfa3ZtX2luZm8gewo+ICAJc3RydWN0IHRpbWVjb3VudGVyIHRpbWVjb3Vu
dGVyOwo+ICAJaW50IHZpcnR1YWxfaXJxOwo+ICsJaW50IHBoeXNpY2FsX2lycTsKPiAgfTsKPiAg
Cj4gIHN0cnVjdCBhcmNoX3RpbWVyX21lbV9mcmFtZSB7Cj4gCgoKLS0gCiA8aHR0cDovL3d3dy5s
aW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBT
b0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFy
bz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8
CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9nCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
