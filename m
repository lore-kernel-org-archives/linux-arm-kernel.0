Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8295C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:35:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D0D20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YvHWB3dl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="emJ9u6a1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D0D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NUPoX7GRD9C+o/fsrCsvBE67+Z7rpuKVFD86FRD03Eo=; b=YvHWB3dl88adIO
	+fZp79jgbA1Q1EX+LHGldHvnXGaB/7uVeiXLzWvdcwxntsTEbOSbqAgyaxBC/RvgViCTweK7ajOli
	B/AaNPJC16T2mUCHN4e5Ojaz9D1kMHs+MWKybEHkqadhMTvi10gvgsijoCVP/hnXWdyk7SIxLWbCm
	KzhbOeqY0mf5Zco3rc48bsyF3Ly9RQ7z6vmVMxV6QuIxFkzFP7TYf2vJZb8dkuVdsL1zsZ5Hre+iU
	qWPfrAn+I6zZZv175QVGZN7qJaJz4mXrrmbKnajvhfHgvywORMuVQeu+/fwGhlcVvJqBOfxq7mP0c
	nTSx2OuAzl4xJirYzWEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmzlk-0005f2-0L; Fri, 25 Jan 2019 11:35:32 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmzlf-0005eF-ME
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 11:35:29 +0000
Received: by mail-io1-xd41.google.com with SMTP id g8so7483801iok.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 03:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nn+Y4BDli85gEwW52CB+Hh6jofOIMP62VBfWfG1RY9g=;
 b=emJ9u6a13A1rLyU0WB9Ua7welEclT08Ok0zJAa5ovpuR4OGeA9w+klGPXVUpRilk9e
 jIYOle+39wjrJ2PJ37FRtNBb4IAy0USytvFjJiCApRje4XXsXePBbR6Q1pRIIPH/pHbB
 5110GDt00gVgX9gBRsSdpZvNKYp7owFOJLGl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nn+Y4BDli85gEwW52CB+Hh6jofOIMP62VBfWfG1RY9g=;
 b=PMoeFhFf1DBrngTho2UKaBoONK/9DUw3Qe+22PAhFBlE5dZ7qzxSCoelKeDDlYKibX
 hOF6CAuYIu6Xa3bYb9v9kHNaAovqPFKFWwhO0mISKp5I6my+vC29X5U2CUgW1zAb3tHV
 /PP1MOyNt6D77xcQ4MHLML8GmbZsBYZbXcWMcwsR/SxMHe53aQlc4gSkrndMghIzZ7MT
 D9D9SuNJE2iKYX5tLQfBLrJWMcSzEZXjbpawbUcobGaUBz8pqQMmbsiBVMLmYFHWCOnC
 sFj4+AQ45PH8BiBHo8nTkjOY8g7Bgz5vHNHNnri3QjeaC/4J7VBr34J6qq97zK36U9bL
 XFkA==
X-Gm-Message-State: AHQUAubxfa5TmOc7p+GBqiyinqRQlp6OhElDqajO4I8QL0wpY5x9AvJy
 wsbXFLMNZde5jjRn8z4TULgOFcMCU1igghEnXU1I0Q==
X-Google-Smtp-Source: AHgI3Ib+V2u0DO8sOa15l5eCPhPHyg4MewLUuHkReHfAD0iekOXM/4Ieh7vAEhRmhhOhuWx+50qj/HgOV/EBV8dGotU=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr1776787iop.60.1548416126221;
 Fri, 25 Jan 2019 03:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
 <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
 <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
In-Reply-To: <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 25 Jan 2019 12:35:15 +0100
Message-ID: <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To: "Koenig, Christian" <christian.koenig@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_033527_730809_628C0AC2 
X-CRM114-Status: GOOD (  17.21  )
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
Cc: Will Deacon <will.deacon@arm.com>,
 Carsten Haitzler <Carsten.Haitzler@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>, David Airlie <airlied@linux.ie>,
 "Daenzer, Michel" <Michel.Daenzer@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, "Zhang, Jerry" <Jerry.Zhang@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyNSBKYW4gMjAxOSBhdCAxMjozMCwgQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gQW0gMjUuMDEuMTkgdW0gMDk6NDMg
