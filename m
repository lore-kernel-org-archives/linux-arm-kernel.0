Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A20C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E73217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DsNF5AnJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7hsD2HS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E73217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vo1kMDZOppBkSdMxje5djlWJ18Y3osC/pKojsURpTxs=; b=DsNF5AnJsqeV4t
	dLqux4F62Eb+6dsRbIpdEoPhZE+gCuaAwbePiK0U66gmE6tOceCX957jjcWs8WXXipgNSJ6M8EFYL
	bCgHCRI9/9Y13J1RmU1hPk2Uw//8yjVqQdWCugfaoMFqHvDwGL0QDSs8e87LaHyLI5xhNsaptrRy+
	fP1BFZ8oG6kvFXlCMlwgSi71ba3MAZWjRyqhkg2p9bO/anwr4cClHj7OtSuVy2sCAGPzhc96ndvoE
	ro8vn9QQJGbHlBKzBZiOx43eUFaCWW9hz2mqHYFjM3vD+JTJ5xRF97Z9ngn6eJZZ1gABsMMWBSX0m
	3Z1HadaoSpUEvCCJyguQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmzgu-0003PJ-H8; Fri, 25 Jan 2019 11:30:32 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmzgq-0003OD-Lc
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 11:30:31 +0000
Received: by mail-wm1-x341.google.com with SMTP id r24so4585229wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 03:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=sCdp2Rt8P2db7n8Wc/FgdknXH7w2aWs6zOYycWOYUKw=;
 b=D7hsD2HSGukLPUiAdy7pxgVxpTIlbFUspp94Zb1X3ecIViMsWAF3a6dQdKxb16wgSK
 2jJJD1gqPACPdAwYKe67IMrXSiSdgTd+GtUZVmSJjI85YFdc5ruBBREFor0J13cxHvEp
 mik/KbUPn+jlyilaviJf+ZRpZpC2NgsnkWqax8AwGC157ULRioO2BW65g1mTkpJx+2JG
 UdCGw+7Wk5AKrnTygjPCxIz5+k9u+YLpvhXP+S1zJVP0yn8J2+ol714AUW3+c+NT5J/m
 CWMGxGNajjrXdHZBeJvKVGG7q9otj8bUVQoOFHMfPWflfQBzUlbJtFYS/ILRmaUODDTJ
 javw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=sCdp2Rt8P2db7n8Wc/FgdknXH7w2aWs6zOYycWOYUKw=;
 b=sJty4vu7Or9QufoaWeVN480S+0BwJ8VxVy/qagIRxmVzJ9bPoO0/XLZuYb2Mz49yWX
 yJGlZvDe0lCvfDSMX88QgYMCjgGqaQ402GLNo4p0TpBvoiC+JfsWDHheTNMKRBBBBun8
 hecoM9+VxFd6Rg10s5nOCjo+i8L5T08BVLCVqBpIM/F/1tIGmGgiPBVg81Y1/s0YW37T
 eEY5LMWoKDcHVz5Rj3Rn0cxNopXJb028BQiN/55t9UJ95EkLLwYUlGdLXcFqRqzgJbAZ
 qFM3Ye5+PsWOSn/KNtft8H0/9ZgyWtKGyv8/mjRgKuew6894yYpdd9NZONo0/U9reGnX
 OpOw==
X-Gm-Message-State: AJcUukeVk8WZ6bqgA92u7x1FkKixLKWEqcKy/ZP/bdi35tm8pBzM23mz
 SaFRNMPdoiU/yorfEe3WyHo=
X-Google-Smtp-Source: ALg8bN7kx19hKSpc1uuOm4Ioz6PhXpMkVoP20wE7P34Sg70Lt+9UZyYG+elF2rJDrqyKlqIq4GqDHw==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr6491725wmk.149.1548415825578; 
 Fri, 25 Jan 2019 03:30:25 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id p5sm33889642wmh.16.2019.01.25.03.30.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 03:30:25 -0800 (PST)
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
 <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
Date: Fri, 25 Jan 2019 12:30:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_033028_745809_1DA14E80 
X-CRM114-Status: GOOD (  16.48  )
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
Reply-To: christian.koenig@amd.com
Cc: Will Deacon <will.deacon@arm.com>,
 Carsten Haitzler <Carsten.Haitzler@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Daenzer,
 Michel" <Michel.Daenzer@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>, "Huang,
 Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Sean Paul <sean@poorly.run>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gMjUuMDEuMTkgdW0gMDk6NDMgc2NocmllYiBBcmQgQmllc2hldXZlbDoKPiBPbiBUaHUsIDI0
