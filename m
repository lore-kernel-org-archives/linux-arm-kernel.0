Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AE6C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:02:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5337A2082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WcU+XTbH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPrOEkE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5337A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kpjp6XcpaUzNRq5ethc3/FFeVVcOgorMjdE0hSQ+HU0=; b=WcU+XTbHiFXHWt
	P3rmIi+2uYPyv16LmjyrOf08k9Q0QyCW+e5EKwuzMADMA2azWQcE0DOk76OFYm/YlVS3mSP64g+Vm
	8hYBPAYyr3Q9Y01vwFmQNATEQOzS63ntW3yU9c/7n6tpgbuTXIUYNJGbbNKrHhrq3anJbfyo5OMgg
	+Mcu6dsYT5Zqp8GWcafMuvHnWvC1b8ruKpFMJzc5vcq8xNQNKO47rCjjd1vukATTxvIbk7fVzIPZ3
	twavWj3RSkkPAbNkWu+ng0sazH7+B7nkoFLwNl14JFg6YkA1NxYPv6930Is7Iz0fn8li2f58njLtY
	xOFRj2HCIXYytAl5HS0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqfkn-0006cw-Uq; Mon, 04 Feb 2019 15:01:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqfkj-0006ca-Jn; Mon, 04 Feb 2019 15:01:44 +0000
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 882CE2082E;
 Mon,  4 Feb 2019 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549292500;
 bh=oypoNwm+6B+QKs1jDDcQsVgcF3/t9rNZenmbGSfPzEw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=FPrOEkE3Ru0DYvGluOHQZb0rP/SvozTYkVGnyPF8qp6MrjyypyhJ+18SDkipqy+OS
 VC6TAjlMqOEYW/AGlAc1mej79lAEQThQy/O4lq8D5DOtE7cSnKHBhFXHNQ9uba1Y2Q
 fYmWHcWM+X7iVeP5tFvxXsu1J2wwI40VP+kmKhRE=
Received: by mail-qt1-f174.google.com with SMTP id r9so182635qtt.3;
 Mon, 04 Feb 2019 07:01:40 -0800 (PST)
X-Gm-Message-State: AJcUukcxU5JK9G9i1Z1z2SakGihjRd0J8PDTGthfkTasWS5LNUAzy0vY
 NXQ/voFK7BnVUMo8IMUIAgZ/jmPbavOx6W685Q==
X-Google-Smtp-Source: ALg8bN6yvS2jXf8BPoLz+KHLzdv8BIA5Bd452FNOpFd3TYWGhjgNnW+L3P5N9HAxtO9Ep0DyXo7d3MBMqvbbyC4idbI=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr47587667qve.246.1549292499728; 
 Mon, 04 Feb 2019 07:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20190202170711.29471-1-robh@kernel.org>
 <bebcbda6-1059-857b-4e7d-9751248f6804@tronnes.org>
