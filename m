Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D45C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:27:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575C52086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kmnfFRlN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BuJgVxzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575C52086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Csflez5ZtOBQHDV9dkHL+j03Se09bGb20ZCNSxYDy9E=; b=kmnfFRlN1pbIgx
	om6K3ghTB2TwJbCsli00HA/sTPsQSaMZybNUjB+3JHAdMrF8do5W7YoBwI8qsilXWoxuZMXmkm/+a
	oN5KSKYF0SvLf0yGDiKqTPe6V2maMMEQzrL0sIp/xkd1zXGT9xzBP8e8vvVx/RC23745YDnMmksJ+
	9FdPDovx6oy/o1ONIwlveyDXotQWXMYLm5+7DAanRHFk7dBhzIJM6YKJ1KxBjJBV73fQzI/1a7KI0
	+eIH4WjfZjQzvMT99HGi00mRij8bChi/z4n44HbNHifknVWaq0zQRS2ahT6ipsOgrBXitALqN3wF7
	60gkKi/VbmASrwn/rRbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs906-0003Gr-10; Fri, 08 Feb 2019 16:27:38 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs901-0003G1-OZ
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 16:27:35 +0000
Received: by mail-ot1-x343.google.com with SMTP id e12so6762867otl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 08:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4MrPTQfL+aqliH6C1atcII6SPJlu1ysjr91YRTpgFmE=;
 b=BuJgVxzHyi1y7uQnhs6w7HKPQs4iM0vxEbQNuSuFbEd/7biWtL3H2C7hZKGjafvTvQ
 sUkJpTsgqUQcaiaFVi5Z4F9pbKQkiFpj1nhw/JIfDE34PPDVkbH+Xw+enEf618vXwGoB
 VRFwqtHcEdPJ40vNsDFf/MrzMphsCeSGhSVDMtqKpDYtDwDCXGDTyFVVk4lu7lbd5E/6
 45xyEBFBF/mwHEIl++wXacjcPSZ6N24LMdI3gy5SjJdKUqKmMl053LSgxMsghLwTEogA
 RwesFZP6ZKerisv+1tXyhSUi8kTmvbajckU4O+8LIkIvBc3fNv8YndyqeML5VvkDmZhf
 8igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4MrPTQfL+aqliH6C1atcII6SPJlu1ysjr91YRTpgFmE=;
 b=r171X1jz/SsRaQQq8AhkjCHV1vjJXnkjH1GJOOQs6WoebX9duFlF9WjFNkUDHalq+a
 WblByuOZEpmZyiA42n63Cb6Fz0V64qN0aYRINhKkhOGdVrSDkD+Or1bP9CVQOWGfPtGO
 Y7GiPbd5kwbd3AkoxR1fxrZ4/27zRNOksD0jtgS0eyUrHjyNcUELcZ/mPvNlLaLbxILa
 AXKBfUsK+5XC0qDldkqfPV+6us9GqcfStTGqllfLaZevuWlnnxAOnKonQ9TkbUaZNBOQ
 Mdm2UF0KW+8VavPjvMNYiLqMZ5zhPfEo7jqpknSxv37ZmzjKsnhogUZY2HUNz7Ln/rwb
 xmEA==
X-Gm-Message-State: AHQUAua6WEOqKyfa5ed1gI1VTxJ61TGt30xt87hmRYBYX/cSxXplefgO
 zx6CS5gns8b3qg40wBQeGXNS/9ojExPcIRqfhjme8w==
X-Google-Smtp-Source: AHgI3Ia6gpOAthSEpzLP+vPzXW0Qx9oCEdIIRnwkCqfklMtUWvLhhBJKVFu9r+KSGST9fwgMqUCG89i4gvDUEnBsN3k=
X-Received: by 2002:a9d:76c5:: with SMTP id p5mr13458873otl.108.1549643252459; 
 Fri, 08 Feb 2019 08:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-26-brgl@bgdev.pl>
 <55b5797c-ee0b-c2d8-9eb9-0d681da08018@lechnology.com>
In-Reply-To: <55b5797c-ee0b-c2d8-9eb9-0d681da08018@lechnology.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 8 Feb 2019 17:27:21 +0100
Message-ID: <CAMpxmJWSJQyb+36ZEurULT+Bh306kiqXxkwUg_Yg-Jzu4GEpFQ@mail.gmail.com>
Subject: Re: [PATCH 25/35] ARM: davinci: cp-intc: use the new-style config
 structure
