Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B860C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:49:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FBC20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uDxrrrHJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHEzl9VW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FBC20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bwx/j772QVCGmCTAjRU+h2FCmb204o08A6ksJ9FPdc0=; b=uDxrrrHJUEUvYg
	skl2JDq4g8KzUujeFFVoDz0Uvq30BVUGvURZgt5VtCvHlXcJieWEfpKOpZHBiue9h4LgB7S50TTTy
	p03/hGNw8meGb2DT/c1evpYXFPO2OeiHRyjGT1fzPC8QJJJEYENHFFMfH4uYJ1TMAv/4HoD03k2su
	C4JXOURzQXWKaEo3ar7u5hFmZFBJRve1H6JhPViA29cv1lDK1KSqL/HqrOwBynSGRLASGxjiTVfbR
	Je7Tf6DaRj4C7B/rSuZhb7Q9IyJAHLH/KjATv3OtkSATE0gPdGTHRke5XSGSHr2bDAM8MWaoHd5RB
	7rj/9E+1mGuI4dyDXBLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqhQm-0001Ef-Pw; Mon, 04 Feb 2019 16:49:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqhQj-0001EF-Qf; Mon, 04 Feb 2019 16:49:11 +0000
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5C274214DA;
 Mon,  4 Feb 2019 16:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549298949;
 bh=Mpmh6LaI22ykge7dX8aUasPmahQKEE51CwSLQRoJCkc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YHEzl9VWcs89TbQ+ycTxLcrUxwl50ufvaBR/C4O2/vnGKIEkfNAFpSbOqylZE4qZw
 tmkQ8R8l6lUEQ+Z84debtiJfaSYsrsZWNS5ve97ZFLdPWUWRKRp23NiZfuxhnnFz0Z
 ld0+PwjSP7rgaJ/3COAbs3E1H8X6Cas2/hHGceoI=
Received: by mail-qk1-f182.google.com with SMTP id m17so333970qki.5;
 Mon, 04 Feb 2019 08:49:09 -0800 (PST)
X-Gm-Message-State: AHQUAuZ7CkiA5PjuuUyEcK800LIO41ohUBIynv316gqOJT4+v/YTVV3X
 JUBIo3WE1xT1gqMo2IgeBsxPrEKaJho0ZXZTDA==
X-Google-Smtp-Source: AHgI3IbPiJR4gIgh9R1NHxtat41pdZ3Mnt1ZPtuUMayE4VMjibU2jjxn5gVbgM9FBKTMhX84Fy+w4tU3U1XDVkmggbI=
X-Received: by 2002:a37:6451:: with SMTP id y78mr197590qkb.147.1549298948546; 
 Mon, 04 Feb 2019 08:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20190202170711.29471-1-robh@kernel.org>
 <bebcbda6-1059-857b-4e7d-9751248f6804@tronnes.org>
 <CAL_JsqL-7bOCS+T1xuJBmSgwRN1shCSNeQPxreCH76_s9hEYWw@mail.gmail.com>
In-Reply-To: <CAL_JsqL-7bOCS+T1xuJBmSgwRN1shCSNeQPxreCH76_s9hEYWw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Feb 2019 10:48:57 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+s=Y1P+0S=Q=+UgrXZQQO4mLrvEg7TmzWfKfXJmPCuPg@mail.gmail.com>
Message-ID: <CAL_Jsq+s=Y1P+0S=Q=+UgrXZQQO4mLrvEg7TmzWfKfXJmPCuPg@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: Use drm_fbdev_generic_setup()
To: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_084909_899890_DF25A104 
X-CRM114-Status: GOOD (  17.10  )
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

