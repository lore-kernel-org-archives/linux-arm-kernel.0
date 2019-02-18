Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD93C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:41:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D28920855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q1IKufnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D28920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qwZTdf+5db7cbJnAoKWdi/QcXO98X4g58i3ioAmnl38=; b=Q1IKufnjyuCc6I
	NWADnRqfQDHThHXrSup/bREyPS8T22Wte0s0qqgLEtY5u8o0O4UOa6c+YyGr+oJle40QKTd1Se6M+
	f+3tXH3waGm0Ge/ZpQl4B7FoqIm+eTUjVTusyXW9rWXvU/WXYBaKD83ZTHrl1Oce6vxO5q6CSBUK7
	IM7AJf3mWwmtIHbLQRx1gD+SiYahV1UhcBrp9T+NLjhd9jXIb5MSMDssaXZ7JHhsX0IKfCs3nvCQu
	B9Nzn7jplVjGkVu9aPWQbsqYrb7PRfkID2TshcbJgTdm6A3xYo1qtK93I54pRGgsIB+An8Kht67yR
	jhJ8ClBsnrmNrtJc7rQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfQD-0005an-Lf; Mon, 18 Feb 2019 09:41:09 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfQA-0005aM-1K
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:41:07 +0000
Received: by mail-qk1-f193.google.com with SMTP id a15so9626474qkc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 01:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rrcSbkomEh6gHuieQRX+3/MkTgpA7tlVku4hUeWDcSM=;
 b=UCwymjrWj4mZEmr04nPv3PrIxtDserU/FDCRBRdNO8rGNjrclELyn0FWmoYUGpcOBQ
 g0QRxf+U+fYS+E06e21zmpOBpJ7l0AsANZW9VexoGkKa/uQ2D1EpyjP7i3YbzQ6IniaW
 GhfUNEr3jfxMm5sTBsEFkCE1JBh8+wnfWdPKkqVi9a8wmUu55h+iUWzp81qSpdbhv8Y1
 cNOVKt9XRd00P56WqcX4b68nQQH1YLI8zH5O5801EwIxIxLDV6cidqThOuksCko5vRaI
 Iu7K6B2rsk/f3pkrtLXzVIuW/AO209N0KJZg1xkoeObXqHMBZduNAoBDdL5d8/qymPVF
 0Pug==
X-Gm-Message-State: AHQUAuZi/NA3qi3VDsos3Py0nJ9qsGbwVhzo1So5EmoVqe+Qo1jCc7oq
 l8THIbfaiPQzK3jzzDKl7LCikHegg86Uvzwp2H8=
X-Google-Smtp-Source: AHgI3IbrtAqAO2SvPa6Fao9Kr/nTOzuBhLlXNichKv7FMapZ7ztTe9PB3nS8iMNfxR626Cxd9Y6L4NIbVgfafqqGBXk=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr15249701qkf.107.1550482864589; 
 Mon, 18 Feb 2019 01:41:04 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-5-linus.walleij@linaro.org>
 <ffc97649-bfc2-e411-149f-cd5ed9e8c77e@arm.com>
 <CACRpkdZK7OU9rb-qw9tTjJLNvfQG-VmN_VBXUz9DPqVV11zuww@mail.gmail.com>
 <20190211221156.10036ad8@why.wild-wind.fr.eu.org> <m3k1hxvan4.fsf@t19.piap.pl>
 <CACRpkdYuvZEPzmeKo552g4DR3wxQZtw24jX3ONbmdoD_6bUSPw@mail.gmail.com>
