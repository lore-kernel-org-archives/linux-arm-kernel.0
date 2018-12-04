Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E187C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:19:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B881206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="clf6wd0t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="08zx+ehi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B881206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yVzWyZq5cOar8o0FCWwib45ML1deUU4s7ybZWGq6mpc=; b=clf6wd0t19zUxs
	xymyVKSX9MQ3jqjtc90sDoY03jDjmaEo8GCNYOK3avC9ecUvfsreZFraFXtfZNX5xzAvrwMATEjSk
	zu9+7Ma+52jW4t0NWvbn/yxyRjcm1dVXF4emH9tsmqVHS/hBF0EK+50yyVVDMkkvumLsuD16D97Mf
	/WLeDyVKjqnHxgwClNxfzDs1y4jLd97vPmNamM4tlFavxDFqsjty48agBAfkNBdIZCDWtnuTBMes9
	J0j1zm15FDTxBio5Q5eQSa2IXaA0JbwH8+00W/NYjBEFyDw9aTenNgKXwfJzVJpHXGRgqb+e6HTrm
	ztUkAfzYf4KrZG4BwTTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHAW-0007Kt-4s; Tue, 04 Dec 2018 20:19:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHAR-0007Ji-Uk; Tue, 04 Dec 2018 20:19:42 +0000
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1DFE620850;
 Tue,  4 Dec 2018 20:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543954769;
 bh=tdWArpzf5E384cMrfAnA7weHncrHAl4lTC/f9jLjPLQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=08zx+ehiQDLHvV7fEIH99YWNJ6saBCYEY+idbcZNuah6cNlQBbGSiBCrq5RJwjIi5
 Bkhcu2eshrV1IvomusOSRHsYfdrkddf0F+yklItqPdxvQaS7t739gD/ILEOVAL2DNL
 R6CFIglCRLEPXh4pH9/SO+LrHfhNfOemqd7eA3Cw=
Received: by mail-wr1-f53.google.com with SMTP id c14so17345455wrr.0;
 Tue, 04 Dec 2018 12:19:29 -0800 (PST)
X-Gm-Message-State: AA+aEWaRZR0ApapecvkPyADwjQlgwaNegDn/JM5Er4q8iZ4qGj13Nhab
 J7Rt8vevMWpz/AOnyJ0NQrljyO7z1rwhagtuvNU=
X-Google-Smtp-Source: AFSGD/Uy81UBEbhfc5Pr63iFQYkIneUWDxseGld5uAvo21auk6OBNEWkh9ueTugPbgzRwgN3X2LXQlMnjxGJZwCNokU=
X-Received: by 2002:adf:b243:: with SMTP id y3mr4779410wra.184.1543954767639; 
 Tue, 04 Dec 2018 12:19:27 -0800 (PST)
MIME-Version: 1.0
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-2-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1543843974-4054-2-git-send-email-qii.wang@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 4 Dec 2018 12:19:16 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzppg3NXBtfgG2SLzMxKBiV9ozgDbBQRTffYA2JhT48Efg@mail.gmail.com>
Message-ID: <CAGp9Lzppg3NXBtfgG2SLzMxKBiV9ozgDbBQRTffYA2JhT48Efg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: i2c: Add Mediatek MT7629 i2c binding
To: qii.wang@mediatek.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_121940_005614_3965AE2F 
X-CRM114-Status: GOOD (  14.57  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com,
 srv_heupstream@mediatek.com, wsa@the-dreams.de, leilk.liu@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PHFpaS53YW5nQG1lZGlhdGVrLmNvbT4g5pa8IDIwMTjlubQxMuaciDPml6Ug6YCx5LiAIOS4iuWN
iDU6MzTlr6vpgZPvvJoKPgo+IEZyb206IHFpaSB3YW5nIDxxaWkud2FuZ0BtZWRpYXRlay5jb20+
Cj4KPiBBZGQgTVQ3NjI5IGkyYyBiaW5kaW5nIHRvIGkyYy1tdDI3MTIudHh0IGFuZCB0aGVyZSBp
cyBubyBuZWVkIHRvCgp3aGVyZSdzIGkyYy1tdDI3MTIudHh0IG1lbnRpb25lZCBoZXJlPwoKPiBt
b2RpZnkgaTJjIGRyaXZlci4KCnN1Z2dlc3Qgbm90IHRvIG1lbnRpb24gZHJpdmVyIGluIGFueSBk
dC1iaW5kaW5nLCBkdC1iaW5kaW5nIHNlbGYKc2hvdWxkIGJlIG9zLWFnbm9zdGljCgo+Cj4gU2ln
bmVkLW9mZi1ieTogcWlpIHdhbmcgPHFpaS53YW5nQG1lZGlhdGVrLmNvbT4KPiAtLS0KPiAgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtbXRrLnR4dCB8ICAgIDEgKwo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaTJjL2kyYy1tdGsudHh0IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2kyYy9pMmMtbXRrLnR4dAo+IGluZGV4IGUxOTk2OTUuLjc3
MjllNTcgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ky
Yy9pMmMtbXRrLnR4dAo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
MmMvaTJjLW10ay50eHQKPiBAQCAtMTAsNiArMTAsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+
ICAgICAgICAibWVkaWF0ZWssbXQ2NTg5LWkyYyI6IGZvciBNZWRpYVRlayBNVDY1ODkKPiAgICAg
ICAgIm1lZGlhdGVrLG10NzYyMi1pMmMiOiBmb3IgTWVkaWFUZWsgTVQ3NjIyCj4gICAgICAgICJt
ZWRpYXRlayxtdDc2MjMtaTJjIiwgIm1lZGlhdGVrLG10NjU3Ny1pMmMiOiBmb3IgTWVkaWFUZWsg
TVQ3NjIzCj4gKyAgICAgICJtZWRpYXRlayxtdDc2MjktaTJjIiwgIm1lZGlhdGVrLG10MjcxMi1p
MmMiOiBmb3IgTWVkaWFUZWsgbXQ3NjI5CgpjaGFuZ2UgbXQ3NjI5IHRvIE1UNzYyOSB0byBhbGln
biB0byB0aGUgb3RoZXJzCgo+ICAgICAgICAibWVkaWF0ZWssbXQ4MTczLWkyYyI6IGZvciBNZWRp
YVRlayBNVDgxNzMKPiAgICAtIHJlZzogcGh5c2ljYWwgYmFzZSBhZGRyZXNzIG9mIHRoZSBjb250
cm9sbGVyIGFuZCBkbWEgYmFzZSwgbGVuZ3RoIG9mIG1lbW9yeQo+ICAgICAgbWFwcGVkIHJlZ2lv
bi4KPiAtLQo+IDEuNy45LjUKPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QKPiBMaW51eC1tZWRp
YXRla0BsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1tZWRpYXRlawoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