To: David Lechner <david@lechnology.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_082733_917773_178E8CC8 
X-CRM114-Status: GOOD (  16.72  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Kevin Hilman <khilman@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Sekhar Nori <nsekhar@ti.com>, LKML <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

d3QuLCA1IGx1dCAyMDE5IG8gMDE6MjkgRGF2aWQgTGVjaG5lciA8ZGF2aWRAbGVjaG5vbG9neS5j
b20+IG5hcGlzYcWCKGEpOgo+Cj4gT24gMS8zMS8xOSA3OjM5IEFNLCBCYXJ0b3N6IEdvbGFzemV3
c2tpIHdyb3RlOgo+ID4gRnJvbTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJh
eWxpYnJlLmNvbT4KPiA+Cj4gPiBNb2RpZnkgdGhlIGNwLWludGMgZHJpdmVyIHRvIHRha2UgYWxs
IGl0cyBjb25maWd1cmF0aW9uIGZyb20gdGhlIG5ldwo+ID4gY29uZmlnIHN0cnVjdHVyZS4gU3Rv
cCByZWZlcmVuY2luZyBkYXZpbmNpX3NvY19pbmZvIGluIGFueSB3YXkuCj4gPiBNb3ZlIHRoZSBk
ZWNsYXJhdGlvbiBmb3IgZGF2aW5jaV9jcF9pbnRjX2luaXQoKSB0bwo+ID4gaXJxLWRhdmluY2kt
Y3AtaW50Yy5oIGFuZCBtYWtlIGl0IHRha2UgdGhlIG5ldyBjb25maWcgc3RydWN0dXJlIGFzCj4g
PiBwYXJhbWV0ZXIuIENvbnZlcnQgYWxsIHVzZXJzIHRvIHRoZSBuZXcgdmVyc2lvbi4KPiA+Cj4g
PiBBbHNvOiBzaW5jZSB0aGUgdHdvIGRhOHh4IFNvQ3MgZGVmYXVsdCBhbGwgaXJxIHByaW9yaXRp
ZXMgdG8gNywganVzdAo+ID4gZHJvcCB0aGUgcHJpb3JpdHkgY29uZmlndXJhdGlvbiBhdCBhbGwg
YW5kIGhhcmRjb2RlIHRoZSBjaGFubmVscyB0byA3Lgo+Cj4gQXMgbWVudGlvbmVkIGluIGEgY29t
bWVudCBvbiBhIGRpZmZlcmVudCBwYXRjaCwgdGhpcyBpc24ndCBzdHJpY3RseQo+IHRydWUgKGFs
dGhvdWdoIGluIHByYWN0aWNlLCBpdCBwcm9iYWJseSBpcykuCj4KPiBUaGlzIHBhdGNoIGRlbGV0
ZXMgYSBjb2RlIHBhdGggd2l0aCB0aGUgY29tbWVudCAiRGVmYXVsdCBldmVyeXRoaW5nCj4gdG8g
Y2hhbm5lbCAxNSBpZiBwcmlvcml0eSBub3Qgc3BlY2lmaWVkLiIsIHNvIGl0IGlzIHBvc3NpYmxl
IChhbHRob3VnaAo+IHVubGlrZWx5KSB0aGF0IHRoaXMgcGF0Y2ggY291bGQgY2hhbmdlIGEgcHJp
b3JpdHkgb2Ygc29tZSBJUlEgdGhhdCBpcwo+IGJlaW5nIHVzZWQuCj4KClRoaXMgb25seSBoYXBw
ZW5zIGlmIG5vIHByaW9yaXRpZXMgYXJlIHNwZWNpZmllZC4gT3RoZXJ3aXNlIHdlIGp1c3QKaXRl
cmF0ZSBvdmVyIHRoZSBwcm92aWRlZCBhcnJheSBhbmQgc2V0IHByaW9yaXRpZXMgZm9yIGFsbCBp
bnRlcnJ1cHRzLgoKQmFydAoKPiA+Cj4gPiBJdCB3aWxsIHNpbXBsaWZ5IHRoZSBkcml2ZXIgY29k
ZSBhbmQgbWFrZSBvdXIgbGl2ZXMgZWFzaWVyIHdoZW4gaXQKPiA+IGNvbWVzIHRvIGRldmljZS10
cmVlIHN1cHBvcnQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogQmFydG9zeiBHb2xhc3pld3NraSA8
YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4KPiA+IC0tLQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
