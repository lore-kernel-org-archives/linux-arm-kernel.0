Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0142AC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:37:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63362081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H2/6NNwz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcS28Jq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63362081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mODVMXY1EAyGR7dnnJDmLRD/fW4pA5UPf4EaycLDdHU=; b=H2/6NNwzI5Gcrs
	MmI7Ydely6vj22+aC7Z6BMpsrpK75Z5JHseFRLgvbrKlSYu6HOkC9JCEXoLL+sU5ZMlOV1OwYlTmK
	/qtPzyY+nvm4srGLPCN1VUytg2qdC7libLG4c8BH1It5xvbcfJiMcU6pc33/aXdH0AXsjj+8Yp4lS
	/D2wxYoSqqYwlP331R1rY0x74yd4+REMV3Oy2AmnBJeh4cWGOU+MWlZ3GbYktO+N+VDrsFE/9UrjS
	bMFFs0YMKEYl3SCsPnWZ+jH3BolhRv9EuWIEXdS1mNjTsqhcoFJs1/he2dXmdAlPOnDkzOnBerdu3
	D1RT5YzWjTvHLSvn5zMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUHRq-0006VQ-JV; Tue, 04 Dec 2018 20:37:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUHRk-0006FC-0w; Tue, 04 Dec 2018 20:37:34 +0000
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0D87620850;
 Tue,  4 Dec 2018 20:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543955841;
 bh=Ui7iY51nmAyKLnRnPfY2Dq1DqzdXLZpfF+Q8nfnuB40=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DcS28Jq97Ju5b6cW5Twl7F7l2slGvYHRGIP64El8pgcnBFszS4BscOMOgrtKeK2mF
 MdYKuBgV2XQVWD6fFAjSBlW3JXaU7A04Vo4ouXtrZQmExnqMVkFGkJc9OXe3+blNt5
 39R3qYfHbTgF65+jjpGVcrjkacww+IZss0BXzoDQ=
Received: by mail-wr1-f47.google.com with SMTP id v13so17366695wrw.5;
 Tue, 04 Dec 2018 12:37:20 -0800 (PST)
X-Gm-Message-State: AA+aEWZOCOheyYcVUr2a1OOwnpdr7UV7fuipjTSGZv2RzD84I6HMbuJQ
 pnBFPmz8JHPJdlAy6r6vM+LV5PKFKzcEVhfycLA=
X-Google-Smtp-Source: AFSGD/U1xDnN/s7Gfo+oM7krukKgDupoe1Qxkiq4a5ikk6uoOxlHl65TMgS6NMBK9vms/M9CbSZyqUDN6oHTeqJPROs=
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr18914533wrw.132.1543955839463; 
 Tue, 04 Dec 2018 12:37:19 -0800 (PST)
MIME-Version: 1.0
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
 <1543843974-4054-3-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1543843974-4054-3-git-send-email-qii.wang@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 4 Dec 2018 12:37:08 -0800
X-Gmail-Original-Message-ID: <CAGp9LzrC4xLML0D-8tq+T-042=vMEZF7rSNDYzT7imcBYgt7wA@mail.gmail.com>
Message-ID: <CAGp9LzrC4xLML0D-8tq+T-042=vMEZF7rSNDYzT7imcBYgt7wA@mail.gmail.com>
Subject: Re: [PATCH 2/5] i2c: mediatek: remove useless code and replace
 definitions