In-Reply-To: <CACRpkdYuvZEPzmeKo552g4DR3wxQZtw24jX3ONbmdoD_6bUSPw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 10:40:47 +0100
Message-ID: <CAK8P3a1Y2kLeDYKGMGpuLk8rxUxFwuPvjMRoLj-c2a8Bnwi56w@mail.gmail.com>
Subject: Re: [PATCH 04/17 v1] irqchip: Add driver for IXP4xx
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_014106_079281_B006EEB9 
X-CRM114-Status: GOOD (  13.90  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 Tim Harvey <tharvey@gateworks.com>,
 =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
 Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
 Imre Kaloz <kaloz@openwrt.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgODoxNyBBTSBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxs
ZWlqQGxpbmFyby5vcmc+IHdyb3RlOgo+Cj4gT24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgODowNiBB
TSBLcnp5c3p0b2YgSGHFgmFzYSA8a2hhbGFzYUBwaWFwLnBsPiB3cm90ZToKPiA+IE1hcmMgWnlu
Z2llciA8bWFyYy56eW5naWVyQGFybS5jb20+IHdyaXRlczoKPiA+Cj4gPiA+IEl0J3Mgc3BlbGxl
ZCBCRTMyISA7LSkgSSB2YWd1ZWx5IHJlbWVtYmVyIGRvaW5nIHNvbWUgb2YgdGhhdCBvbiB2dWxj
YW4sCj4gPiA+IGJ1dCB0aGF0J3MgYSBkZWNhZGUgYWdvLCBhbmQgSSd2ZSBwYWdlZCBpdCBvdXQu
Li4gOy0pCj4gPgo+ID4gUmlnaHQuIEl0J3MgYWxzbyBjYWxsZWQgdmFsdWUtcHJlc2VydmluZyAo
d2hlcmUgdGhlICJ2YWx1ZSIgbXVzdCAzMi1iaXQKPiA+IGFuZCBhbGlnbmVkIG9uIDMyLWJpdCBi
b3VuZGFyeSkgb3IgKGRvdWJsZSkgd29yZCBpbnZhcmlhbnQuCj4gPgo+ID4gU2luY2UgbW9zdCBv
ZiB0aGVzZSBhY2Nlc3NlcyBhcmUgbmF0dXJhbCAzMi1iaXQgcmVnaXN0ZXJzIGFuZCAoYWxtb3N0
KQo+ID4gbm9uZSBhcmUgQVNDSUkvYnl0ZS1zdHlsZSwgaXQgbWFrZXMgc2Vuc2UuIElJUkMgdGhl
IFBDSSBoYXMgaXRzIG93bgo+ID4gcnVsZXMsIHRob3VnaC4KPgo+IElJVUMgUENJIHNob3VsZCBh
bHdheXMgYmUgTEUgYW5kIHJlYWRsKCkgd3JpdGVsKCkgYWx3YXlzIHJlYWQvd3JpdGUKPiBpbiBM
RS4gQnV0IEkgc2VlIFBDSSBvbiB0aGUgSVhQNHh4IGlzIGEgc3BlY2lhbCBoaXN0b3J5IHNvIEkg
YW0gZ29pbmcgdG8KPiBleHBlcmllbmNlIGl0IGluIGFsbCBpdHMgZ2xvcnkgbm93IHRoYXQgSSBz
dGFydCBsb29raW5nIGF0IGl0LgoKSSBmb3VuZCBhIGRvY3VtZW50IHRoYXQgZXhwbGFpbnMgc29t
ZSBvZiB0aGUgbW9yZSBvYnNjdXJlIGRldGFpbHMKb2YgdGhpcyBjaGlwIChhbW9uZyBhIGxvdCBv
ZiB0aGUgZ2VuZXJhbCBjb25jZXB0cyksIGluIHBhcnRpY3VsYXIgaG93CnlvdSBjYW4gY29uZmln
dXJlIG1lbW9yeSByZWdpb25zIGFzIGVpdGhlciBCRSwgTEUtZGF0YS1jb2hlcmVudCBvcgpMRS1h
ZGRyZXNzLWNvaGVyZW50LCBhbmQgdGhlIGJ5dGUgc3dhcCBvbiBQQ0kgZGVwZW5kaW5nIG9uIHRo
YXQ6CgpodHRwczovL3d3dy5pbnRlbC5jb20vY29udGVudC93d3cvdXMvZW4vaW50ZWxsaWdlbnQt
c3lzdGVtcy9wcmV2aW91cy1nZW5lcmF0aW9uL2l4cDR4eC1peGMxMTAwLWJpZy1lbmRpYW4tbGl0
dGxlLWVuZGlhbi1tb2Rlcy1hcHAtbm90ZS5odG1sCgogICAgICBBcm5kCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
