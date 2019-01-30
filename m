Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5715FC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:25:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1973C20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UtrDXJY8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ErO9o3wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1973C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a2rSZmkuGjrX6CrTtqxkqcxfWlqd2SkZk4MWESfAW44=; b=UtrDXJY8AZ01Zr
	3kVov6PoAKXUQJxN0JFYKvDVgRf3lvSRy0D5q3629l4EtabYunE3NQNxRKIgvK98UV1bsPSHuHtuQ
	Ksi7nRIoMNnpZEcHd4Qf5pnc92u2iuwY0RjXDdrNGXgmfCeVzTkgjO+Hb3Pua88JRQcK3KQGB/Ake
	3A0KG93Lkr3+gfza5QmQjoLzFqpL+UxEhu18M/J3a/Ynsnyh3TGKd2dtE7Rzfw79PR8zEBomnZILO
	NvrH/6L4gxHQZJbfOtnrydpUeUJ0aiH/wiOilLQl9AyDTK1Cg78CevwG0UAVdtZArVQqzXJpqC1OX
	hOUWNsDkvqjKFhvymNkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gom7r-0003YC-HJ; Wed, 30 Jan 2019 09:25:43 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gom7o-0003XT-2q
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:25:41 +0000
Received: by mail-ed1-x543.google.com with SMTP id y56so18377263edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5a7NvQkWOISkNnAGXM7TAeezdcdvrRYnkbW1NYEQoWw=;
 b=ErO9o3wmAG1rh48oPZST8SDvEgdzFIqMvwpSRCPjOjyqqlur6MUak6HZl+Oy26YyOg
 uLoFAHxWCHYNAoQG+tt2Ovu3T26/bRS/31WTOk8maA0APDQMX6nEL+fFYbomuxvo5X30
 qzsn/KqGl6vdguVGcIFERkIplb6ICppSv8F5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5a7NvQkWOISkNnAGXM7TAeezdcdvrRYnkbW1NYEQoWw=;
 b=cDHwKY6kRIM9zd4iC++CNhyKRVJQEqHv9yy9y+i4cik8pxzy1bv6JigTT4h/avTxoH
 LCNDp4lgJscMfyLzCzdVzTNMbhVmisqzs+0vzhX3MJY+5fq96dvNk1OiX4B5Yflbgccy
 M+a53w24nt6uDWKbwkfbNuu/8inJ8ur4Gnu+5Nrdr2iaEMDt4A896BLXpvO9XYxH7xdS
 fKzdhX/gEoAkq1nDNkpx0wvAqs+eSeV53CQ66EPuobloVDao6mOfemaj8H4U0tGbK3+C
 cmJXGV9ggBovKPTiWziIsLeAGEzyMIQmlZBx8F9f8zkjI3eblaZzttD1ybQbETzL45HM
 2mqA==
X-Gm-Message-State: AJcUuken3K8zxyVhmpyk4M9xKDSuy6RWl3b31e2U3+uXe5CtNWRcX8pt
 rO3wp7GhbNcPIbutchY7hMGzj4zmMc5KdyzCviiSHw==
X-Google-Smtp-Source: ALg8bN6eDeahTmyePeL/rIwr+a3UJTI5G0WFFLJFcWc/OJ7ixVMBE8XghKL8df0HI4K1ASmS9q50ZqOCKK7n/rNDyXA=
X-Received: by 2002:a17:906:4691:: with SMTP id
 a17mr25821356ejr.58.1548840338153; 
 Wed, 30 Jan 2019 01:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20190109055724.184692-1-pihsun@chromium.org>
 <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
 <81115ad5-521e-557b-d229-1effb92068a4@linaro.org>
In-Reply-To: <81115ad5-521e-557b-d229-1effb92068a4@linaro.org>
From: Pi-Hsun Shih <pihsun@chromium.org>
Date: Wed, 30 Jan 2019 17:25:27 +0800
Message-ID: <CANdKZ0eDwTgKoFsAOboCz=q+nsUWepecXA7wmR=jGhkWEzLvnA@mail.gmail.com>
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_012540_147393_7734F66A 
X-CRM114-Status: GOOD (  18.55  )
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
Cc: "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Michael.Kao@mediatek.com,
 Eduardo Valentin <edubezval@gmail.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBKYW4gMzAsIDIwMTkgYXQgMzo0NCBQTSBEYW5pZWwgTGV6Y2Fubwo8ZGFuaWVsLmxl
