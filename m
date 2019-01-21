Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F0CC7112F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:24:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378E920663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mpgnoWsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378E920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uuagPJms3vleGtex/d0t1+NJS2h+8couW/k/+nCBt8o=; b=mpgnoWsMQpCwYE
	h+YpaNhUt6w5cuRcK+WvaioP0PsJ7pPxmjqrcuGBaU9ASwLDmqXPSLKawhSMQMDaanJ27QHNBmAUI
	Mq6x4mwXkRRM/7QtBhMB9r37hce9nylFVhKgK5Xh7ZlITReftb9hON4vRo/SoxQd/iPd9P5GDG4H/
	RX1nKgKDV2voH7QWpAXxPU3s07aGEhx8UXSVYry8cn2nUh8oSaUqsgQFlPpzsMROD8GoALQwZ6Hbm
	NI0yrnOmw5YDdftGosxGhhKrevrxED2E8CzVlsSL2RA5y57G5m8Tqk7xE8SvTLgo3qB5/97/yrw2p
	+1oPSj7Q8KCMUxSZHEaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXgN-0001Yq-BX; Mon, 21 Jan 2019 11:23:59 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXg3-0001G9-8s
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 11:23:41 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id C1C8720898; Mon, 21 Jan 2019 12:23:37 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 527E6206A7;
 Mon, 21 Jan 2019 12:23:37 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v3 00/10] A3700 USB S2RAM support
