Return-Path: <SRS0=ikCU=PO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E15C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:21:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C082085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jlWr+EIy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="epezfUhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C082085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vanguardiasur.com.ar
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2V9sq78tT7I+uEIxvq1SmS04A0IhxbyFNrS1QocD0B8=; b=jlWr+EIyp6Dj7Y
	L7JtqOO9m8HyT+kn2Gg6Y/8mKoH7o1/uc/1l6qKiTkPn0UbASX5VCFJ1lDVGvGbpVjIZ4rOdeyYPF
	TM1MdGRn3OCi5GOyaDMP26P6cDcbMZENc+J1kLDO5wskWqAROE7B7GUltv5WxwvYdjMABmyYzgh35
	BaHh097gNBkZIR6/hh2FgtcqSTqhszDbiN8rGvWPbXXU/AgKQ2hOlro7/nW5Gw0EIthZhZQeZDz6Q
	BczdXtjE0KqpYm+YstXA2zZkUDlMa9hbYYrdaHM+6YO41iRJV32Ejy/SEv1ZFAPErEZPk5Vl3DWbK
	8kQLHxgbnj9w0NiNR5CQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggC7X-0003eR-BS; Sun, 06 Jan 2019 17:21:55 +0000
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggC7T-0003dA-9z
 for linux-arm-kernel@lists.infradead.org; Sun, 06 Jan 2019 17:21:53 +0000
Received: by mail-vk1-xa42.google.com with SMTP id t127so8924943vke.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 06 Jan 2019 09:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HPSHnGDRj6mLQSUv4JPQnsIrTLEbeoPCS38cByUX/n4=;
 b=epezfUhgmBqwhIhvIHE/lvh7L00rnGEJ3dPd8xdNuz6MwP341NTrbB+DPsfGgmTsR/
 VXiTWmHhYpN0/yYaCWb1xewj/cT2WWIr6oJtKBTNa1vgkPBasYlBN46PhIDqcUzFL64x
 CEKEShK9ndrbv2/AmjbV1LB5zEj9i8JsU3mjH8A6jq+cRkXcMN2p5hNEMoSJp6XMI8tl
 CU2IzYWumhFdtxM5grQBBJdjycUcxYTlb7AbQ8bdsFzBtO7FaAnYuQAkJ4sN1h1lbP8S
 4WoJKWHufP2Trg6Wp0+ZjFMZJGK7KSSRQRsRDr7Ko2bwSf2zO2q9TEeFhatfTIEgM03J
 cSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HPSHnGDRj6mLQSUv4JPQnsIrTLEbeoPCS38cByUX/n4=;
 b=cExSPyJEgEdaTCq2rn20o44gR5YQ02GwzIFVbKSO6irvO7Yoz9ITq7i+qpPhfTQ0Nf
 cbAM4KJ+6+W6VRn/f23l09KkFanHQRNfZS6vfWpPSEyInZAYT3CqwpYa5Y44IbMsD2Aq
 c7J3f2lRhlMnDhG1YenN4MOhcQsHRWhsJLWqLPF4bwRW9PYxZPP0Kkm8oezAEt0Kd66f
 MyA5tKfX9Tnv/H5iCcaPkAKw+ylddSRGM3JVr2uVBLl0F0b34cgsuzwFQLquHt2U/lR9
 ZiH04b7vbXJVk+rIdXTgG2v01FNcYdWG4yH49hDXdPy6Ubsv2R1uewGqRLR/ERlB0jqR
 3Qfw==
X-Gm-Message-State: AJcUukfuGysfmoygs4Gek9HQY0wG9PohnBqeg8+MlDfwtiHa+vm9k/b9
 a6+Oocqr3xpjBTjYwuL1AOeRpPMPM2JGaIX+YfjkOg==
X-Google-Smtp-Source: ALg8bN6dWLKjXcz6owlu3QI98SxUgZf7RBVuQjj4QJmGYCoI4qPMYvwSsNCgMbYxnMnuZxXdM6+rlWPg+Ok6dZhwylE=
X-Received: by 2002:a1f:85d3:: with SMTP id h202mr21550444vkd.69.1546795308953; 
 Sun, 06 Jan 2019 09:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20190105183150.20266-1-ayaka@soulik.info>
 <20190105183150.20266-5-ayaka@soulik.info>
 <50db3bc3faea97182b7fe18b4d9677f7e1563eaa.camel@collabora.com>
 <CAC7DE03-A74C-4154-9443-BC91E6CED02E@soulik.info>
 <f3dcd25bb1c3f0544cb7eedd0b27633d923c0d27.camel@collabora.com>
 <C53B5CFA-2F9C-41E1-BBA8-D63819D0AC3D@soulik.info>