emNhbm9AbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBPbiAzMC8wMS8yMDE5IDA3OjA0LCBQZXRlciBT
aGloIHdyb3RlOgo+ID4gQWRkaW5nIE1pY2hhZWwgS2FvIHRvIGNjIGxpc3QuCj4gPgo+ID4gT24g
V2VkLCBKYW4gOSwgMjAxOSBhdCAxOjU3IFBNIFBpLUhzdW4gU2hpaCA8cGloc3VuQGNocm9taXVt
Lm9yZz4gd3JvdGU6Cj4gPj4KPiA+PiBUaGUgbXRrX3RoZXJtYWwgc3RydWN0IGNvbnRhaW5zIGEg
J3N0cnVjdCBtdGtfdGhlcm1hbF9iYW5rIGJhbmtzW107JywKPiA+PiBidXQgdGhlIGFsbG9jYXRp
b24gb25seSBhbGxvY2F0ZXMgc2l6ZW9mKHN0cnVjdCBtdGtfdGhlcm1hbCkgYnl0ZXMsCj4gPj4g
d2hpY2ggY2F1c2Ugb3V0IG9mIGJvdW5kIGFjY2VzcyB3aXRoIHRoZSAtPmJhbmtzW10gbWVtYmVy
LiBDaGFuZ2UgaXQgdG8KPiA+PiBhIGZpeGVkIHNpemUgYXJyYXkgaW5zdGVhZC4KPgo+IEV2ZW4g
aWYgdGhlIGZpeCBpcyBjb3JyZWN0LCBpdCBwdXNoZXMgYmFjayB0aGUgYnVnIGxhdGVyIGluIHRp
bWUgaWYgYQo+IG5ldyBib2FyZCBjb250YWluaW5nIG1vcmUgdGhhbiBNQVhfTlVNX1pPTkVTIGlz
IGludHJvZHVjZWQuIEkgc3VnZ2VzdCB0bwo+IGR5bmFtaWNhbGx5IGFsbG9jYXRlIHRoZSBhcnJh
eSB3aXRoIHRoZSAnbnVtX2JhbmtzJyB2YWx1ZS4KPgoKRm9yIHRoZSBjdXJyZW50IGNvZGUgc3Ry
dWN0dXJlLCB0aG9zZSBtdGtfdGhlcm1hbF9kYXRhIGFyZSBzdGF0aWNhbGx5IGRlY2xhcmVkLApz
byBpZiB0aGVyZSdzIG5ldyBib2FyZCBjb250YWluaW5nIG1vcmUgdGhhbiBNQVhfTlVNX1pPTkVT
IG9mIGJhbmtfZGF0YSwgaXQKd291bGQgYWN0dWFsbHkgYmUgYSBjb21waWxlIGVycm9yLgoKSSdt
IGZpbmUgd2l0aCBlaXRoZXIgd2F5LCBidXQgZmVlbCBsaWtlIHRoYXQgdGhpcyBpcyBzaW1wbGVy
IHRoYW4gbWFudWFsbHkKY2FsY3VsYXRpbmcgdGhlIHNpemUgbmVlZGVkIGZvciBhbGxvY2F0aW9u
LgoKPgo+ID4+IFNpZ25lZC1vZmYtYnk6IFBpLUhzdW4gU2hpaCA8cGloc3VuQGNocm9taXVtLm9y
Zz4KPiA+PiAtLS0KPiA+PiAgZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMgfCA3ICsrKysr
LS0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
PiA+Pgo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYyBiL2Ry
aXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jCj4gPj4gaW5kZXggMDY5MWYyNjBmNmVhYmUuLmVh
MTFlZGIzZmNjZWQ2IDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1h
bC5jCj4gPj4gKysrIGIvZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMKPiA+PiBAQCAtMTU5
LDYgKzE1OSw5IEBACj4gPj4gICNkZWZpbmUgTVQ3NjIyX05VTV9TRU5TT1JTX1BFUl9aT05FICAg
IDEKPiA+PiAgI2RlZmluZSBNVDc2MjJfVFMxICAgICAwCj4gPj4KPiA+PiArLyogVGhlIG1heGlt
dW0gbnVtYmVyIG9mIGJhbmtzICovCj4gPj4gKyNkZWZpbmUgTUFYX05VTV9aT05FUyAgICAgICAg
ICA4Cj4gPj4gKwo+ID4+ICBzdHJ1Y3QgbXRrX3RoZXJtYWw7Cj4gPj4KPiA+PiAgc3RydWN0IHRo
ZXJtYWxfYmFua19jZmcgewo+ID4+IEBAIC0xNzgsNyArMTgxLDcgQEAgc3RydWN0IG10a190aGVy
bWFsX2RhdGEgewo+ID4+ICAgICAgICAgY29uc3QgaW50ICpzZW5zb3JfbXV4X3ZhbHVlczsKPiA+
PiAgICAgICAgIGNvbnN0IGludCAqbXNyOwo+ID4+ICAgICAgICAgY29uc3QgaW50ICphZGNwbnA7
Cj4gPj4gLSAgICAgICBzdHJ1Y3QgdGhlcm1hbF9iYW5rX2NmZyBiYW5rX2RhdGFbXTsKPiA+PiAr
ICAgICAgIHN0cnVjdCB0aGVybWFsX2JhbmtfY2ZnIGJhbmtfZGF0YVtNQVhfTlVNX1pPTkVTXTsK
PiA+PiAgfTsKPiA+Pgo+ID4+ICBzdHJ1Y3QgbXRrX3RoZXJtYWwgewo+ID4+IEBAIC0xOTcsNyAr
MjAwLDcgQEAgc3RydWN0IG10a190aGVybWFsIHsKPiA+PiAgICAgICAgIHMzMiB2dHNbTVQ4MTcz
X05VTV9TRU5TT1JTXTsKPiA+Pgo+ID4+ICAgICAgICAgY29uc3Qgc3RydWN0IG10a190aGVybWFs
X2RhdGEgKmNvbmY7Cj4gPj4gLSAgICAgICBzdHJ1Y3QgbXRrX3RoZXJtYWxfYmFuayBiYW5rc1td
Owo+ID4+ICsgICAgICAgc3RydWN0IG10a190aGVybWFsX2JhbmsgYmFua3NbTUFYX05VTV9aT05F
U107Cj4gPj4gIH07Cj4gPj4KPiA+PiAgLyogTVQ4MTczIHRoZXJtYWwgc2Vuc29yIGRhdGEgKi8K
PiA+PiAtLQo+ID4+IDIuMjAuMS45Ny5nODExODhkOTNjMy1nb29nCj4gPj4KPgo+Cj4gLS0KPiAg
PGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3
YXJlIGZvciBBUk0gU29Dcwo+Cj4gRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29r
LmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPiA8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xp
bmFyb29yZz4gVHdpdHRlciB8Cj4gPGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8tYmxvZy8+
IEJsb2cKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