T24gTW9uLCBGZWIgNCwgMjAxOSBhdCA5OjAxIEFNIFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+IHdyb3RlOgo+Cj4gT24gU2F0LCBGZWIgMiwgMjAxOSBhdCAxMjoyMiBQTSBOb3JhbGYgVHLD
uG5uZXMgPG5vcmFsZkB0cm9ubmVzLm9yZz4gd3JvdGU6Cj4gPiBEZW4gMDIuMDIuMjAxOSAxOC4w
Nywgc2tyZXYgUm9iIEhlcnJpbmc6Cj4gPiA+IE90aGVyIHRoYW4gdXNpbmcgYSByb2NrY2hpcF9n
ZW1fb2JqZWN0IGRpcmVjdGx5LCB0aGUgUm9ja2NoaXAgZmJkZXYKPiA+ID4gc2V0dXAgaGFzIG5v
dGhpbmcgc3BlY2lhbCBhbmQgY2FuIGJlIGNvbnZlcnRlZCB0byB1c2UgdGhlIGdlbmVyaWMgZmJk
ZXYKPiA+ID4gZW11bGF0aW9uIGluc3RlYWQuCj4KPiBbLi4uXQo+Cj4gPiA+IC1zdGF0aWMgaW50
IHJvY2tjaGlwX2RybV9mYmRldl9jcmVhdGUoc3RydWN0IGRybV9mYl9oZWxwZXIgKmhlbHBlciwK
PiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZHJtX2ZiX2hl
bHBlcl9zdXJmYWNlX3NpemUgKnNpemVzKQo+ID4gPiAtewo+ID4gPiAtICAgICBzdHJ1Y3Qgcm9j
a2NoaXBfZHJtX3ByaXZhdGUgKnByaXZhdGUgPSB0b19kcm1fcHJpdmF0ZShoZWxwZXIpOwo+ID4g
PiAtICAgICBzdHJ1Y3QgZHJtX21vZGVfZmJfY21kMiBtb2RlX2NtZCA9IHsgMCB9Owo+ID4gPiAt
ICAgICBzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gaGVscGVyLT5kZXY7Cj4gPiA+IC0gICAgIHN0
cnVjdCByb2NrY2hpcF9nZW1fb2JqZWN0ICpya19vYmo7Cj4gPiA+IC0gICAgIHN0cnVjdCBkcm1f
ZnJhbWVidWZmZXIgKmZiOwo+ID4gPiAtICAgICB1bnNpZ25lZCBpbnQgYnl0ZXNfcGVyX3BpeGVs
Owo+ID4gPiAtICAgICB1bnNpZ25lZCBsb25nIG9mZnNldDsKPiA+ID4gLSAgICAgc3RydWN0IGZi
X2luZm8gKmZiaTsKPiA+ID4gLSAgICAgc2l6ZV90IHNpemU7Cj4gPiA+IC0gICAgIGludCByZXQ7
Cj4gPiA+IC0KPiA+ID4gLSAgICAgYnl0ZXNfcGVyX3BpeGVsID0gRElWX1JPVU5EX1VQKHNpemVz
LT5zdXJmYWNlX2JwcCwgOCk7Cj4gPiA+IC0KPiA+ID4gLSAgICAgbW9kZV9jbWQud2lkdGggPSBz
aXplcy0+c3VyZmFjZV93aWR0aDsKPiA+ID4gLSAgICAgbW9kZV9jbWQuaGVpZ2h0ID0gc2l6ZXMt
PnN1cmZhY2VfaGVpZ2h0Owo+ID4gPiAtICAgICBtb2RlX2NtZC5waXRjaGVzWzBdID0gc2l6ZXMt
PnN1cmZhY2Vfd2lkdGggKiBieXRlc19wZXJfcGl4ZWw7Cj4gPiA+IC0gICAgIG1vZGVfY21kLnBp
eGVsX2Zvcm1hdCA9IGRybV9tb2RlX2xlZ2FjeV9mYl9mb3JtYXQoc2l6ZXMtPnN1cmZhY2VfYnBw
LAo+ID4gPiAtICAgICAgICAgICAgIHNpemVzLT5zdXJmYWNlX2RlcHRoKTsKPiA+ID4gLQo+ID4g
PiAtICAgICBzaXplID0gbW9kZV9jbWQucGl0Y2hlc1swXSAqIG1vZGVfY21kLmhlaWdodDsKPiA+
ID4gLQo+ID4gPiAtICAgICBya19vYmogPSByb2NrY2hpcF9nZW1fY3JlYXRlX29iamVjdChkZXYs
IHNpemUsIHRydWUpOwo+ID4KPiA+IEkgZG9uJ3QgdGhpbmsgdGhlIGdlbmVyaWMgZW11bGF0aW9u
IGluIGl0J3MgY3VycmVudCBmb3JtIHdpbGwgd29yayBmb3IKPiA+IHJvY2tjaGlwLiByb2NrY2hp
cCB0cmVhdHMgZmJkZXYgYnVmZmVycyBhbmQgZHVtYiBidWZmZXJzIGRpZmZlcmVudGx5LiBJZgo+
ID4gaXQgdXNlcyBETUEgYnVmZmVycywgdGhlbiB0aGUgZHVtYiBidWZmZXIgY2FuJ3QgZ2V0IGEg
dmlydHVhbCBhZGRyZXNzLgo+Cj4gWWVzLCB5b3UgYXJlIHJpZ2h0LiBJIHRlc3RlZCB0aGUgaW9t
bXUgY2FzZS4KPgo+ID4gRnJvbSByb2NrY2hpcF9nZW1fYWxsb2NfZG1hKCk6Cj4gPgo+ID4gICAg
ICAgICBpZiAoIWFsbG9jX2ttYXApCj4gPiAgICAgICAgICAgICAgICAgcmtfb2JqLT5kbWFfYXR0
cnMgfD0gRE1BX0FUVFJfTk9fS0VSTkVMX01BUFBJTkc7Cj4gPgo+ID4gRnJvbSByb2NrY2hpcF9n
ZW1fcHJpbWVfdm1hcCgpOgo+ID4KPiA+ICAgICAgICAgaWYgKHJrX29iai0+ZG1hX2F0dHJzICYg
RE1BX0FUVFJfTk9fS0VSTkVMX01BUFBJTkcpCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIE5V
TEw7Cj4gPgo+ID4gTWF5YmUgaXQncyBwb3NzaWJsZSB0byB2bWFwIGEgYnVmZmVyIGNyZWF0ZWQg
dXNpbmcgZG1hX2FsbG9jX2F0dHJzKCkKPiA+IGFmdGVyIHRoZSBhbGxvY2F0aW9uPwo+Cj4gSXQg
c2hvdWxkIGJlIHBvc3NpYmxlIEkgdGhpbmsgYXMgdGhhdCBpcyB3aGF0Cj4gZHJtX2dlbV9jbWFf
cHJpbWVfaW1wb3J0X3NnX3RhYmxlX3ZtYXAoKSBkb2VzLiBPbmUgcHJvYmxlbSB0aG91Z2ggaXMK
PiB5b3UgbWF5IGFscmVhZHkgaGF2ZSBhIG1hcHBpbmcgYmVjYXVzZSBETUFfQVRUUl9OT19LRVJO
RUxfTUFQUElORyBpcwo+IGp1c3QgYSBzdWdnZXN0aW9uIChvbmx5IDMyLWJpdCBBUk0gaW1wbGVt
ZW50cykgYW5kIHRoZXJlJ3Mgbm90IGEgd2F5Cj4gdG8gdGVsbCBpZiB5b3UgZ290IGEgbWFwcGlu
ZyBvciBub3QuIE1heWJlIGl0J3Mgbm90IGFsbCB0aGF0IGltcG9ydGFudAo+IGlmIHRoZXJlIGFy
ZSAyIG1hcHBpbmdzIGJlY2F1c2UgSSB0aGluayBvbmx5IGZiY29uIG5lZWRzIGEga2VybmVsCj4g
bWFwcGluZy4KCkFzIGFub3RoZXIgZGF0YSBwb2ludCwgZXh5bm9zIGFsd2F5cyB1c2VzIERNQV9B
VFRSX05PX0tFUk5FTF9NQVBQSU5HCmFuZCB0aGVuIHZtYXAncyBpdHMgZmJkZXYgYnVmZmVyLgoK
Um9iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