To: qii.wang@mediatek.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_123732_125962_E944E60D 
X-CRM114-Status: GOOD (  15.45  )
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
iDU6NDDlr6vpgZPvvJoKPgo+IEZyb206IHFpaSB3YW5nIDxxaWkud2FuZ0BtZWRpYXRlay5jb20+
Cj4KPiBDb21wbGV0aW9uX2RvbmUgaXMgdXNlbGVzcyB3aGVuIHdlIGRvbid0IHVzZSBpdHMgcmV0
dXJuIHZhbHVlLAo+IHNvIHdlIHJlbW92ZSBpdC4gRGlmZmVyZW50IHNwZWVkcyBoYXZlIGJlZW4g
ZGVmaW5lZCBieSBtYWNyb3MsCj4gc28gd2UgdXNlIG1hY3JvcyBkZWZpbml0aW9ucy4KPgo+IFNp
Z25lZC1vZmYtYnk6IHFpaSB3YW5nIDxxaWkud2FuZ0BtZWRpYXRlay5jb20+ClJldmlld2VkLWJ5
OiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BrZXJuZWwub3JnPgoKPiAtLS0KPiAgZHJpdmVycy9pMmMv
YnVzc2VzL2kyYy1tdDY1eHguYyB8ICAgIDYgKystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMv
YnVzc2VzL2kyYy1tdDY1eHguYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtbXQ2NXh4LmMKPiBp
bmRleCBhNzRlZjc2Li42NjBkZTFlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9p
MmMtbXQ2NXh4LmMKPiArKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW10NjV4eC5jCj4gQEAg
LTQ1Niw3ICs0NTYsNyBAQCBzdGF0aWMgaW50IG10a19pMmNfZG9fdHJhbnNmZXIoc3RydWN0IG10
a19pMmMgKmkyYywgc3RydWN0IGkyY19tc2cgKm1zZ3MsCj4KPiAgICAgICAgIGNvbnRyb2xfcmVn
ID0gcmVhZHcoaTJjLT5iYXNlICsgT0ZGU0VUX0NPTlRST0wpICYKPiAgICAgICAgICAgICAgICAg
ICAgICAgICB+KEkyQ19DT05UUk9MX0RJUl9DSEFOR0UgfCBJMkNfQ09OVFJPTF9SUyk7Cj4gLSAg
ICAgICBpZiAoKGkyYy0+c3BlZWRfaHogPiA0MDAwMDApIHx8IChsZWZ0X251bSA+PSAxKSkKPiAr
ICAgICAgIGlmICgoaTJjLT5zcGVlZF9oeiA+IE1BWF9GU19NT0RFX1NQRUVEKSB8fCAobGVmdF9u
dW0gPj0gMSkpCj4gICAgICAgICAgICAgICAgIGNvbnRyb2xfcmVnIHw9IEkyQ19DT05UUk9MX1JT
Owo+Cj4gICAgICAgICBpZiAoaTJjLT5vcCA9PSBJMkNfTUFTVEVSX1dSUkQpCj4gQEAgLTQ2NSw3
ICs0NjUsNyBAQCBzdGF0aWMgaW50IG10a19pMmNfZG9fdHJhbnNmZXIoc3RydWN0IG10a19pMmMg
KmkyYywgc3RydWN0IGkyY19tc2cgKm1zZ3MsCj4gICAgICAgICB3cml0ZXcoY29udHJvbF9yZWcs
IGkyYy0+YmFzZSArIE9GRlNFVF9DT05UUk9MKTsKPgo+ICAgICAgICAgLyogc2V0IHN0YXJ0IGNv
bmRpdGlvbiAqLwo+IC0gICAgICAgaWYgKGkyYy0+c3BlZWRfaHogPD0gMTAwMDAwKQo+ICsgICAg
ICAgaWYgKGkyYy0+c3BlZWRfaHogPD0gSTJDX0RFRkFVTFRfU1BFRUQpCj4gICAgICAgICAgICAg
ICAgIHdyaXRldyhJMkNfU1RfU1RBUlRfQ09OLCBpMmMtPmJhc2UgKyBPRkZTRVRfRVhUX0NPTkYp
Owo+ICAgICAgICAgZWxzZQo+ICAgICAgICAgICAgICAgICB3cml0ZXcoSTJDX0ZTX1NUQVJUX0NP
TiwgaTJjLT5iYXNlICsgT0ZGU0VUX0VYVF9DT05GKTsKPiBAQCAtNjQyLDggKzY0Miw2IEBAIHN0
YXRpYyBpbnQgbXRrX2kyY19kb190cmFuc2ZlcihzdHJ1Y3QgbXRrX2kyYyAqaTJjLCBzdHJ1Y3Qg
aTJjX21zZyAqbXNncywKPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FVElNRURPVVQ7Cj4gICAg
ICAgICB9Cj4KPiAtICAgICAgIGNvbXBsZXRpb25fZG9uZSgmaTJjLT5tc2dfY29tcGxldGUpOwo+
IC0KPiAgICAgICAgIGlmIChpMmMtPmlycV9zdGF0ICYgKEkyQ19IU19OQUNLRVJSIHwgSTJDX0FD
S0VSUikpIHsKPiAgICAgICAgICAgICAgICAgZGV2X2RiZyhpMmMtPmRldiwgImFkZHI6ICV4LCB0
cmFuc2ZlciBBQ0sgZXJyb3JcbiIsIG1zZ3MtPmFkZHIpOwo+ICAgICAgICAgICAgICAgICBtdGtf
aTJjX2luaXRfaHcoaTJjKTsKPiAtLQo+IDEuNy45LjUKPgo+Cj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxp
c3QKPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tZWRpYXRlawoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
