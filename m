Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CE5C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:01:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942E62082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="geqyHTPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942E62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VA2QFdwcnmEwK827+TykIPB9BrmkLqSFv6hgyNvP7+8=; b=geqyHTPbaERjUP
	2MCYyKHbg27mbH+lt7gle2Pg3mYJ4zLgL08Ax28hlhdvRM4Z1E+PFoTKXXyKLO+cYitNx6yC340uV
	4mRSA0jg+GiHvZ9VhGhGNkeCnwvdDIjfJQtjoS3Q6fsmJQLV3x9cb00ME0c0mgwpGpAmiWun5I2Fq
	ChIpnMQznTjYg6Ui1lV3UB3q24lvJzSTP1hzlbG82Vo09TlH28u/BbQuIHmXcd1kNRF9k0JkjwNMG
	JH0B9majO2lgMpELuXD6a0ZcaAo+Ls7PKau+X1lQURPhWu6vVmblIWOqwDwTZ+rWItUbCGZLPm2m9
	On/y53BhvU+bGsjIuTDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHRA-0005gj-Jw; Mon, 10 Dec 2018 09:01:12 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHR2-0005fY-Vc
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:01:11 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6D51820CE8; Mon, 10 Dec 2018 10:00:52 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 57D8A20E31;
 Mon, 10 Dec 2018 10:00:34 +0100 (CET)
Message-ID: <c276fb045ab285c0907c4831f3b71a31f09cd4a5.camel@bootlin.com>
Subject: Re: [linux-sunxi] [PATCH v2 15/15] arm64: dts: allwinner: a64: Add
 Video Engine node
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>, 
 linux-sunxi@googlegroups.com
Date: Mon, 10 Dec 2018 10:00:34 +0100
In-Reply-To: <2823800.C4zEU5jiS7@jernej-laptop>
References: <20181205092444.29497-1-paul.kocialkowski@bootlin.com>
 <20181205092444.29497-16-paul.kocialkowski@bootlin.com>
 <2823800.C4zEU5jiS7@jernej-laptop>
Organization: Bootlin
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_010105_154833_2BE9861E 
X-CRM114-Status: GOOD (  16.53  )
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
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org,
 Hans Verkuil <hverkuil@xs4all.nl>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpPbiBGcmksIDIwMTgtMTItMDcgYXQgMjI6MjIgKzAxMDAsIEplcm5laiDFoGtyYWJlYyB3
cm90ZToKPiBIaSEKPiAKPiBEbmUgc3JlZGEsIDA1LiBkZWNlbWJlciAyMDE4IG9iIDEwOjI0OjQ0
IENFVCBqZSBQYXVsIEtvY2lhbGtvd3NraSBuYXBpc2FsKGEpOgo+ID4gVGhpcyBhZGRzIHRoZSBW
aWRlbyBFbmdpbmUgbm9kZSBmb3IgdGhlIEE2NC4gU2luY2UgaXQgY2FuIG1hcCB0aGUgd2hvbGUK
PiA+IERSQU0gcmFuZ2UsIHRoZXJlIGlzIG5vIHBhcnRpY3VsYXIgbmVlZCBmb3IgYSByZXNlcnZl
ZCBtZW1vcnkgbm9kZQo+ID4gKHVubGlrZSBwbGF0Zm9ybXMgcHJlY2VkaW5nIHRoZSBBMzMpLgo+
ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBQYXVsIEtvY2lhbGtvd3NraSA8cGF1bC5rb2NpYWxrb3dz
a2lAYm9vdGxpbi5jb20+Cj4gPiAtLS0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2FsbHdpbm5l
ci9zdW41MGktYTY0LmR0c2kgfCAxMSArKysrKysrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2FsbHdpbm5lci9zdW41MGktYTY0LmR0c2kKPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9hbGx3
aW5uZXIvc3VuNTBpLWE2NC5kdHNpIGluZGV4Cj4gPiA4NTU3ZDUyYzdjOTkuLjhkMDI0YzEwZDdj
YiAxMDA2NDQKPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjUwaS1h
NjQuZHRzaQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTBpLWE2
NC5kdHNpCj4gPiBAQCAtMzk3LDYgKzM5NywxNyBAQAo+ID4gIAkJCX07Cj4gPiAgCQl9Owo+ID4g
Cj4gPiArCQl2aWRlby1jb2RlY0AxYzBlMDAwIHsKPiA+ICsJCQljb21wYXRpYmxlID0gImFsbHdp
bm5lcixzdW41MGktaDUtdmlkZW8tZW5naW5lIjsKPiAKPiBZb3UgbWVhbnQgQTY0IGluc3RlYWQg
b2YgSDUsIHJpZ2h0PwoKQWggeWVzIGRlZmluaXRlbHksIHRoYXQncyBhIG1pc3Rha2UgcmlnaHQg
aGVyZS4KCkknbGwgc2VuZCBhIGZvbGxvdy11cCBwYXRjaCBmb3Igc3dpdGNoaW5nIHRoZSBjb21w
YXRpYmxlIHRvIGRlc2NyaWJlCnRoZSBhNjQgaW5zdGVhZCBvZiB0aGUgaDUuIEluIHByYWN0aWNl
LCBoYXZpbmcgdGhlIGE2NCB1c2UgdGhlIGg1CmNvbXBhdGlibGUgZG9lc24ndCBjYXVzZSBhbnkg
aXNzdWUsIGJ1dCBpdCBzaG91bGQgYmUgZml4ZWQKbmV2ZXJ0aGVsZXNzLgoKQ2hlZXJzLAoKUGF1
bAoKPiBCZXN0IHJlZ2FyZHMsCj4gSmVybmVqCj4gCj4gPiArCQkJcmVnID0gPDB4MDFjMGUwMDAg
MHgxMDAwPjsKPiA+ICsJCQljbG9ja3MgPSA8JmNjdSBDTEtfQlVTX1ZFPiwgPCZjY3UgQ0xLX1ZF
PiwKPiA+ICsJCQkJIDwmY2N1IENMS19EUkFNX1ZFPjsKPiA+ICsJCQljbG9jay1uYW1lcyA9ICJh
aGIiLCAibW9kIiwgInJhbSI7Cj4gPiArCQkJcmVzZXRzID0gPCZjY3UgUlNUX0JVU19WRT47Cj4g
PiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDU4IElSUV9UWVBFX0xFVkVMX0hJR0g+Owo+ID4g
KwkJCWFsbHdpbm5lcixzcmFtID0gPCZ2ZV9zcmFtIDE+Owo+ID4gKwkJfTsKPiA+ICsKPiA+ICAJ
CW1tYzA6IG1tY0AxYzBmMDAwIHsKPiA+ICAJCQljb21wYXRpYmxlID0gImFsbHdpbm5lcixzdW41
MGktYTY0LW1tYyI7Cj4gPiAgCQkJcmVnID0gPDB4MDFjMGYwMDAgMHgxMDAwPjsKPiAKPiAKPiAK
LS0gClBhdWwgS29jaWFsa293c2tpLCBCb290bGluIChmb3JtZXJseSBGcmVlIEVsZWN0cm9ucykK
RW1iZWRkZWQgTGludXggYW5kIGtlcm5lbCBlbmdpbmVlcmluZwpodHRwczovL2Jvb3RsaW4uY29t
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
