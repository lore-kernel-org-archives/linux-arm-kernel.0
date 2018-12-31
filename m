Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DE7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:37:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D9321783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CGhP5Rqz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQC9Z2zQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D9321783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9M3Cjq4p2lk6Ar7GU4cLOU3dlxoabeXHNY/jFNbc/i8=; b=CGhP5RqzMAn4Sj
	ap8MMY9Lq3XnSpzLOV0wmCeQxUpFtu0x32J8tpnkhKv98jIYceT+d+OUhXPmkTEthTaXkbKJ41556
	eFmDhBB78m3sg/GsjDd4cxCyrRnZJRv2SD01Nh3SVEk3oRvOZFTJy/SMgPCfve148yidI6JSRbtxG
	2qnk0sw6oWa4kK5p/XPt7LPr2SNFSNgoSJ/TsRxEeAKJC9+uFc0nRZKDOYyVe90iDCpyy+3MNbnh4
	zgzwGQU6mabMgrZuZYXbiLDP5bav/mdnucM0KgiIjW1K2gITqjlSy8CBFhySHiNRvmoHNh9YoTWGo
	AuKab545gP6sWA/q8MMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdvtB-00017B-NG; Mon, 31 Dec 2018 11:37:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdvt8-00016n-Pt
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 11:37:44 +0000
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8C55921871
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546256261;
 bh=b7yKPqndEmKWUgmsRkmbbqWx5vMBaYn8Bsc4wUnPXVo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=XQC9Z2zQgmZ0omf/lIam185INV2bPQZ7qrjpelkV2UcjVQwh6NQWdFxNJ1z1AwR3G
 mCIxnTYzPvNpH7JX5XXt44AbVFkzr6gmMlOHpjIiHljovvSERY0pSaJquN5iK3FAMX
 hzLAJnFmHY8zMlBD8oCN05k2bKCcJVxoUI96WMaI=
Received: by mail-lj1-f180.google.com with SMTP id s5-v6so23429975ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 03:37:41 -0800 (PST)
X-Gm-Message-State: AJcUukdInW5UEZAo1vrPb8JzK9BSfoeFejtLAjOxpeBK9R2amQAn6FYY
 MBb3NVAB9Gd0Ph56GIJwam5n5zk1e3nhtbLZeio=
X-Google-Smtp-Source: ALg8bN5+XVupxHZv0BKqm8A3CnCshN6LRhIwrndlRk4MwMDraAc//ZP3AttZr0BGPI5Yc8ANrGa4zQPK6buk3gaq/Js=
X-Received: by 2002:a2e:81d3:: with SMTP id
 s19-v6mr10434615ljg.138.1546256259610; 
 Mon, 31 Dec 2018 03:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228161819.18931-2-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181228161819.18931-2-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 31 Dec 2018 12:37:28 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf+Ut1ghXJnEqrUiz=r_ts-Bz3cum1LvUMOjEqWp8q+Vw@mail.gmail.com>
Message-ID: <CAJKOXPf+Ut1ghXJnEqrUiz=r_ts-Bz3cum1LvUMOjEqWp8q+Vw@mail.gmail.com>
Subject: Re: [PATCH 1/6] ARM: dts: s5pv210: Use correct fimd variant
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_033742_861347_14CCF0A4 
X-CRM114-Status: GOOD (  15.91  )
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
 xc-racer2@live.ca, linux@armlinux.org.uk, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyOCBEZWMgMjAxOCBhdCAxNzoxOCwgUGF3ZcWCIENobWllbAo8cGF3ZWwubWlrb2xh
ai5jaG1pZWxAZ21haWwuY29tPiB3cm90ZToKPgo+IFNpbmNlIHdlIGhhdmUgc2VwYXJhdGUgY29t
cGF0aWJsZSBmb3Igb3VyIFNPQywKPiBsZXQncyB1c2UgaXQgcmF0aGVyIHVzaW5nIG9uZSBmcm9t
IGV4eW5vczQyMTAuCgpQbGVhc2UgZml4CnlvdXIgZWRpdG9yCnRvIHdyYXAgbGluZXMKbWF0Y2hp
bmcgTGludXgKc3R5bGUgYmVjYXVzZQppdCBpcyBkaWZmaWN1bHQKdG8gcmVhZC4KCllvdSBoYXZl
IHVudXN1YWwgY29uZmlndXJhdGlvbiBiZWNhdXNlIG1vc3Qgb2YgdGhlIGVkaXRvcnMgd3JhcCBn
aXQKY29tbWl0IGFzIGV4cGVjdGVkLgpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9s
YXRlc3Qvc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0
I0w2MzMKCkJlc3QgcmVnYXJkcywKS3J6eXN6dG9mCgo+Cj4gU2lnbmVkLW9mZi1ieTogUGF3ZcWC
IENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgo+IC0tLQo+ICBhcmNoL2Fy
bS9ib290L2R0cy9zNXB2MjEwLmR0c2kgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRz
L3M1cHYyMTAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAuZHRzaQo+IGluZGV4IDc1
ZjQ1NGEyMTBkNi4uM2Q2ZTVhZDFlYTM1IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L3M1cHYyMTAuZHRzaQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAuZHRzaQo+IEBA
IC01MTEsNyArNTExLDcgQEAKPiAgICAgICAgICAgICAgICAgfTsKPgo+ICAgICAgICAgICAgICAg
ICBmaW1kOiBmaW1kQGY4MDAwMDAwIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRp
YmxlID0gInNhbXN1bmcsZXh5bm9zNDIxMC1maW1kIjsKPiArICAgICAgICAgICAgICAgICAgICAg
ICBjb21wYXRpYmxlID0gInNhbXN1bmcsczVwdjIxMC1maW1kIjsKPiAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZ2aWMyPjsKPiAgICAgICAgICAgICAgICAgICAg
ICAgICByZWcgPSA8MHhmODAwMDAwMCAweDIwMDAwPjsKPiAgICAgICAgICAgICAgICAgICAgICAg
ICBpbnRlcnJ1cHQtbmFtZXMgPSAiZmlmbyIsICJ2c3luYyIsICJsY2Rfc3lzIjsKPiAtLQo+IDIu
MTcuMQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
