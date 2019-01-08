Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C98CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:34:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04292089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cc69I2uW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EZlFwg9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04292089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Woh07ui0SOwHKO6E/UafKVDwjA8antW206R6FY1lYh4=; b=Cc69I2uWeKq6JI
	FfyElv6VNxqzQMWY38iJLIFwdadgNCiV7vRYMk2deB7NdqfbNBRK6M51itDINSBeNkRcEd99qnBnJ
	YrHnB7aqoHMhuR1L7BJzDajd6kvXTIhqsxVjXM2J7r3aUN+xou0AUybR5eUX2SQOaxpMMW+CLbjDB
	vTDvU801PyxVBrTv9PPM0XoyMWhx846jXh815kmscHgqcpFsH0lJ4vpC06BZRpTUgXxWDpWq27Y1w
	5WjmeaAqvgw1v0FGnDhcl+Xf8eM5lsY9UMZl5iMQeVHdrPET+n6VVZLlcDN+XLRyvXsRFjmK/sHlR
	mRXFsZ9D6gvVe8wCDuyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggkxl-0000nO-EY; Tue, 08 Jan 2019 06:34:09 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggkxh-0000mO-4r
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 06:34:06 +0000
Received: by mail-oi1-x243.google.com with SMTP id y1so2435745oie.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 22:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5se9eY7y1Ym3hFdOMq25vpueA+u0CSGdgKEFNkPduC8=;
 b=EZlFwg9drOm9lYYarTO0yDRZt6A5nSZavlsxxTbNY3d2aFBHx6ettvSprbgLDWMMNc
 8Bh52f2GhPgxN+HDTg5UecEZ6ybhyrjGvLUd95D0BqSeGwuEEq3BP1Kc1MQbygRnh/MK
 XW4SlUit3Cfvq6zjlT/n/Xh85ZnOjwgnmNMOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5se9eY7y1Ym3hFdOMq25vpueA+u0CSGdgKEFNkPduC8=;
 b=mXc+loWyJKI1Q86Pk9EqOob8QXbi3/Z4IuPSvIuQlZQ4HAhVgtOxTVDXUytsai1okd
 BypPbN9ky65K1o/e4MgY+wA4HyOXTVa2Z/abimBYCKakIW5TzMOioKV4xpp5V2nkJ1Pc
 aytdAC8rYWnIaizOXRIq1Mc8+SzFXEoTozTT3Evy3kK82uET3If9++nEx7coz6U1f0KR
 u+c8iTHVcRnGlPg8zX4dgtjKyrT/xvpcv3A9iBpPSE111RM3rMrMLERAic+3xGlX2KBR
 fkPNu4mfRRpw3Il6ujmCHkG7q00hHfZPyNc1ex2LY3VVyD+fiOr2u37Fhix6IcMN4tDY
 nBtQ==
X-Gm-Message-State: AJcUukdx0ZwKK9ZLUH2yuiFlQq9/b0RrLzJyaF8PHn+eyDQkMc5PGXQF
 jz9WRn3QcoTfaRTBizF5umI2qohfSAX6Cg==
X-Google-Smtp-Source: ALg8bN7fidJ6uPHW7EJKh5H2xwxUIVyWmCzHYeY84qtestL9f1+ajoatLWj87nYj9pt8dHqQsjQvnQ==
X-Received: by 2002:aca:ab16:: with SMTP id u22mr361465oie.249.1546929241195; 
 Mon, 07 Jan 2019 22:34:01 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com.
 [209.85.167.175])
 by smtp.gmail.com with ESMTPSA id x9sm29337902otq.73.2019.01.07.22.33.59
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 22:34:00 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id c206so2494967oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 22:33:59 -0800 (PST)
X-Received: by 2002:aca:b882:: with SMTP id i124mr369829oif.127.1546929239276; 
 Mon, 07 Jan 2019 22:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20190105183150.20266-1-ayaka@soulik.info>
 <20190105183150.20266-5-ayaka@soulik.info>
 <50db3bc3faea97182b7fe18b4d9677f7e1563eaa.camel@collabora.com>
 <CAC7DE03-A74C-4154-9443-BC91E6CED02E@soulik.info>
 <f3dcd25bb1c3f0544cb7eedd0b27633d923c0d27.camel@collabora.com>
 <C53B5CFA-2F9C-41E1-BBA8-D63819D0AC3D@soulik.info>
 <CAAEAJfCLxvJWrC1CNiSyLV9y=pOjzUBik5SUD0ZVUcnA-+HobQ@mail.gmail.com>
 <85C6CA4D-CC54-422B-BC2B-25EA10701696@soulik.info>