Date: Mon, 21 Jan 2019 12:23:26 +0100
Message-Id: <20190121112336.23489-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_032339_578598_62B136DF 
X-CRM114-Status: GOOD (  21.12  )
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
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 linux-usb@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpBcyBwYXJ0IG9mIGFuIGVmZm9ydCB0byBicmluZyBzdXNwZW5kIHRvIFJBTSBzdXBw
b3J0IHRvIEFybWFkYSAzNzAwClNvQ3MgKG1haW4gdGFyZ2V0OiBFU1BSRVNTT2JpbiksIHRoaXMg
c2VyaWVzIGhhbmRsZXMgdGhlIHdvcmsgYXJvdW5kCnRoZSBVU0IyIGFuZCBVU0IzMiBJUHMuCgpG
aXJzdCwgYSBjaGFuZ2UgaW4gdGhlIGNvcmUgYWRkcyBzdXBwb3J0IGZvciB0aGUgbmV3IFBIWSBm
cmFtZXdvcmsgYnkKZm9sbG93aW5nIHRoZSBwaHlfc2V0X21vZGUoKS9waHlfcG93ZXJfb24oKSBz
ZXF1ZW5jZSAocGF0Y2ggMSkuIFRoZQpzZWNvbmQgY2hhbmdlIG5lZWRlZCBpcyB0byB1cGRhdGUg
dGhlIHhIQ0kgTVZFQlUgZHJpdmVyIChwYXRjaCAyKSB3aXRoCnRoZSBYSENJX1JFU0VUX09OX1JF
U1VNRSBxdWlyayB0aGF0IHdpbGwgZG8gbW9zdCBvZiB0aGUKcmVjb25maWd1cmF0aW9uIHdvcmsg
d2hlbiByZXN1bWluZy4KClRoZW4sIGJlY2F1c2Ugb2YgdGhlIGFzeW5jaHJvbm91cyBzdXNwZW5k
IGZlYXR1cmUgaW1wbGVtZW50ZWQgbGF0ZWx5LAp0aGUgeEhDSSBkcml2ZXIgd2FzIGJsb2NraW5n
IGR1cmluZyB0aGUgUzJSQU0gb3BlcmF0aW9uLCBwcm9iYWJseSBkdWUKdG8gYSByZWdpc3RlciBh
Y2Nlc3Mgd2hpbGUgdGhlIGNsb2NrIHdhcyBub3QgZW5hYmxlZC4gQSBmaXJzdCBwYXRjaApoYXMg
YmVlbiB3cml0dGVuIGZvciB0aGF0LCBhZGRpbmcgYSBuZXcgcXVpcmsgdG8gaWdub3JlIHRoZQph
c3luY2hyb25vdXMgc2V0dGluZyBbMV0gd2hpY2ggaGFzIGJlY29tZSB1c2VsZXNzIG9uY2UgY2xv
Y2sgbGlua3MKd2l0aCBjb25zdW1lciBoYXZlIGJlZW4gY29udHJpYnV0ZWQgWzJdIChzZXJpZXMg
bm90IG1lcmdlZCB5ZXQpLgoKVGhlbiwgdGhlIE9IQ0kgT3Jpb24gKFVTQjIgaG9zdCBjb250cm9s
bGVyKSBkcml2ZXIgaXMgdXBkYXRlZCB0byBhdm9pZApkb2luZyB0d2ljZSB0aGUgUEhZIG1hbmFn
ZW1lbnQgKHBhdGNoIDMpIGFuZCB1cGdyYWRlZCB3aXRoIHRyYWRpdGlvbmFsClMyUkFNIGNhbGxi
YWNrcyAocGF0Y2ggNCkuCgpUaGUgbGFzdCBtaXNzaW5nIHBlYWNlIGlzIGEgVVRNSSBQSFkgZHJp
dmVyIGZvciB0aGUgVVNCMiBwYXJ0IG9mIGVhY2gKY29udHJvbGxlciwgd2hpY2ggaXMgYWRkZWQg
aW4gcGF0Y2ggNSAoc2VlIHBhdGNoIDYgZm9yIHRoZSBiaW5kaW5ncykuCgpGaW5hbGx5LCB0aGUg
QTM3MDAgZGV2aWNlIHRyZWUgaXMgdXBkYXRlZCAocGF0Y2ggNywgOCwgOSkgdG8gcmVmZXJlbmNl
CnRoZSBQSFlzLiB4SENJIGJpbmRpbmdzIGFscmVhZHkgZG9jdW1lbnQgdGhlIFBIWSBzbyBubyB1
cGRhdGUgaXMgbmVlZGVkCm9uIHRoaXMgcmVnYXJkLgoKWzFdIGh0dHA6Ly9jb2RlLmJ1bGl4Lm9y
Zy9zMmNjZDQtNTExMTk4ClsyXSBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwv
bGludXgtYXJtLWtlcm5lbC8yMDE5LUphbnVhcnkvNjIzODg1Lmh0bWwKClRoYW5rcywKTWlxdcOo
bAoKQ2hhbmdlcyBzaW5jZSB2MjoKPT09PT09PT09PT09PT09PT0KKiBUeXBvcwoqIFVUTUkgUEhZ
IGJpbmRpbmdzOgogID4gTmV3IG5hbWUgZm9yIHRoZSBVU0IyIGhvc3QvUEhZIHN5c2NvbnMgKCsg
Y2hhbmdlcyBpbiB0aGUgRFQpLgogID4gQ2xlYXJseSBzdGF0ZSB0aGF0IHRoZSBQSFlzIGFyZSBk
aWZmZXJlbnQgYmV0d2VlbiBPVEcgYW5kCiAgICBob3N0LW9ubHkgY29udHJvbGxlcnMuCiogVVRN
SSBQSFkgZHJpdmVyOgogID4gVXNlIEdFTk1BU0sgbWFjcm8uCiAgPiBSZW1vdmVkIHVzZWxlc3Mg
Y2hlY2tzIG9uIGRyaXZlciBkYXRhIHJldHJpZXZhbC4KICA+IERyb3BwZWQgdGhlIGVtcHR5IC0+
cmVtb3ZlKCkgaG9vay4KICA+IFVwZGF0ZWQgdGhlIGxpY2VuY2UgbWFjcm8gdG8gbWF0Y2ggdGhl
IFNQRFggdGFnLgogID4gVXNlZCB0aGUgb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgaGVscGVy
LgogID4gUmVtb3ZlZCB0aGUgdXNlIG9mIGEgbG9jYWwgdmFyaWFibGUgaW4gdGhlIC0+cHJvYmUo
KSBmb3IgdGhlCiAgICBkcml2ZXIncyBvcGVyYXRpb25zLgogID4gRml4ZWQgdGhlIGRyaXZlciBj
by1hdXRob3I6IElnYWwsIG5vdCBFdmFuLgoqIHhIQ0kgbXZlYnUgZHJpdmVyOgogID4gVXNlZCBB
cm1hZGEgMzh4IG5hbWluZyBjb252ZW50aW9uOgogICAgcy9Bcm1hZGEgMzcwMCBTb0MvQXJtYWRh
IDM3eHggU29DLwogID4gQWRkZWQgR3JlZ29yeSdzIFJldmlld2VkLWJ5IHRhZy4KCkNoYW5nZXMg
c2luY2UgdjE6Cj09PT09PT09PT09PT09PT09CiogQWRkIFVUTUkgUEhZIGRyaXZlci9iaW5kaW5n
cy9EVCBjaGFuZ2VzIHRvIGJyaW5nIFMyUkFNIHN1cHBvcnQgdG8KICBib3RoIFVTQiBwb3J0cyBh
dmFpbGFibGUgb24gdGhlIEEzNzAwIFNvQy4KKiBVcGRhdGVzIHRvIHRoZSBPSENJIE9yaW9uIGRy
aXZlciB0byBhdm9pZCBkb2luZyB0aGUgUEhZCiAgaW5pdGlhbGl6YXRpb24gdHdpY2UuCiogVXBn
cmFkZSBvZiB0aGUgT0hDSSBPcmlvbiBkcml2ZXIgd2l0aCBTMlJBTSBjYWxsYmFja3MuCiogQWRk
ZWQgYSByZWZlcmVuY2UgdG8gdGhlIEEzNzAwIFNvQyBpbiB0aGUgVVNCIEhvc3QgS2NvbmZpZyBw
cm9tcHQKICAobm90IG9ubHkgaW4gdGhlIGhlbHAgc2VjdGlvbikuCiogUmViYXNlZCBvbiB0b3Ag
b2YgdjUuMC1yYzEuCgoKTWlxdWVsIFJheW5hbCAoOSk6CiAgdXNiOiBjb3JlOiBjb21wbHkgdG8g
UEhZIGZyYW1ld29yawogIHVzYjogZWhjaS1vcmlvbjogYXZvaWQgZG91YmxlIFBIWSBpbml0aWFs
aXphdGlvbgogIHVzYjogZWhjaS1vcmlvbjogYWRkIFMyUkFNIHN1cHBvcnQKICBwaHk6IGFkZCBB
MzcwMCBVVE1JIFBIWSBkcml2ZXIKICBkdC1iaW5kaW5nczogcGh5OiBtdmVidS11dG1pOiBhZGQg
VVRNSSBQSFkgYmluZGluZ3MKICBNQUlOVEFJTkVSUzogcGh5OiBmaWxsIEFybWFkYSAzNzAwIFBI
WSBkcml2ZXJzIGVudHJ5CiAgQVJNNjQ6IGR0czogbWFydmVsbDogYXJtYWRhLTM3eHg6IGZpeCBV
U0IyIG1lbW9yeSByZWdpb24KICBBUk02NDogZHRzOiBtYXJ2ZWxsOiBhcm1hZGEtMzd4eDogZGVj
bGFyZSBVU0IyIFVUTUkgUEhZcwogIEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zN3h4OiBs
aW5rIFVTQiBob3N0cyB3aXRoIHRoZWlyIFBIWXMKCk9mZXIgSGVpZmV0eiAoMSk6CiAgdXNiOiBo
b3N0OiB4aGNpOiBtdmVidTogYWRkIHJlc2V0IG9uIHJlc3VtZSBxdWlyawoKIC4uLi9iaW5kaW5n
cy9waHkvcGh5LW12ZWJ1LXV0bWkudHh0ICAgICAgICAgICB8ICAzOCArKysKIE1BSU5UQUlORVJT
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQogYXJjaC9hcm02NC9i
b290L2R0cy9tYXJ2ZWxsL2FybWFkYS0zN3h4LmR0c2kgIHwgIDM0ICsrLQogZHJpdmVycy9waHkv
bWFydmVsbC9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgICA5ICsKIGRyaXZlcnMvcGh5L21h
cnZlbGwvTWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAgMSArCiBkcml2ZXJzL3BoeS9tYXJ2
ZWxsL3BoeS1tdmVidS1hMzcwMC11dG1pLmMgICAgfCAyNzggKysrKysrKysrKysrKysrKysrCiBk
cml2ZXJzL3VzYi9jb3JlL2hjZC5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKwogZHJp
dmVycy91c2IvY29yZS9waHkuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDI4ICsrCiBkcml2
ZXJzL3VzYi9jb3JlL3BoeS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKwogZHJpdmVy
cy91c2IvaG9zdC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICstCiBkcml2ZXJz
L3VzYi9ob3N0L2VoY2ktb3Jpb24uYyAgICAgICAgICAgICAgICAgfCAgNTEgKystLQogZHJpdmVy
cy91c2IvaG9zdC94aGNpLW12ZWJ1LmMgICAgICAgICAgICAgICAgIHwgIDExICsKIGRyaXZlcnMv
dXNiL2hvc3QveGhjaS1tdmVidS5oICAgICAgICAgICAgICAgICB8ICAgNiArCiBkcml2ZXJzL3Vz
Yi9ob3N0L3hoY2ktcGxhdC5jICAgICAgICAgICAgICAgICAgfCAgIDcgKwogMTQgZmlsZXMgY2hh
bmdlZCwgNDUxIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW12ZWJ1LXV0bWku
dHh0CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkvbWFydmVsbC9waHktbXZlYnUtYTM3
MDAtdXRtaS5jCgotLSAKMi4xOS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