In-Reply-To: <C53B5CFA-2F9C-41E1-BBA8-D63819D0AC3D@soulik.info>
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Sun, 6 Jan 2019 14:21:37 -0300
Message-ID: <CAAEAJfCLxvJWrC1CNiSyLV9y=pOjzUBik5SUD0ZVUcnA-+HobQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: add video codec for rk3399
To: Ayaka <ayaka@soulik.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_092151_540941_4661D9DE 
X-CRM114-Status: GOOD (  24.48  )
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
 Tomasz Figa <tfiga@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 myy@miouyouyou.fr, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Ezequiel Garcia <ezequiel@collabora.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU3VuLCA2IEphbiAyMDE5IGF0IDEzOjE2LCBBeWFrYSA8YXlha2FAc291bGlrLmluZm8+IHdy
b3RlOgo+Cj4KPgo+IFNlbnQgZnJvbSBteSBpUGFkCj4KPiA+IE9uIEphbiA3LCAyMDE5LCBhdCAx
MjowNCBBTSwgRXplcXVpZWwgR2FyY2lhIDxlemVxdWllbEBjb2xsYWJvcmEuY29tPiB3cm90ZToK
PiA+Cj4gPiBPbiBTdW4sIDIwMTktMDEtMDYgYXQgMjM6MDUgKzA4MDAsIEF5YWthIHdyb3RlOgo+
ID4+PiBPbiBKYW4gNiwgMjAxOSwgYXQgMTA6MjIgUE0sIEV6ZXF1aWVsIEdhcmNpYSA8ZXplcXVp
ZWxAY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4gPj4+Cj4gPj4+IEhpIFJhbmR5LAo+ID4+Pgo+ID4+
PiBUaGFua3MgYSBsb3QgZm9yIHRoaXMgcGF0Y2hlcy4gVGhleSBhcmUgcmVhbGx5IHVzZWZ1bAo+
ID4+PiB0byBwcm92aWRlIG1vcmUgaW5zaWdodCBpbnRvIHRoZSBWUFUgaGFyZHdhcmUuCj4gPj4+
Cj4gPj4+IFRoaXMgY2hhbmdlIHdpbGwgbWFrZSB0aGUgdnB1IGVuY29kZXIgYW5kIHZwdSBkZWNv
ZGVyCj4gPj4+IGNvbXBsZXRlbHkgaW5kZXBlbmRlbnQsIGNhbiB0aGV5IHJlYWxseSB3b3JrIGlu
IHBhcmFsbGVsPwo+ID4+IEFzIEkgc2FpZCBpdCBkZXBlbmRzIG9uIHRoZSBwbGF0Zm9ybSwgYnV0
IHdpdGggdGhpcyBwYXRjaCwgdGhlIHVzZXIgc3BhY2Ugd291bGQgdGhpbmsgdGhleSBjYW4gd29y
ayBhdCB0aGUgc2FtZSB0aW1lLgo+ID4KPiA+Cj4gPiBJIHRoaW5rIHRoZXJlIGlzIHNvbWUgY29u
ZnVzaW9uLgo+ID4KPiA+IFRoZSBkZXZpY2V0cmVlIGlzIG9uZSB0aGluZzogaXQgaXMgYSBoYXJk
d2FyZSByZXByZXNlbnRhdGlvbiwKPiA+IGEgd2F5IHRvIGRlc2NyaWJlIHRoZSBoYXJkd2FyZSwg
Zm9yIHRoZSBrZXJuZWwvYm9vdGxvYWRlciB0bwo+ID4gcGFyc2UuCj4gPgo+ID4gVGhlIHVzZXJz
cGFjZSB2aWV3IHdpbGwgZGVwZW5kIG9uIHRoZSBkcml2ZXIgaW1wbGVtZW50YXRpb24uCj4gPgo+
ID4gVGhlIGN1cnJlbnQgZGV2aWNldHJlZSBhbmQgZHJpdmVyICh3aXRob3V0IHlvdXIgcGF0Y2hl
cyksCj4gPiBtb2RlbCB0aGUgVlBVIGFzIGEgc2luZ2xlIHBpZWNlIG9mIGhhcmR3YXJlLCBleHBv
c2luZyBhIGRlY29kZXIKPiA+IGFuZCBhbiBlbmNvZGVyLgo+ID4KPiA+IFRoZSBWNEwgZHJpdmVy
IHdpbGwgdGhlbiBjcmVhdGUgdHdvIHZpZGVvIGRldmljZXMsIGkuZS4gL2Rldi92aWRlb1gKPiA+
IGFuZCAvZGV2L3ZpZGVvWS4gU28gdXNlcnNwYWNlIHNlZXMgYW4gaW5kZXBlbmRlbnQgdmlldyBv
ZiB0aGUKPiA+IGRldmljZXMuCj4gPgo+IEkga25ldyB0aGF0LCB0aGUgcHJvYmxlbSBpcyB0aGF0
IHRoZSBkcml2ZXIgc2hvdWxkIG5vdCBhbHdheXMgY3JlYXRlIGEgZGVjb2RlciBhbmQgZW5jb2Rl
ciBwYWlyLCB0aGV5IG1heSBub3QgZXhpc3QgYXQgc29tZSBwbGF0Zm9ybXMsIGV2ZW4gc29tZSBw
bGF0Zm9ybXMgZG9lc27igJl0IGhhdmUgYSBlbmNvZGVyLiBZb3UgbWF5IGhhdmUgYSBsb29rIG9u
IHRoZSByazMzMjggSSBwb3N0IG9uIHRoZSBmaXJzdCBlbWFpbCBhcyBleGFtcGxlLgoKVGhhdCBp
cyBjb3JyZWN0LiBCdXQgdGhhdCBzdGlsbCBkb2Vzbid0IHRhY2tsZSBteSBxdWVzdGlvbjogaXMg
dGhlCmhhcmR3YXJlIGFibGUgdG8gcnVuIGEgZGVjb2RpbmcgYW5kIGFuIGVuY29kaW5nIGpvYiBp
biBwYXJhbGxlbD8KCklmIG5vdCwgdGhlbiBpdCdzIHdyb25nIHRvIGRlc2NyaWJlIHRoZW0gYXMg
aW5kZXBlbmRlbnQgZW50aXRpZXMuCgo+ID4gSG93ZXZlciwgdGhleSBhcmUgaW50ZXJuYWxseSBj
b25uZWN0ZWQsIGFuZCB0aHVzIHdlIGNhbgo+ID4gZWFzaWx5IGF2b2lkIHR3byBqb2JzIHJ1bm5p
bmcgaW4gcGFyYWxsZWwuCj4gPgo+IFRoYXQgaXMgd2hhdCB0aGUgbXBwIHNlcnZpY2UgZGlkIGlu
IG15IHBhdGNoZXMsIGhhbmRpbmcgdGhlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIGVhY2ggZGV2aWNl
cy4gQW5kIGl0IGlzIG5vdCBhIGVhc3kgd29yaywgbWF5YmUgYSA0ayBkZWNvZGVyIHdvdWxkIGJl
IGJsb2NrZWQgYnkgYW5vdGhlciBoaWdoIGZyYW1lIHJhdGUgZW5jb2Rpbmcgd29yayBvciBhbm90
aGVyIGRlY29kZXIgc2Vzc2lvbi4gVGhlIHZlbmRvciBrZXJuZWwgaGF2ZSBtb3JlIHdvcnJ5IGFi
b3V0IHRoaXMsICBidXQgbm90IGluIHRoaXMgdmVyc2lvbi4KClJpZ2h0LiBUaGF0IGlzIG9uZSB3
YXkgdG8gZGVzaWduIGl0LiBBbm90aGVyIHdheSBpcyBoYXZpbmcgYSBzaW5nbGUKZGV2aWNldHJl
ZSBub2RlIGZvciB0aGUgVlBVIGVuY29kZXIvZGVjb2RlciAiY29tcGxleCIuCgpUaGFua3MgZm9y
IHRoZSBpbnB1dCEKLS0gCkV6ZXF1aWVsIEdhcmPDrWEsIFZhbmd1YXJkaWFTdXIKd3d3LnZhbmd1
YXJkaWFzdXIuY29tLmFyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