In-Reply-To: <85C6CA4D-CC54-422B-BC2B-25EA10701696@soulik.info>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 8 Jan 2019 15:33:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AaVonqn92F=Oa_s_5fkn566+xubO5ijqHmnjg7d4j-8A@mail.gmail.com>
Message-ID: <CAAFQd5AaVonqn92F=Oa_s_5fkn566+xubO5ijqHmnjg7d4j-8A@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: add video codec for rk3399
To: Ayaka <ayaka@soulik.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_223405_212248_FABF85FF 
X-CRM114-Status: GOOD (  28.00  )
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
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 myy@miouyouyou.fr, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Ezequiel Garcia <ezequiel@collabora.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBKYW4gNywgMjAxOSBhdCAyOjMwIEFNIEF5YWthIDxheWFrYUBzb3VsaWsuaW5mbz4g
d3JvdGU6Cj4KPiBIZWxsbyBFemVxdWllbAo+Cj4gU2VudCBmcm9tIG15IGlQYWQKPgo+ID4gT24g
SmFuIDcsIDIwMTksIGF0IDE6MjEgQU0sIEV6ZXF1aWVsIEdhcmNpYSA8ZXplcXVpZWxAdmFuZ3Vh
cmRpYXN1ci5jb20uYXI+IHdyb3RlOgo+ID4KPiA+PiBPbiBTdW4sIDYgSmFuIDIwMTkgYXQgMTM6
MTYsIEF5YWthIDxheWFrYUBzb3VsaWsuaW5mbz4gd3JvdGU6Cj4gPj4KPiA+Pgo+ID4+Cj4gPj4g
U2VudCBmcm9tIG15IGlQYWQKPiA+Pgo+ID4+PiBPbiBKYW4gNywgMjAxOSwgYXQgMTI6MDQgQU0s
IEV6ZXF1aWVsIEdhcmNpYSA8ZXplcXVpZWxAY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4gPj4+Cj4g
Pj4+IE9uIFN1biwgMjAxOS0wMS0wNiBhdCAyMzowNSArMDgwMCwgQXlha2Egd3JvdGU6Cj4gPj4+
Pj4gT24gSmFuIDYsIDIwMTksIGF0IDEwOjIyIFBNLCBFemVxdWllbCBHYXJjaWEgPGV6ZXF1aWVs
QGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+ID4+Pj4+Cj4gPj4+Pj4gSGkgUmFuZHksCj4gPj4+Pj4K
PiA+Pj4+PiBUaGFua3MgYSBsb3QgZm9yIHRoaXMgcGF0Y2hlcy4gVGhleSBhcmUgcmVhbGx5IHVz
ZWZ1bAo+ID4+Pj4+IHRvIHByb3ZpZGUgbW9yZSBpbnNpZ2h0IGludG8gdGhlIFZQVSBoYXJkd2Fy
ZS4KPiA+Pj4+Pgo+ID4+Pj4+IFRoaXMgY2hhbmdlIHdpbGwgbWFrZSB0aGUgdnB1IGVuY29kZXIg
YW5kIHZwdSBkZWNvZGVyCj4gPj4+Pj4gY29tcGxldGVseSBpbmRlcGVuZGVudCwgY2FuIHRoZXkg
cmVhbGx5IHdvcmsgaW4gcGFyYWxsZWw/Cj4gPj4+PiBBcyBJIHNhaWQgaXQgZGVwZW5kcyBvbiB0
aGUgcGxhdGZvcm0sIGJ1dCB3aXRoIHRoaXMgcGF0Y2gsIHRoZSB1c2VyIHNwYWNlIHdvdWxkIHRo
aW5rIHRoZXkgY2FuIHdvcmsgYXQgdGhlIHNhbWUgdGltZS4KPiA+Pj4KPiA+Pj4KPiA+Pj4gSSB0
aGluayB0aGVyZSBpcyBzb21lIGNvbmZ1c2lvbi4KPiA+Pj4KPiA+Pj4gVGhlIGRldmljZXRyZWUg
aXMgb25lIHRoaW5nOiBpdCBpcyBhIGhhcmR3YXJlIHJlcHJlc2VudGF0aW9uLAo+ID4+PiBhIHdh
eSB0byBkZXNjcmliZSB0aGUgaGFyZHdhcmUsIGZvciB0aGUga2VybmVsL2Jvb3Rsb2FkZXIgdG8K
PiA+Pj4gcGFyc2UuCj4gPj4+Cj4gPj4+IFRoZSB1c2Vyc3BhY2UgdmlldyB3aWxsIGRlcGVuZCBv
biB0aGUgZHJpdmVyIGltcGxlbWVudGF0aW9uLgo+ID4+Pgo+ID4+PiBUaGUgY3VycmVudCBkZXZp
Y2V0cmVlIGFuZCBkcml2ZXIgKHdpdGhvdXQgeW91ciBwYXRjaGVzKSwKPiA+Pj4gbW9kZWwgdGhl
IFZQVSBhcyBhIHNpbmdsZSBwaWVjZSBvZiBoYXJkd2FyZSwgZXhwb3NpbmcgYSBkZWNvZGVyCj4g
Pj4+IGFuZCBhbiBlbmNvZGVyLgo+ID4+Pgo+ID4+PiBUaGUgVjRMIGRyaXZlciB3aWxsIHRoZW4g
Y3JlYXRlIHR3byB2aWRlbyBkZXZpY2VzLCBpLmUuIC9kZXYvdmlkZW9YCj4gPj4+IGFuZCAvZGV2
L3ZpZGVvWS4gU28gdXNlcnNwYWNlIHNlZXMgYW4gaW5kZXBlbmRlbnQgdmlldyBvZiB0aGUKPiA+
Pj4gZGV2aWNlcy4KPiA+Pj4KPiA+PiBJIGtuZXcgdGhhdCwgdGhlIHByb2JsZW0gaXMgdGhhdCB0
aGUgZHJpdmVyIHNob3VsZCBub3QgYWx3YXlzIGNyZWF0ZSBhIGRlY29kZXIgYW5kIGVuY29kZXIg
cGFpciwgdGhleSBtYXkgbm90IGV4aXN0IGF0IHNvbWUgcGxhdGZvcm1zLCBldmVuIHNvbWUgcGxh
dGZvcm1zIGRvZXNu4oCZdCBoYXZlIGEgZW5jb2Rlci4gWW91IG1heSBoYXZlIGEgbG9vayBvbiB0
aGUgcmszMzI4IEkgcG9zdCBvbiB0aGUgZmlyc3QgZW1haWwgYXMgZXhhbXBsZS4KPiA+Cj4gPiBU
aGF0IGlzIGNvcnJlY3QuIEJ1dCB0aGF0IHN0aWxsIGRvZXNuJ3QgdGFja2xlIG15IHF1ZXN0aW9u
OiBpcyB0aGUKPiA+IGhhcmR3YXJlIGFibGUgdG8gcnVuIGEgZGVjb2RpbmcgYW5kIGFuIGVuY29k
aW5nIGpvYiBpbiBwYXJhbGxlbD8KPiA+Cj4gRm9yIHJrMzMyOCwgeWVzLCB5b3Ugc2VlIEkgZGlk
buKAmXQgZHJhdyB0aGVtIGluIHRoZSBzYW1lIGJveC4KPiA+IElmIG5vdCwgdGhlbiBpdCdzIHdy
b25nIHRvIGRlc2NyaWJlIHRoZW0gYXMgaW5kZXBlbmRlbnQgZW50aXRpZXMuCj4gPgo+ID4+PiBI
b3dldmVyLCB0aGV5IGFyZSBpbnRlcm5hbGx5IGNvbm5lY3RlZCwgYW5kIHRodXMgd2UgY2FuCj4g
Pj4+IGVhc2lseSBhdm9pZCB0d28gam9icyBydW5uaW5nIGluIHBhcmFsbGVsLgo+ID4+Pgo+ID4+
IFRoYXQgaXMgd2hhdCB0aGUgbXBwIHNlcnZpY2UgZGlkIGluIG15IHBhdGNoZXMsIGhhbmRpbmcg
dGhlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIGVhY2ggZGV2aWNlcy4gQW5kIGl0IGlzIG5vdCBhIGVh
c3kgd29yaywgbWF5YmUgYSA0ayBkZWNvZGVyIHdvdWxkIGJlIGJsb2NrZWQgYnkgYW5vdGhlciBo
aWdoIGZyYW1lIHJhdGUgZW5jb2Rpbmcgd29yayBvciBhbm90aGVyIGRlY29kZXIgc2Vzc2lvbi4g
VGhlIHZlbmRvciBrZXJuZWwgaGF2ZSBtb3JlIHdvcnJ5IGFib3V0IHRoaXMsICBidXQgbm90IGlu
IHRoaXMgdmVyc2lvbi4KPiA+Cj4gPiBSaWdodC4gVGhhdCBpcyBvbmUgd2F5IHRvIGRlc2lnbiBp
dC4gQW5vdGhlciB3YXkgaXMgaGF2aW5nIGEgc2luZ2xlCj4gPiBkZXZpY2V0cmVlIG5vZGUgZm9y
IHRoZSBWUFUgZW5jb2Rlci9kZWNvZGVyICJjb21wbGV4Ii4KPiBObywgeW91IGNhbuKAmXQgYXNz
dW1lIHdoaWNoIG9uZSBpcyBpbiB0aGUgY29tYm8gZ3JvdXAsIGl0IGNhbiBiZSB2YXJpb3VzLiB5
b3Ugc2VlLCBpbiB0aGUgcmszMzI4LCB0aGUgdmRwdSBpcyBwYWlyZWQgd2l0aCBhbiBhdnMrIGRl
Y29kZXIuIFRoYXQgaXMgd2h5IEkgdXNlIGEgdmlydHVhbCBkZXZpY2Ugc3RhbmRpbmcgZm9yIHNj
aGVkdWxlci4KCkZpcnN0IG9mIGFsbCwgdGhhbmtzIGZvciBhbGwgdGhlIGlucHV0LiBIYXZpbmcg
bW9yZSB1bmRlcnN0YW5kaW5nIG9mCnRoZSBoYXJkd2FyZSBhbmQgc2hvcnRjb21pbmdzIG9mIHRo
ZSBjdXJyZW50IFY0TDIgQVBJcyBpcyByZWFsbHkKaW1wb3J0YW50IHRvIGxldCB1cyBmdXJ0aGVy
IGV2b2x2ZSB0aGUgQVBJIGFuZCBtYWtlIHN1cmUgdGhhdCBpdCB3b3Jrcwpmb3IgZnVydGhlciB1
c2UgY2FzZXMuCgpBcyBmb3IgdGhlIERldmljZSBUcmVlIGl0c2VsZiwgaXQgZG9lc24ndCBhbHdh
eXMgZGVzY3JpYmUgdGhlIGhhcmR3YXJlCmluIDEwMCUuIE1vc3Qgb2YgdGhlIHRpbWUgaXQncyBq
dXN0IHRoZSBuZWNlc3NhcnkgaW5mb3JtYXRpb24gdG8KY2hvb3NlIGFuZCBpbnN0YW50aWF0ZSB0
aGUgcmlnaHQgZHJpdmVycyBhbmQgYmluZCB0byB0aGUgcmlnaHQKaGFyZHdhcmUgcmVzb3VyY2Vz
LiBUaGUgaW5mb3JtYXRpb24gb24gd2hpY2ggaGFyZHdhcmUgaW5zdGFuY2VzIG9uIHRoZQpTb0Mg
Y2FuIHdvcmsgaW5kZXBlbmRlbnRseSBjYW4gb2YgY291cnNlIGJlIGRlc2NyaWJlZCBpbiBEVCAo
ZS5nLiBieQpzdWItbm9kZXMgb2YgYSB2aWRlby1jb2RlYyBjb21wbGV4IE9SIGEgc2V0IG9mIHBo
YW5kbGVzLCBlLmcuCnJvY2tjaGlwLHNoYXJlZC1pbnN0YW5jZXMpLCBidXQgaXQncyBhbHNvIHBl
cmZlY3RseSBmaW5lIHRvIGRlZmVyIHRoaXMKa2luZCBvZiBrbm93bGVkZ2UgdG8gdGhlIGRyaXZl
cnMgdGhlbXNlbHZlcy4KCkJlc3QgcmVnYXJkcywKVG9tYXN6CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