c2NocmllYiBBcmQgQmllc2hldXZlbDoKPiA+IE9uIFRodSwgMjQgSmFuIDIwMTkgYXQgMTU6MDEs
IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToKPiA+PiBPbiBUaHUs
IEphbiAyNCwgMjAxOSBhdCA5OjAwIEFNIEFyZCBCaWVzaGV1dmVsCj4gPj4gPGFyZC5iaWVzaGV1
dmVsQGxpbmFyby5vcmc+IHdyb3RlOgo+ID4+PiBPbiBUaHUsIDI0IEphbiAyMDE5IGF0IDEzOjMx
LCBLb2VuaWcsIENocmlzdGlhbgo+ID4+PiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPiB3cm90
ZToKPiA+Pj4+IEFtIDI0LjAxLjE5IHVtIDEzOjA2IHNjaHJpZWIgQXJkIEJpZXNoZXV2ZWw6Cj4g
Pj4+Pj4gVGhlIERSTSBkcml2ZXIgc3RhY2sgaXMgZGVzaWduZWQgdG8gd29yayB3aXRoIGNhY2hl
IGNvaGVyZW50IGRldmljZXMKPiA+Pj4+PiBvbmx5LCBidXQgcGVybWl0cyBhbiBvcHRpbWl6YXRp
b24gdG8gYmUgZW5hYmxlZCBpbiBzb21lIGNhc2VzLCB3aGVyZQo+ID4+Pj4+IGZvciBzb21lIGJ1
ZmZlcnMsIGJvdGggdGhlIENQVSBhbmQgdGhlIEdQVSB1c2UgdW5jYWNoZWQgbWFwcGluZ3MsCj4g
Pj4+Pj4gcmVtb3ZpbmcgdGhlIG5lZWQgZm9yIERNQSBzbm9vcGluZyBhbmQgYWxsb2NhdGlvbiBp
biB0aGUgQ1BVIGNhY2hlcy4KPiA+Pj4+Pgo+ID4+Pj4+IFRoZSB1c2Ugb2YgdW5jYWNoZWQgR1BV
IG1hcHBpbmdzIHJlbGllcyBvbiB0aGUgY29ycmVjdCBpbXBsZW1lbnRhdGlvbgo+ID4+Pj4+IG9m
IHRoZSBQQ0llIE5vU25vb3AgVExQIGF0dHJpYnV0ZSBieSB0aGUgcGxhdGZvcm0sIG90aGVyd2lz
ZSB0aGUgR1BVCj4gPj4+Pj4gd2lsbCB1c2UgY2FjaGVkIG1hcHBpbmdzIG5vbmV0aGVsZXNzLiBP
biB4ODYgcGxhdGZvcm1zLCB0aGlzIGRvZXMgbm90Cj4gPj4+Pj4gc2VlbSB0byBtYXR0ZXIsIGFz
IHVuY2FjaGVkIENQVSBtYXBwaW5ncyB3aWxsIHNub29wIHRoZSBjYWNoZXMgaW4gYW55Cj4gPj4+
Pj4gY2FzZS4gSG93ZXZlciwgb24gQVJNIGFuZCBhcm02NCwgZW5hYmxpbmcgdGhpcyBvcHRpbWl6
YXRpb24gb24gYQo+ID4+Pj4+IHBsYXRmb3JtIHdoZXJlIE5vU25vb3AgaXMgaWdub3JlZCByZXN1
bHRzIGluIGxvc3Mgb2YgY29oZXJlbmN5LCB3aGljaAo+ID4+Pj4+IGJyZWFrcyBjb3JyZWN0IG9w
ZXJhdGlvbiBvZiB0aGUgZGV2aWNlLiBTaW5jZSB3ZSBoYXZlIG5vIHdheSBvZgo+ID4+Pj4+IGRl
dGVjdGluZyB3aGV0aGVyIE5vU25vb3Agd29ya3Mgb3Igbm90LCBqdXN0IGRpc2FibGUgdGhpcwo+
ID4+Pj4+IG9wdGltaXphdGlvbiBlbnRpcmVseSBmb3IgQVJNIGFuZCBhcm02NC4KPiA+Pj4+Pgo+
ID4+Pj4+IENjOiBDaHJpc3RpYW4gS29lbmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4g
Pj4+Pj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+Pj4+
PiBDYzogRGF2aWQgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4KPiA+Pj4+PiBDYzogSHVhbmcg
UnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiA+Pj4+PiBDYzogSnVud2VpIFpoYW5nIDxKZXJyeS5a
aGFuZ0BhbWQuY29tPgo+ID4+Pj4+IENjOiBNaWNoZWwgRGFlbnplciA8bWljaGVsLmRhZW56ZXJA
YW1kLmNvbT4KPiA+Pj4+PiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+ID4+
Pj4+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gPj4+Pj4gQ2M6IE1hYXJ0
ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+Cj4gPj4+Pj4g
Q2M6IE1heGltZSBSaXBhcmQgPG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb20+Cj4gPj4+Pj4gQ2M6
IFNlYW4gUGF1bCA8c2VhbkBwb29ybHkucnVuPgo+ID4+Pj4+IENjOiBNaWNoYWVsIEVsbGVybWFu
IDxtcGVAZWxsZXJtYW4uaWQuYXU+Cj4gPj4+Pj4gQ2M6IEJlbmphbWluIEhlcnJlbnNjaG1pZHQg
PGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZz4KPiA+Pj4+PiBDYzogV2lsbCBEZWFjb24gPHdpbGwu
ZGVhY29uQGFybS5jb20+Cj4gPj4+Pj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFk
ZWFkLm9yZz4KPiA+Pj4+PiBDYzogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4K
PiA+Pj4+PiBDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4K
PiA+Pj4+PiBDYzogZHJpLWRldmVsIDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPgo+
ID4+Pj4+IFJlcG9ydGVkLWJ5OiBDYXJzdGVuIEhhaXR6bGVyIDxDYXJzdGVuLkhhaXR6bGVyQGFy
bS5jb20+Cj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1
dmVsQGxpbmFyby5vcmc+Cj4gPj4+PiBUaGUgc3ViamVjdCBsaW5lIHNob3VsZCBwcm9iYWJseSBy
ZWFkICJkaXNhYmxlIHVuY2FjaGVkLi4uIi4KPiA+Pj4+Cj4gPj4+IFVnaCwgb2YgY291cnNlIC4u
Lgo+ID4+Pgo+ID4+Pj4gV2l0aCB0aGF0IGZpeGVkIHRoZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZwo+ID4+Pj4gPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCj4gPj4+
Pgo+ID4+IFNhbWU6Cj4gPj4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KPiA+Pgo+ID4gVGhhbmtzIGFsbAo+ID4KPiA+IFNob3VsZCBJIHJlc2Vu
ZCB0aGUgcGF0Y2ggd2l0aCB0aGUgc3ViamVjdCBjb3JyZWN0ZWQ/Cj4KPiBJIHdpbGwgdXBkYXRl
IHRoZSBzdWJqZWN0IGxpbmUgYW5kIHB1c2ggaXQgdXBzdHJlYW0gdGhyb3VnaAo+IGRybS1taXNj
LW5leHQgaWYgbm9ib2R5IG9iamVjdHMuCj4KCldvbmRlcmZ1bCwgdGhhbmtzLgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