In-Reply-To: <bebcbda6-1059-857b-4e7d-9751248f6804@tronnes.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Feb 2019 09:01:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL-7bOCS+T1xuJBmSgwRN1shCSNeQPxreCH76_s9hEYWw@mail.gmail.com>
Message-ID: <CAL_JsqL-7bOCS+T1xuJBmSgwRN1shCSNeQPxreCH76_s9hEYWw@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: Use drm_fbdev_generic_setup()
To: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_070141_684404_EBC3BA97 
X-CRM114-Status: GOOD (  15.64  )
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
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 David Airlie <airlied@linux.ie>, Sandy Huang <hjc@rock-chips.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU2F0LCBGZWIgMiwgMjAxOSBhdCAxMjoyMiBQTSBOb3JhbGYgVHLDuG5uZXMgPG5vcmFsZkB0
cm9ubmVzLm9yZz4gd3JvdGU6Cj4gRGVuIDAyLjAyLjIwMTkgMTguMDcsIHNrcmV2IFJvYiBIZXJy
aW5nOgo+ID4gT3RoZXIgdGhhbiB1c2luZyBhIHJvY2tjaGlwX2dlbV9vYmplY3QgZGlyZWN0bHks
IHRoZSBSb2NrY2hpcCBmYmRldgo+ID4gc2V0dXAgaGFzIG5vdGhpbmcgc3BlY2lhbCBhbmQgY2Fu
IGJlIGNvbnZlcnRlZCB0byB1c2UgdGhlIGdlbmVyaWMgZmJkZXYKPiA+IGVtdWxhdGlvbiBpbnN0
ZWFkLgoKWy4uLl0KCj4gPiAtc3RhdGljIGludCByb2NrY2hpcF9kcm1fZmJkZXZfY3JlYXRlKHN0
cnVjdCBkcm1fZmJfaGVscGVyICpoZWxwZXIsCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBkcm1fZmJfaGVscGVyX3N1cmZhY2Vfc2l6ZSAqc2l6ZXMpCj4gPiAt
ewo+ID4gLSAgICAgc3RydWN0IHJvY2tjaGlwX2RybV9wcml2YXRlICpwcml2YXRlID0gdG9fZHJt
X3ByaXZhdGUoaGVscGVyKTsKPiA+IC0gICAgIHN0cnVjdCBkcm1fbW9kZV9mYl9jbWQyIG1vZGVf
Y21kID0geyAwIH07Cj4gPiAtICAgICBzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gaGVscGVyLT5k
ZXY7Cj4gPiAtICAgICBzdHJ1Y3Qgcm9ja2NoaXBfZ2VtX29iamVjdCAqcmtfb2JqOwo+ID4gLSAg
ICAgc3RydWN0IGRybV9mcmFtZWJ1ZmZlciAqZmI7Cj4gPiAtICAgICB1bnNpZ25lZCBpbnQgYnl0
ZXNfcGVyX3BpeGVsOwo+ID4gLSAgICAgdW5zaWduZWQgbG9uZyBvZmZzZXQ7Cj4gPiAtICAgICBz
dHJ1Y3QgZmJfaW5mbyAqZmJpOwo+ID4gLSAgICAgc2l6ZV90IHNpemU7Cj4gPiAtICAgICBpbnQg
cmV0Owo+ID4gLQo+ID4gLSAgICAgYnl0ZXNfcGVyX3BpeGVsID0gRElWX1JPVU5EX1VQKHNpemVz
LT5zdXJmYWNlX2JwcCwgOCk7Cj4gPiAtCj4gPiAtICAgICBtb2RlX2NtZC53aWR0aCA9IHNpemVz
LT5zdXJmYWNlX3dpZHRoOwo+ID4gLSAgICAgbW9kZV9jbWQuaGVpZ2h0ID0gc2l6ZXMtPnN1cmZh
Y2VfaGVpZ2h0Owo+ID4gLSAgICAgbW9kZV9jbWQucGl0Y2hlc1swXSA9IHNpemVzLT5zdXJmYWNl
X3dpZHRoICogYnl0ZXNfcGVyX3BpeGVsOwo+ID4gLSAgICAgbW9kZV9jbWQucGl4ZWxfZm9ybWF0
ID0gZHJtX21vZGVfbGVnYWN5X2ZiX2Zvcm1hdChzaXplcy0+c3VyZmFjZV9icHAsCj4gPiAtICAg
ICAgICAgICAgIHNpemVzLT5zdXJmYWNlX2RlcHRoKTsKPiA+IC0KPiA+IC0gICAgIHNpemUgPSBt
b2RlX2NtZC5waXRjaGVzWzBdICogbW9kZV9jbWQuaGVpZ2h0Owo+ID4gLQo+ID4gLSAgICAgcmtf
b2JqID0gcm9ja2NoaXBfZ2VtX2NyZWF0ZV9vYmplY3QoZGV2LCBzaXplLCB0cnVlKTsKPgo+IEkg
ZG9uJ3QgdGhpbmsgdGhlIGdlbmVyaWMgZW11bGF0aW9uIGluIGl0J3MgY3VycmVudCBmb3JtIHdp
bGwgd29yayBmb3IKPiByb2NrY2hpcC4gcm9ja2NoaXAgdHJlYXRzIGZiZGV2IGJ1ZmZlcnMgYW5k
IGR1bWIgYnVmZmVycyBkaWZmZXJlbnRseS4gSWYKPiBpdCB1c2VzIERNQSBidWZmZXJzLCB0aGVu
IHRoZSBkdW1iIGJ1ZmZlciBjYW4ndCBnZXQgYSB2aXJ0dWFsIGFkZHJlc3MuCgpZZXMsIHlvdSBh
cmUgcmlnaHQuIEkgdGVzdGVkIHRoZSBpb21tdSBjYXNlLgoKPiBGcm9tIHJvY2tjaGlwX2dlbV9h
bGxvY19kbWEoKToKPgo+ICAgICAgICAgaWYgKCFhbGxvY19rbWFwKQo+ICAgICAgICAgICAgICAg
ICBya19vYmotPmRtYV9hdHRycyB8PSBETUFfQVRUUl9OT19LRVJORUxfTUFQUElORzsKPgo+IEZy
b20gcm9ja2NoaXBfZ2VtX3ByaW1lX3ZtYXAoKToKPgo+ICAgICAgICAgaWYgKHJrX29iai0+ZG1h
X2F0dHJzICYgRE1BX0FUVFJfTk9fS0VSTkVMX01BUFBJTkcpCj4gICAgICAgICAgICAgICAgIHJl
dHVybiBOVUxMOwo+Cj4gTWF5YmUgaXQncyBwb3NzaWJsZSB0byB2bWFwIGEgYnVmZmVyIGNyZWF0
ZWQgdXNpbmcgZG1hX2FsbG9jX2F0dHJzKCkKPiBhZnRlciB0aGUgYWxsb2NhdGlvbj8KCkl0IHNo
b3VsZCBiZSBwb3NzaWJsZSBJIHRoaW5rIGFzIHRoYXQgaXMgd2hhdApkcm1fZ2VtX2NtYV9wcmlt
ZV9pbXBvcnRfc2dfdGFibGVfdm1hcCgpIGRvZXMuIE9uZSBwcm9ibGVtIHRob3VnaCBpcwp5b3Ug
bWF5IGFscmVhZHkgaGF2ZSBhIG1hcHBpbmcgYmVjYXVzZSBETUFfQVRUUl9OT19LRVJORUxfTUFQ
UElORyBpcwpqdXN0IGEgc3VnZ2VzdGlvbiAob25seSAzMi1iaXQgQVJNIGltcGxlbWVudHMpIGFu
ZCB0aGVyZSdzIG5vdCBhIHdheQp0byB0ZWxsIGlmIHlvdSBnb3QgYSBtYXBwaW5nIG9yIG5vdC4g
TWF5YmUgaXQncyBub3QgYWxsIHRoYXQgaW1wb3J0YW50CmlmIHRoZXJlIGFyZSAyIG1hcHBpbmdz
IGJlY2F1c2UgSSB0aGluayBvbmx5IGZiY29uIG5lZWRzIGEga2VybmVsCm1hcHBpbmcuCgpNeSBm
b2xsb3ctdXAgdG8gdGhpcyB3YXMgZ29pbmcgdG8gYmUgY29udmVydGluZyBSb2NrY2hpcCB0byB1
c2UgQ01BCmFuZCB0aGUgc2htZW0gaGVscGVycy4gU28gSSB3YXMgYWxyZWFkeSB3b25kZXJpbmcg
YWJvdXQgd2hhdCB0byBkbwp3aXRoIERNQV9BVFRSX05PX0tFUk5FTF9NQVBQSU5HLiBUaGVyZSdz
IHNldmVyYWwgZHJpdmVycyBub3QgdXNpbmcgQ01BCmp1c3QgdG8gc2V0IERNQV9BVFRSX05PX0tF
Uk5FTF9NQVBQSU5HLiBTbyBpdCB3b3VsZCBiZSBnb29kIHRvIGNvbWUgdXAKd2l0aCBhIHNvbHV0
aW9uIGhlcmUuCgpSb2IKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
