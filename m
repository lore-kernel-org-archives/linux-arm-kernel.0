Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1BEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:38:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD77206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kblozeae";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1XRxbRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD77206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LS7UrBIw59bhvSIOEnNnljxwCDQZdNFbQBhcm3QWUco=; b=kblozeaeC2R8m0
	jPSPk52DM3sSoEUfT5xUSNmEoCjwyXF6kJcFV8DXPZIwhnwk8EcVXsA4uOk5p/Ti5z/b207M5VrWN
	JbsrHVXei99m2nBKUwIv+bllhbI0Vw8pwzQQ1vKmXXKKPd5Nhd7XUiivwvAQR0jdSBiosx3WCjSvg
	SPMHKdJD0wLtZvw6VWa2z8FC3aM1QaGGvBlHBKoCmg7Fp+88TN7Khpo90TmIEmKebeK0euDlOlD50
	jlADKltb+ZV8x+aE2s2456pzep7U2n39HkGp3fS+JZiULeNB01oFdaY1V1T50FmK0iPF98/m4afUS
	Kbx6Rz+h5zVE78RxvSgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grS5u-0007N2-P9; Wed, 06 Feb 2019 18:38:46 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grS5r-0007Md-Gt
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 18:38:45 +0000
Received: by mail-wr1-x443.google.com with SMTP id r2so8707112wrv.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 10:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=MbFwoMgUhiXyNtpcCvwACbIJvZ6c0BECx7NE8js6t78=;
 b=H1XRxbRwgKVCQ9Ljq7xEvqlKpI9UNcQiipOfDNSMhGASAcMrPpX4Rhm1Uc4kbpT5nw
 VzjWXdaPNmf+BLQukVHJ6+qlL/K3fv292cTnwDAebRxC7HSdrwt50bPhnZN2YRlquMTV
 vzU9tGj44JzCdu1G16BNdAYawMGb1oaw1PIj4K+OyJADV3iDYbxfV3fbyW0Zk2jByITh
 ZRVoQ9O+tArQeKIHy0OR2q4VcdwUfW6rR9Ib9klteFLMduJTWlwpkm0ViogBaHVYjxzT
 vCDwYFNCCM9WsrvNbfZSxdOCqKgg3jpN8xPC1J2mPVu5a/2IrvrkqpqDAZWlSFL88DLS
 PtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=MbFwoMgUhiXyNtpcCvwACbIJvZ6c0BECx7NE8js6t78=;
 b=YTONBYayHoZ3u0YZW7/dxIXslkDhfoSCAIL3QRhK9BiIj8OCPSM/p29aNxEz2lCy/U
 pB0/4v4fNY1Nq/tTG4rfUSB51ZMCXkrXYHHvCfipd2JoPTZSYGiXpgqrCPRG4EM5+muj
 Pt/G+BbFOalG/Ang4ItWioTpOMIyzWQXYPvaHF0LD1g2fYJYnnjPl1uFWW2LhiN4De5b
 7o35SjOOJKCsdnZNO10qACe5HhDDn+BYLo6mqHDFF5EdE1bvHfCv12Br1QVGTyKZNClB
 4aC4bCsbknOHrcpIWWDlotwco0Jux7RlRwrikmff0SMshncYUk92zS9RWck+wgTilgnA
 JiHA==
X-Gm-Message-State: AHQUAuayyuOOyCOyk3pH39jpQ6sD3qd5p2kw5ZzkRjBh5fw4xt5CgSq9
 iMJm+UeASIihtf0k+7JSOYY=
X-Google-Smtp-Source: AHgI3IbiyIjOuNw8QTjdk18aVp2glLugGCAMBpzpPvstKZLHP58L23nP4fiH/iuwPY5Xk4B5ckpFuQ==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr8863806wrr.201.1549478321369; 
 Wed, 06 Feb 2019 10:38:41 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t12sm9151887wra.63.2019.02.06.10.38.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Feb 2019 10:38:40 -0800 (PST)
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "Koenig, Christian" <christian.koenig@amd.com>
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
 <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
 <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
 <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
 <CAKv+Gu-4=1r8X8BUvRjcTwgxj=sZpZLyY3ABBZyzh-RsSm1eXg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f6bdd647-722b-8145-92d4-3f6c52f8a74c@gmail.com>