IEphbiAyMDE5IGF0IDE1OjAxLCBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4g
d3JvdGU6Cj4+IE9uIFRodSwgSmFuIDI0LCAyMDE5IGF0IDk6MDAgQU0gQXJkIEJpZXNoZXV2ZWwK
Pj4gPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+IHdyb3RlOgo+Pj4gT24gVGh1LCAyNCBKYW4g
MjAxOSBhdCAxMzozMSwgS29lbmlnLCBDaHJpc3RpYW4KPj4+IDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+IHdyb3RlOgo+Pj4+IEFtIDI0LjAxLjE5IHVtIDEzOjA2IHNjaHJpZWIgQXJkIEJpZXNo
ZXV2ZWw6Cj4+Pj4+IFRoZSBEUk0gZHJpdmVyIHN0YWNrIGlzIGRlc2lnbmVkIHRvIHdvcmsgd2l0
aCBjYWNoZSBjb2hlcmVudCBkZXZpY2VzCj4+Pj4+IG9ubHksIGJ1dCBwZXJtaXRzIGFuIG9wdGlt
aXphdGlvbiB0byBiZSBlbmFibGVkIGluIHNvbWUgY2FzZXMsIHdoZXJlCj4+Pj4+IGZvciBzb21l
IGJ1ZmZlcnMsIGJvdGggdGhlIENQVSBhbmQgdGhlIEdQVSB1c2UgdW5jYWNoZWQgbWFwcGluZ3Ms
Cj4+Pj4+IHJlbW92aW5nIHRoZSBuZWVkIGZvciBETUEgc25vb3BpbmcgYW5kIGFsbG9jYXRpb24g
aW4gdGhlIENQVSBjYWNoZXMuCj4+Pj4+Cj4+Pj4+IFRoZSB1c2Ugb2YgdW5jYWNoZWQgR1BVIG1h
cHBpbmdzIHJlbGllcyBvbiB0aGUgY29ycmVjdCBpbXBsZW1lbnRhdGlvbgo+Pj4+PiBvZiB0aGUg
UENJZSBOb1Nub29wIFRMUCBhdHRyaWJ1dGUgYnkgdGhlIHBsYXRmb3JtLCBvdGhlcndpc2UgdGhl
IEdQVQo+Pj4+PiB3aWxsIHVzZSBjYWNoZWQgbWFwcGluZ3Mgbm9uZXRoZWxlc3MuIE9uIHg4NiBw
bGF0Zm9ybXMsIHRoaXMgZG9lcyBub3QKPj4+Pj4gc2VlbSB0byBtYXR0ZXIsIGFzIHVuY2FjaGVk
IENQVSBtYXBwaW5ncyB3aWxsIHNub29wIHRoZSBjYWNoZXMgaW4gYW55Cj4+Pj4+IGNhc2UuIEhv
d2V2ZXIsIG9uIEFSTSBhbmQgYXJtNjQsIGVuYWJsaW5nIHRoaXMgb3B0aW1pemF0aW9uIG9uIGEK
Pj4+Pj4gcGxhdGZvcm0gd2hlcmUgTm9Tbm9vcCBpcyBpZ25vcmVkIHJlc3VsdHMgaW4gbG9zcyBv
ZiBjb2hlcmVuY3ksIHdoaWNoCj4+Pj4+IGJyZWFrcyBjb3JyZWN0IG9wZXJhdGlvbiBvZiB0aGUg
ZGV2aWNlLiBTaW5jZSB3ZSBoYXZlIG5vIHdheSBvZgo+Pj4+PiBkZXRlY3Rpbmcgd2hldGhlciBO
b1Nub29wIHdvcmtzIG9yIG5vdCwganVzdCBkaXNhYmxlIHRoaXMKPj4+Pj4gb3B0aW1pemF0aW9u
IGVudGlyZWx5IGZvciBBUk0gYW5kIGFybTY0Lgo+Pj4+Pgo+Pj4+PiBDYzogQ2hyaXN0aWFuIEtv
ZW5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4+PiBDYzogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pj4+PiBDYzogRGF2aWQgWmhvdSA8RGF2aWQxLlpo
b3VAYW1kLmNvbT4KPj4+Pj4gQ2M6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4+Pj4+
IENjOiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Cj4+Pj4+IENjOiBNaWNoZWwg
RGFlbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPj4+Pj4gQ2M6IERhdmlkIEFpcmxpZSA8
YWlybGllZEBsaW51eC5pZT4KPj4+Pj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5j
aD4KPj4+Pj4gQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5p
bnRlbC5jb20+Cj4+Pj4+IENjOiBNYXhpbWUgUmlwYXJkIDxtYXhpbWUucmlwYXJkQGJvb3RsaW4u
Y29tPgo+Pj4+PiBDYzogU2VhbiBQYXVsIDxzZWFuQHBvb3JseS5ydW4+Cj4+Pj4+IENjOiBNaWNo
YWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+Cj4+Pj4+IENjOiBCZW5qYW1pbiBIZXJy
ZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+Cj4+Pj4+IENjOiBXaWxsIERlYWNv
biA8d2lsbC5kZWFjb25AYXJtLmNvbT4KPj4+Pj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
aW5mcmFkZWFkLm9yZz4KPj4+Pj4gQ2M6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5j
b20+Cj4+Pj4+IENjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Pgo+Pj4+PiBDYzogZHJpLWRldmVsIDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPgo+
Pj4+PiBSZXBvcnRlZC1ieTogQ2Fyc3RlbiBIYWl0emxlciA8Q2Fyc3Rlbi5IYWl0emxlckBhcm0u
Y29tPgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxA
bGluYXJvLm9yZz4KPj4+PiBUaGUgc3ViamVjdCBsaW5lIHNob3VsZCBwcm9iYWJseSByZWFkICJk
aXNhYmxlIHVuY2FjaGVkLi4uIi4KPj4+Pgo+Pj4gVWdoLCBvZiBjb3Vyc2UgLi4uCj4+Pgo+Pj4+
IFdpdGggdGhhdCBmaXhlZCB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcKPj4+PiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KPj4+Pgo+PiBTYW1lOgo+PiBSZXZp
ZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pgo+IFRo
YW5rcyBhbGwKPgo+IFNob3VsZCBJIHJlc2VuZCB0aGUgcGF0Y2ggd2l0aCB0aGUgc3ViamVjdCBj
b3JyZWN0ZWQ/CgpJIHdpbGwgdXBkYXRlIHRoZSBzdWJqZWN0IGxpbmUgYW5kIHB1c2ggaXQgdXBz
dHJlYW0gdGhyb3VnaCAKZHJtLW1pc2MtbmV4dCBpZiBub2JvZHkgb2JqZWN0cy4KCkNocmlzdGlh
bi4KCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBk
cmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
