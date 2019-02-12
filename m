Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA49C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:41:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9691B2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="stKaihxY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y58azOvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9691B2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/xJZS80gOyxs6mCN3bCGniuZDZxaUAWaENfrouc+lI4=; b=stKaihxYVYiMeO
	+UWZSqMMpNrg7TVbWLGywY8jO3gWEUao+R0Kew4Jy5oXnTSk3fyKMD9BVdc+ECB1hqNMQloC3cmzW
	9p7NUlUHLJ/xqSDzTiwVv5KrERMj3jKryo7YYF+zy0fqWIDeU8rk5lNAVxm0jmh318r4HC3e6NDpJ
	Zb40ziEd2eBmZwJWMpWtYD67yRYZcaomtGsqFWQhzI1gZjy/b19brx2WJzIEhqQ+RC+0QT9LME9KF
	ApKjY9OHH2LyWviVb5qEwOP9cqkvQo2d5kTd6NhR448Fq2HOscbxjUPH1LurpH6o3BKMxli/4E0X2
	UCgVHaQPX8mK4DmmSxng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtSgg-0003S5-Ro; Tue, 12 Feb 2019 07:41:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtSgd-0003Ri-LE
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 07:41:01 +0000
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4E250218E0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 07:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549957258;
 bh=22c6w0mM8SX1qrkqCwOkIr6+XXGxbLmpsxYY+44otTM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=y58azOvoWqElTWDvVmuiRoJh4KwcPcT4uFU0+1yQNDN4wRKy/7VHeARcESubKdFcW
 uH1avxPyyAo6X4QqIlAWgUxw/HvEhxusBktsUJ9q+uURFMU3br3uUhJT8RHhjXFbCa
 a9ZzmNlV8XFIW6/etx3O92dZxC8tZEftz2kW0WGk=
Received: by mail-lj1-f169.google.com with SMTP id v14-v6so1368084ljv.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 23:40:58 -0800 (PST)
X-Gm-Message-State: AHQUAuY29Hy/Zp+jxc+vt6XNGDirnbmzomXO4zJl+XYVvFefAq3EveD9
 aBPip3t2Hj/YQwyfquT/dwxFmY21E3y2oFW54UY=
X-Google-Smtp-Source: AHgI3IYwJedyNAOZQ2WU2J994ecuC/FkCcLV/qm178dahnUgp/BRGPZisdHjKBuzxAX5sTIwF3t9wO0Nwtilj7QiSgc=
X-Received: by 2002:a2e:890b:: with SMTP id
 d11-v6mr1531161lji.113.1549957256391; 
 Mon, 11 Feb 2019 23:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20190211181531.GA3238@embeddedor>
In-Reply-To: <20190211181531.GA3238@embeddedor>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 12 Feb 2019 08:40:45 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com>
Message-ID: <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_234059_710377_4C55D855 
X-CRM114-Status: GOOD (  15.66  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org,
 Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAxMSBGZWIgMjAxOSBhdCAxOTo0MCwgR3VzdGF2byBBLiBSLiBTaWx2YQo8Z3VzdGF2
b0BlbWJlZGRlZG9yLmNvbT4gd3JvdGU6Cj4KPiBJbiBwcmVwYXJhdGlvbiB0byBlbmFibGluZyAt
V2ltcGxpY2l0LWZhbGx0aHJvdWdoLCBtYXJrIHN3aXRjaAo+IGNhc2VzIHdoZXJlIHdlIGFyZSBl
eHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLgo+Cj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgZm9sbG93
aW5nIHdhcm5pbmdzOgo+Cj4gZHJpdmVycy9jbGsvc2Ftc3VuZy9jbGstczNjMjQ0My5jOiBJbiBm
dW5jdGlvbiDigJhzM2MyNDQzX2NvbW1vbl9jbGtfaW5pdOKAmToKPiBkcml2ZXJzL2Nsay9zYW1z
dW5nL2Nsay1zM2MyNDQzLmM6MzkwOjM6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxs
IHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQo+ICAgIHNhbXN1bmdfY2xrX3JlZ2lz
dGVyX2FsaWFzKGN0eCwgczNjMjQ1MF9hbGlhc2VzLAo+ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+ICAgICAgQVJSQVlfU0laRShzM2MyNDUwX2Fs
aWFzZXMpKTsKPiAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KPiBkcml2ZXJzL2Ns
ay9zYW1zdW5nL2Nsay1zM2MyNDQzLmM6MzkzOjI6IG5vdGU6IGhlcmUKPiAgIGNhc2UgUzNDMjQx
NjoKPiAgIF5+fn4KPgo+IFdhcm5pbmcgbGV2ZWwgMyB3YXMgdXNlZDogLVdpbXBsaWNpdC1mYWxs
dGhyb3VnaD0zCj4KPiBOb3RpY2UgdGhhdCwgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UsICB0aGUg
Y29kZSBjb21tZW50IGlzIG1vZGlmaWVkCj4gaW4gYWNjb3JkYW5jZSB3aXRoIHdoYXQgR0NDIGlz
IGV4cGVjdGluZyB0byBmaW5kLgo+Cj4gVGhpcyBwYXRjaCBpcyBwYXJ0IG9mIHRoZSBvbmdvaW5n
IGVmZm9ydHMgdG8gZW5hYmxlCj4gLVdpbXBsaWNpdC1mYWxsdGhyb3VnaC4KCkkgc2F3IHRoaXMg
aW4gbXVsdGlwbGUgcGxhY2VzIGFscmVhZHkgYW5kIEkgdGhpbmsgZml4IGlzIHdyb25nLiBUaGUK
cG9pbnQgaXMgdGhhdCB0aGUgY29kZSBpcyBjb3JyZWN0IC0gdGhlIGZhbGwgdGhyb3VnaCBpcyBt
YXJrZWQKcHJvcGVybHkuCgpJdCBpcyBqdXN0IHRoZSBHQ0Mgd2hpY2ggaGFzIHRvIGJlIGZpeGVk
IG5vdCB0aGUgY29kZS4gWW91IHdhbnQgdG8KYWRqdXN0IHRoZSBjb2RlIGZvciBzcGVjaWZpYyB2
ZXJzaW9uIG9mIEdDQyBhbmQgd2hhdCBpZiBHQ0MgY2hhbmdlcwppdHMgd2FybmluZz8gRm9yIGV4
YW1wbGUgR0NDIG1pZ2h0IHJlcXVpcmUgImZhbGwgdGhyb3VnaDogIi4uLiBvciBhbnkKb3RoZXIg
c3ludGF4LiBBbm90aGVyIHBvaW50IC0gd2hhdCBhYm91dCBjbGFuZydzIHN5bnRheD8KCkJlc3Qg
cmVnYXJkcywKS3J6eXN6dG9mCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
