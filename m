Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE004C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:53:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCCD20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GTUIL/Lp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0aslcSEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCCD20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gAn0ULpmvNUxHQpmD09vCSClw3aArzlYqh+xvwY0DzE=; b=GTUIL/LpwttK1g
	EXmo9yGX0nOtXWvxCuz4lsZ/mTc+ROmvx7Ts7xXUINp7MJ88gAPbS+b2orm3UX//YVhGaud/gmevA
	JKVXjSbWVLwAJw9chFmKcWPzscZsPFcRvPTbTqpDYnMlSfz6QDykCXLntt0/R/wjBmg7Dwarrd0jw
	fltbiqUJifkucL5hcq5H7AM5UunCaw62P0niDF2M/3RTb7wfMOyVrsQKC8d1/cv38cmihzkE8Pyee
	SPi97V4JgeaXUAHC0LWVoX2ygSexFyoCasMZDPWKp4t/sUyeGOObU7o/+F1QeObmhMU3isNXBmRIj
	DXFtGFwVokg89JEpJkjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggsl4-0006FW-Gd; Tue, 08 Jan 2019 14:53:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggsl2-0006F7-1T
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:53:33 +0000
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 08AEF20883
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  8 Jan 2019 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546959211;
 bh=dDcLr7PFigttfu9qxS0LqYl7q6wlG7peD973QvNyd3Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0aslcSEgIrTXWD0Jf+6BfY8Uw5IVTffG8q3wYlIjdy2YP54yzUHGzJ+y3zNpxtGZp
 zHIYp5y3b71eh6hdl0gObNjJADDz33Ct2NWTcRoFw6QOLst40pwcnSN4+Z9M80zruU
 +E07QYjYEKhH6T5e8um41fKaMmL30xN9XW33lSTE=
Received: by mail-qt1-f172.google.com with SMTP id u47so4608110qtj.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 06:53:30 -0800 (PST)
X-Gm-Message-State: AJcUukf+hxy356xKoTsIdr+b2L62sTLM18KJpKg6LePj7XS9MpbSEalc
 R3jSs8s4qvWE7wQPBEXe8aczXfXDB9t937La/g==
X-Google-Smtp-Source: ALg8bN5OGxu5emk9VpVjTgAoC4e6gwhWHhsD3YnTCVEEKOtdKzPp/ZPdgcSJuVjtVLcbXZzMwNYR1Pw/XH2yiZHeTms=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr1872256qtd.257.1546959210219; 
 Tue, 08 Jan 2019 06:53:30 -0800 (PST)
MIME-Version: 1.0
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <20181228232556.GA14277@bogus>
 <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
 <353b8f62-e265-c3c1-e352-d33c204eb6dc@ysoft.com>
In-Reply-To: <353b8f62-e265-c3c1-e352-d33c204eb6dc@ysoft.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Jan 2019 08:53:18 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+k3BvjP=oY=yGRiHgvy+yXjnzfT6H8V9HjVGf8MOQAYA@mail.gmail.com>
Message-ID: <CAL_Jsq+k3BvjP=oY=yGRiHgvy+yXjnzfT6H8V9HjVGf8MOQAYA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco,
 Hydra and Ursa boards
To: =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_065332_098344_F9F37F73 
X-CRM114-Status: GOOD (  13.45  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKYW4gOCwgMjAxOSBhdCA4OjI1IEFNIFZva8OhxI0gTWljaGFsIDxNaWNoYWwuVm9r
YWNAeXNvZnQuY29tPiB3cm90ZToKPgo+IE9uIDguMS4yMDE5IDEyOjQzLCBWb2vDocSNIE1pY2hh
bCB3cm90ZToKPiA+IE9uIDI5LjEyLjIwMTggMDA6MjUsIFJvYiBIZXJyaW5nIHdyb3RlOgo+ID4+
IE9uIFR1ZSwgRGVjIDE4LCAyMDE4IGF0IDAyOjQyOjExUE0gKzAwMDAsIFZva8OhxI0gTWljaGFs
IHdyb3RlOgo+IFsuLi5dCj4gPj4+ICsmaTJjMyB7Cj4gPj4+ICsgICBjbG9jay1mcmVxdWVuY3kg
PSA8MTAwMDAwPjsKPiA+Pj4gKyAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Cj4gPj4+ICsg
ICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfaTJjMz47Cj4gPj4+ICsgICBzdGF0dXMgPSAiZGlzYWJs
ZWQiOwo+ID4+PiArCj4gPj4+ICsgICBncGlvX29sZWQ6IGdwaW9ANDEgewo+ID4+PiArICAgICAg
ICAgICBjb21wYXRpYmxlID0gIm54cCxwY2E5NTM2IjsKPiA+Pj4gKyAgICAgICAgICAgZ3Bpby1j
b250cm9sbGVyOwo+ID4+PiArICAgICAgICAgICAjZ3Bpby1jZWxscyA9IDwyPjsKPiA+Pj4gKyAg
ICAgICAgICAgcmVnID0gPDB4NDE+Owo+ID4+PiArICAgICAgICAgICB2Y2Mtc3VwcGx5ID0gPCZz
dzJfcmVnPjsKPiA+Pj4gKyAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsKPiA+Pj4gKyAg
IH07Cj4gPj4+ICsKPiA+Pj4gKyAgIG9sZWQ6IG9sZWRAM2Qgewo+ID4+PiArICAgICAgICAgICBj
b21wYXRpYmxlID0gInNvbG9tb24sc3NkMTMwNWZiLWkyYyI7Cj4gPj4KPiA+PiBOb3QgZG9jdW1l
bnRlZC4KPiA+Cj4gPiBPSywgSSB3aWxsIHNlbmQgYSBzZXBhcmF0ZSBwYXRjaCBmb3IgdGhhdC4K
Pgo+IFJvYiwgSSBkb3VibGUgY2hlY2tlZCB0aGF0IGFuZCBpdCBhY3R1YWxseSBpcyBhbHJlYWR5
IGRvY3VtZW50ZWQuCj4gTm90IGluIGEgd2F5IHRoYXQgeW91IHdvdWxkIGZpbmQgdGhlIHdob2xl
IGNvbXBhdGlibGUgc3RyaW5nIHRob3VnaC4uCj4KPiBTZWUgaHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vbGludXgvdjUuMC1yYzEvc291cmNlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kaXNwbGF5L3NzZDEzMDdmYi50eHQjTDQKPgo+IEFyZSB5b3UgT0sgd2l0aCB0aGF0IGFz
IGl0IGlzPwoKQWgsIG9rYXkuIEl0J3MgZmluZS4KClJvYgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