Date: Wed, 6 Feb 2019 19:38:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-4=1r8X8BUvRjcTwgxj=sZpZLyY3ABBZyzh-RsSm1eXg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_103843_555129_45A31DFB 
X-CRM114-Status: GOOD (  16.88  )
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
Cc: "Daenzer, Michel" <Michel.Daenzer@amd.com>,
 Carsten Haitzler <Carsten.Haitzler@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>, "Huang,
 Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Sean Paul <sean@poorly.run>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gMDYuMDIuMTkgdW0gMTg6MjMgc2NocmllYiBBcmQgQmllc2hldXZlbDoKPiBPbiBGcmksIDI1
IEphbiAyMDE5IGF0IDExOjM1LCBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGluYXJv
Lm9yZz4gd3JvdGU6Cj4+IE9uIEZyaSwgMjUgSmFuIDIwMTkgYXQgMTI6MzAsIENocmlzdGlhbiBL
w7ZuaWcKPj4gPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPj4+IEFt
IDI1LjAxLjE5IHVtIDA5OjQzIHNjaHJpZWIgQXJkIEJpZXNoZXV2ZWw6Cj4+Pj4gT24gVGh1LCAy
NCBKYW4gMjAxOSBhdCAxNTowMSwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+
IHdyb3RlOgo+Pj4+PiBPbiBUaHUsIEphbiAyNCwgMjAxOSBhdCA5OjAwIEFNIEFyZCBCaWVzaGV1
dmVsCj4+Pj4+IDxhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnPiB3cm90ZToKPj4+Pj4+IE9uIFRo
dSwgMjQgSmFuIDIwMTkgYXQgMTM6MzEsIEtvZW5pZywgQ2hyaXN0aWFuCj4+Pj4+PiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPiB3cm90ZToKPj4+Pj4+PiBBbSAyNC4wMS4xOSB1bSAxMzowNiBz
Y2hyaWViIEFyZCBCaWVzaGV1dmVsOgo+Pj4+Pj4+PiBUaGUgRFJNIGRyaXZlciBzdGFjayBpcyBk
ZXNpZ25lZCB0byB3b3JrIHdpdGggY2FjaGUgY29oZXJlbnQgZGV2aWNlcwo+Pj4+Pj4+PiBvbmx5
LCBidXQgcGVybWl0cyBhbiBvcHRpbWl6YXRpb24gdG8gYmUgZW5hYmxlZCBpbiBzb21lIGNhc2Vz
LCB3aGVyZQo+Pj4+Pj4+PiBmb3Igc29tZSBidWZmZXJzLCBib3RoIHRoZSBDUFUgYW5kIHRoZSBH
UFUgdXNlIHVuY2FjaGVkIG1hcHBpbmdzLAo+Pj4+Pj4+PiByZW1vdmluZyB0aGUgbmVlZCBmb3Ig
RE1BIHNub29waW5nIGFuZCBhbGxvY2F0aW9uIGluIHRoZSBDUFUgY2FjaGVzLgo+Pj4+Pj4+Pgo+
Pj4+Pj4+PiBUaGUgdXNlIG9mIHVuY2FjaGVkIEdQVSBtYXBwaW5ncyByZWxpZXMgb24gdGhlIGNv
cnJlY3QgaW1wbGVtZW50YXRpb24KPj4+Pj4+Pj4gb2YgdGhlIFBDSWUgTm9Tbm9vcCBUTFAgYXR0
cmlidXRlIGJ5IHRoZSBwbGF0Zm9ybSwgb3RoZXJ3aXNlIHRoZSBHUFUKPj4+Pj4+Pj4gd2lsbCB1
c2UgY2FjaGVkIG1hcHBpbmdzIG5vbmV0aGVsZXNzLiBPbiB4ODYgcGxhdGZvcm1zLCB0aGlzIGRv
ZXMgbm90Cj4+Pj4+Pj4+IHNlZW0gdG8gbWF0dGVyLCBhcyB1bmNhY2hlZCBDUFUgbWFwcGluZ3Mg
d2lsbCBzbm9vcCB0aGUgY2FjaGVzIGluIGFueQo+Pj4+Pj4+PiBjYXNlLiBIb3dldmVyLCBvbiBB
Uk0gYW5kIGFybTY0LCBlbmFibGluZyB0aGlzIG9wdGltaXphdGlvbiBvbiBhCj4+Pj4+Pj4+IHBs
YXRmb3JtIHdoZXJlIE5vU25vb3AgaXMgaWdub3JlZCByZXN1bHRzIGluIGxvc3Mgb2YgY29oZXJl
bmN5LCB3aGljaAo+Pj4+Pj4+PiBicmVha3MgY29ycmVjdCBvcGVyYXRpb24gb2YgdGhlIGRldmlj
ZS4gU2luY2Ugd2UgaGF2ZSBubyB3YXkgb2YKPj4+Pj4+Pj4gZGV0ZWN0aW5nIHdoZXRoZXIgTm9T
bm9vcCB3b3JrcyBvciBub3QsIGp1c3QgZGlzYWJsZSB0aGlzCj4+Pj4+Pj4+IG9wdGltaXphdGlv
biBlbnRpcmVseSBmb3IgQVJNIGFuZCBhcm02NC4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gQ2M6IENocmlz
dGlhbiBLb2VuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+Pj4+Pj4gQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4+Pj4+Pj4gQ2M6IERhdmlkIFpo
b3UgPERhdmlkMS5aaG91QGFtZC5jb20+Cj4+Pj4+Pj4+IENjOiBIdWFuZyBSdWkgPHJheS5odWFu
Z0BhbWQuY29tPgo+Pj4+Pj4+PiBDYzogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29t
Pgo+Pj4+Pj4+PiBDYzogTWljaGVsIERhZW56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Cj4+
Pj4+Pj4+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4+Pj4+Pj4+IENjOiBE
YW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4+Pj4+Pj4+IENjOiBNYWFydGVuIExhbmto
b3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPgo+Pj4+Pj4+PiBDYzogTWF4
aW1lIFJpcGFyZCA8bWF4aW1lLnJpcGFyZEBib290bGluLmNvbT4KPj4+Pj4+Pj4gQ2M6IFNlYW4g
UGF1bCA8c2VhbkBwb29ybHkucnVuPgo+Pj4+Pj4+PiBDYzogTWljaGFlbCBFbGxlcm1hbiA8bXBl
QGVsbGVybWFuLmlkLmF1Pgo+Pj4+Pj4+PiBDYzogQmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVu
aEBrZXJuZWwuY3Jhc2hpbmcub3JnPgo+Pj4+Pj4+PiBDYzogV2lsbCBEZWFjb24gPHdpbGwuZGVh
Y29uQGFybS5jb20+Cj4+Pj4+Pj4+IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVh
ZC5vcmc+Cj4+Pj4+Pj4+IENjOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPgo+
Pj4+Pj4+PiBDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4K
Pj4+Pj4+Pj4gQ2M6IGRyaS1kZXZlbCA8ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4K
Pj4+Pj4+Pj4gUmVwb3J0ZWQtYnk6IENhcnN0ZW4gSGFpdHpsZXIgPENhcnN0ZW4uSGFpdHpsZXJA
YXJtLmNvbT4KPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVz
aGV1dmVsQGxpbmFyby5vcmc+Cj4+Pj4+Pj4gVGhlIHN1YmplY3QgbGluZSBzaG91bGQgcHJvYmFi
bHkgcmVhZCAiZGlzYWJsZSB1bmNhY2hlZC4uLiIuCj4+Pj4+Pj4KPj4+Pj4+IFVnaCwgb2YgY291
cnNlIC4uLgo+Pj4+Pj4KPj4+Pj4+PiBXaXRoIHRoYXQgZml4ZWQgdGhlIHBhdGNoIGlzIFJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnCj4+Pj4+Pj4gPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4uCj4+Pj4+Pj4KPj4+Pj4gU2FtZToKPj4+Pj4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4+Pj4KPj4+PiBUaGFua3MgYWxsCj4+Pj4KPj4+
PiBTaG91bGQgSSByZXNlbmQgdGhlIHBhdGNoIHdpdGggdGhlIHN1YmplY3QgY29ycmVjdGVkPwo+
Pj4gSSB3aWxsIHVwZGF0ZSB0aGUgc3ViamVjdCBsaW5lIGFuZCBwdXNoIGl0IHVwc3RyZWFtIHRo
cm91Z2gKPj4+IGRybS1taXNjLW5leHQgaWYgbm9ib2R5IG9iamVjdHMuCj4+Pgo+PiBXb25kZXJm
dWwsIHRoYW5rcy4KPiBIaSBDaHJpc3RpYW4sCj4KPiBBcmUgeW91IHN0aWxsIHBsYW5uaW5nIHRv
IG1lcmdlIHRoaXMgZm9yIHY1LjE/CgpNeSBiYWQsIG9ubHkgcHVzaGVkIHRoaXMgdG8gb3VyIGlu
dGVybmFsIGJyYW5jaCwgYnV0IGZvcmdvdCBvdXQgCmRybS1taXNjLW5leHQuCgpGaXhlZCBub3cs
IHRoYW5rcyBmb3IgdGhlIHJlbWluZGVyLgoKQ2hyaXN0aWFuLgoKPgo+IFRoYW5rcywKPiBBcmQu
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
