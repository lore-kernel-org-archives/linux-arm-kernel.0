Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0EDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:23:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF57520869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A3x3Rf84";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI2cMWd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF57520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ejaz+GbbOmqeariWuC7oW3mgv7tR+u3jDnLLfl+ry2I=; b=A3x3Rf84dVUA/Q
	4WZc5xKt7PQTqVoYuMtXTIv7OmmsBloj+7hE7yPB+fy2lFpKxhI2kM4m5Vq5wGDXSyPukMIRos2R4
	UyQHWFClldoYDY7pI/jCh9Hme34FJeIIHAhkbg9F9c+mPMqXaLgYDrtUiCzm8BGijssM/KdDQ2ae2
	2mb1GMHo9svVbGje+AsNApYCnroCux/Wqe9U+ampw33GH2aYg7MsuLHBpsaizRfZn+WMeYp9gqa/9
	ON881pYJuRGn+ZpK2uFhs/DJNse2cURjz0AIdIR9MurI2RbRVK4whCk1Ny+mg8M3VWSpZcfpNsfmt
	rlzDVbxbJN9S7Guh/19w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZecx-0000GW-5I; Wed, 19 Dec 2018 16:23:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZect-0000FV-D2
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:23:16 +0000
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 990D8218AE
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 16:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545236585;
 bh=QSkckDURgj+9WLccl7aLFxkVXmwA0nrKp4CtTj2gmo4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nI2cMWd0QX4dAHKNVNISHLNv49/oWnuroLg7eNNixiNtZihlNJVM2TZ18w2PADQS7
 rQLrQdP4X7AGBQxa6P6KyiB2tYoxLz+x1ZmS/DgBlby/jhYccuNqkr5rN9XRfqH7kA
 t78sVpJmCA7Jx0u7m1bnV14nsXkxOxZ80NnRqvyI=
Received: by mail-lf1-f43.google.com with SMTP id f23so15442587lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 08:23:04 -0800 (PST)
X-Gm-Message-State: AA+aEWbvky3euzF25Y5VMXQGlK1OGtP0TIt4yImaP1Prq1LMMiTLKzhd
 QBRsS7EWVWV+upteZDHFkAhdgGhpxg0Ei+tFMlc=
X-Google-Smtp-Source: AFSGD/VO2kVSDgr7J8iQDZ0WsAGHEdvNG6Nk8qU4kQVGNZk3zhBgl1ex+2zT9Eb9YWL4arFoXrAPXSVSHpTYjYsQn6A=
X-Received: by 2002:a19:d8d8:: with SMTP id r85mr12753915lfi.92.1545236582750; 
 Wed, 19 Dec 2018 08:23:02 -0800 (PST)
MIME-Version: 1.0
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
 <20181219155704.15264-3-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181219155704.15264-3-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 19 Dec 2018 17:22:51 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfHHNUzQZu62btspC+6SwgoGPdAzusfSixXM7U9u3QP7A@mail.gmail.com>
Message-ID: <CAJKOXPfHHNUzQZu62btspC+6SwgoGPdAzusfSixXM7U9u3QP7A@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: gpu: samsung-rotator: Document s5pv210
 support
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_082315_459647_9AB92293 
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 jy0922.shim@samsung.com, airlied@linux.ie,
 Seung Woo Kim <sw0312.kim@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
 robh+dt@kernel.org, kyungmin.park@samsung.com, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCAxOSBEZWMgMjAxOCBhdCAxNzowNCwgUGF3ZcWCIENobWllbAo8cGF3ZWwubWlrb2xh
ai5jaG1pZWxAZ21haWwuY29tPiB3cm90ZToKPgo+IFRoaXMgY29tbWl0IGRvY3VtZW50cyBuZXcg
Y29tcGF0aWJsZSBmb3IgczVwdjIxMCBzb2MsCj4gd2hpY2ggd2lsbCBiZSBhbHNvIHN1cHBvcnRl
ZCBieSB0aGlzIGRyaXZlci4KPgo+IFNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2Vs
Lm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KPiAtLS0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2dwdS9zYW1zdW5nLXJvdGF0b3IudHh0IHwgMSArCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9ncHUvc2Ftc3VuZy1yb3RhdG9yLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9ncHUvc2Ftc3VuZy1yb3RhdG9yLnR4dAo+IGluZGV4IDgyY2QxZWQw
YmU5My4uNzg2NThkZWM2OTQxIDEwMDY0NAo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9ncHUvc2Ftc3VuZy1yb3RhdG9yLnR4dAo+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvc2Ftc3VuZy1yb3RhdG9yLnR4dAo+IEBAIC01LDYgKzUs
NyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ICAgICAgICAgKGEpICJzYW1zdW5nLGV4eW5vczQy
MTAtcm90YXRvciIgZm9yIFJvdGF0b3IgSVAgaW4gRXh5bm9zNDIxMAo+ICAgICAgICAgKGIpICJz
YW1zdW5nLGV4eW5vczQyMTItcm90YXRvciIgZm9yIFJvdGF0b3IgSVAgaW4gRXh5bm9zNDIxMi80
NDEyCj4gICAgICAgICAoYykgInNhbXN1bmcsZXh5bm9zNTI1MC1yb3RhdG9yIiBmb3IgUm90YXRv
ciBJUCBpbiBFeHlub3M1MjUwCj4gKyAgICAgICAoZCkgInNhbXN1bmcsczVwdjIxMC1yb3RhdG9y
IiBmb3IgUm90YXRvciBJUCBpbiBTNVBWMjEwCgpIb3cgYWJvdXQgcHV0dGluZyBpdCBhdCBiZWdp
bm5pbmcgYXMgdGhlIG9sZGVzdCBjaGlwc2V0PyBUaGlzIHdvdWxkCnJlcXVpcmUgcmVvcmRlcmlu
ZyB0aGUgbGlzdCBzbyBtYXliZSBsZXQncyByZW1vdmUgdGhlIGEvYi9jIGxpc3QKZW51bWVyYXRp
b25zPyBUaGV5IGFyZSBraW5kIG9mIHVzZWxlc3MuCgpCZXN0IHJlZ2FyZHMsCktyenlzenRvZgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
