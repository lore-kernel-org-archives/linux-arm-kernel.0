Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C4EC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:39:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998CA218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ekq84Ufu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998CA218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Wde9SkJ1YzDWVBX9x++TGu+cHCk03NWZY8SXpusI6N0=; b=Ekq84UfuGMrUES
	L6unJoNya62i7LzBIZnk7c8PYY/ALuwJTp+SaO71zv6Z7IkGQmIbFxM1t+rUJR6BIajUDcOiCyIW9
	iByBFsvDPnTBOc+CCu1wHNyTZ8Iy5/hn4kOQ+fbhinIQkYSU1qTJpxbPkdU9oNbxW3iE7MV+Kd22T
	6UHa4Xd9wNVhMTI/nAOw731W4TwsJ2IXdlpONm/W3EPRAd01pjrTQMdlLbXPdrAZoLHKdpMxHOhVz
	wURO/AbiDxb9jqP+A+CULO2YDeC3Ghsz1cE+15b/nVDVf9MLO2LbtU/GUZ4EImgqne81qhdnBc+U+
	+3+dNAslHp+qGNlLIbwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyth-0004MN-50; Fri, 25 Jan 2019 10:39:41 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmytd-0004K1-EI
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:39:39 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 0095D20A2E; Fri, 25 Jan 2019 11:39:35 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8258E20798;
 Fri, 25 Jan 2019 11:39:25 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v4 00/10] A3700 USB S2RAM support
Date: Fri, 25 Jan 2019 11:39:14 +0100
Message-Id: <20190125103925.15753-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_023937_760730_0839552F 
X-CRM114-Status: GOOD (  21.41  )
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
bAoKQ2hhbmdlcyBzaW5jZSB2MzoKPT09PT09PT09PT09PT09PT0KKiBCaW5kaW5nczogYXMgc3Vn
Z2VzdGVkIGJ5IEdyZWdvcnkgYW5kIFJvYiwgdXNlZCB0aGUgIi1taXNjIiBzdWZmaXgKICBpbnN0
ZWFkIG9mICItbWlzY2VsbGFuZW91cyIgYW5kIHByZWZpeGVkIHRoZSBjb21wYXRpYmxlIHdpdGgK
ICAiYXJtYWRhLTM3MDAiIHRvIGZvbGxvdyB3aGF0IGhhcyBiZWVuIHVzZWQgZm9yIHRoZSBvdGhl
ciBJUHMgb2YgdGhlCiAgc2FtZSBTb0MgKGFuZCBhZGRlZCBSb2IncyBhY2spLgoqIE9yaW9uIGRy
aXZlcjogYWRkZWQgQWxhbidzIGFjayBvbiB0aGUgcmVtb3ZhbCBvZiB0aGUgZG91YmxlIFBIWQog
IGluaXRpYWxpemF0aW9uLgoqIE9yaW9uIGRyaXZlcjogcmVtb3ZlZCB0aGUgc3VwZXJmbHVvdXMg
Y2FsbHMgdG8KICBlaGNpX3ByZXBhcmVfcG9ydHNfZm9yX2NvbnRyb2xsZXJfc3VzcGVuZCgpIChy
ZXBvcnRlZCBieSBBbGFuKS4KCkNoYW5nZXMgc2luY2UgdjI6Cj09PT09PT09PT09PT09PT09Ciog
VHlwb3MKKiBVVE1JIFBIWSBiaW5kaW5nczoKICA+IE5ldyBuYW1lIGZvciB0aGUgVVNCMiBob3N0
L1BIWSBzeXNjb25zICgrIGNoYW5nZXMgaW4gdGhlIERUKS4KICA+IENsZWFybHkgc3RhdGUgdGhh
dCB0aGUgUEhZcyBhcmUgZGlmZmVyZW50IGJldHdlZW4gT1RHIGFuZAogICAgaG9zdC1vbmx5IGNv
bnRyb2xsZXJzLgoqIFVUTUkgUEhZIGRyaXZlcjoKICA+IFVzZSBHRU5NQVNLIG1hY3JvLgogID4g
UmVtb3ZlZCB1c2VsZXNzIGNoZWNrcyBvbiBkcml2ZXIgZGF0YSByZXRyaWV2YWwuCiAgPiBEcm9w
cGVkIHRoZSBlbXB0eSAtPnJlbW92ZSgpIGhvb2suCiAgPiBVcGRhdGVkIHRoZSBsaWNlbmNlIG1h
Y3JvIHRvIG1hdGNoIHRoZSBTUERYIHRhZy4KICA+IFVzZWQgdGhlIG9mX2RldmljZV9nZXRfbWF0
Y2hfZGF0YSgpIGhlbHBlci4KICA+IFJlbW92ZWQgdGhlIHVzZSBvZiBhIGxvY2FsIHZhcmlhYmxl
IGluIHRoZSAtPnByb2JlKCkgZm9yIHRoZQogICAgZHJpdmVyJ3Mgb3BlcmF0aW9ucy4KICA+IEZp
eGVkIHRoZSBkcml2ZXIgY28tYXV0aG9yOiBJZ2FsLCBub3QgRXZhbi4KKiB4SENJIG12ZWJ1IGRy
aXZlcjoKICA+IFVzZWQgQXJtYWRhIDM4eCBuYW1pbmcgY29udmVudGlvbjoKICAgIHMvQXJtYWRh
IDM3MDAgU29DL0FybWFkYSAzN3h4IFNvQy8KICA+IEFkZGVkIEdyZWdvcnkncyBSZXZpZXdlZC1i
eSB0YWcuCgpDaGFuZ2VzIHNpbmNlIHYxOgo9PT09PT09PT09PT09PT09PQoqIEFkZCBVVE1JIFBI
WSBkcml2ZXIvYmluZGluZ3MvRFQgY2hhbmdlcyB0byBicmluZyBTMlJBTSBzdXBwb3J0IHRvCiAg
Ym90aCBVU0IgcG9ydHMgYXZhaWxhYmxlIG9uIHRoZSBBMzcwMCBTb0MuCiogVXBkYXRlcyB0byB0
aGUgT0hDSSBPcmlvbiBkcml2ZXIgdG8gYXZvaWQgZG9pbmcgdGhlIFBIWQogIGluaXRpYWxpemF0
aW9uIHR3aWNlLgoqIFVwZ3JhZGUgb2YgdGhlIE9IQ0kgT3Jpb24gZHJpdmVyIHdpdGggUzJSQU0g
Y2FsbGJhY2tzLgoqIEFkZGVkIGEgcmVmZXJlbmNlIHRvIHRoZSBBMzcwMCBTb0MgaW4gdGhlIFVT
QiBIb3N0IEtjb25maWcgcHJvbXB0CiAgKG5vdCBvbmx5IGluIHRoZSBoZWxwIHNlY3Rpb24pLgoq
IFJlYmFzZWQgb24gdG9wIG9mIHY1LjAtcmMxLgoKCk1pcXVlbCBSYXluYWwgKDkpOgogIHVzYjog
Y29yZTogY29tcGx5IHRvIFBIWSBmcmFtZXdvcmsKICB1c2I6IGVoY2ktb3Jpb246IGF2b2lkIGRv
dWJsZSBQSFkgaW5pdGlhbGl6YXRpb24KICB1c2I6IGVoY2ktb3Jpb246IGFkZCBTMlJBTSBzdXBw
b3J0CiAgcGh5OiBhZGQgQTM3MDAgVVRNSSBQSFkgZHJpdmVyCiAgZHQtYmluZGluZ3M6IHBoeTog
bXZlYnUtdXRtaTogYWRkIFVUTUkgUEhZIGJpbmRpbmdzCiAgTUFJTlRBSU5FUlM6IHBoeTogZmls
bCBBcm1hZGEgMzcwMCBQSFkgZHJpdmVycyBlbnRyeQogIEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFy
bWFkYS0zN3h4OiBmaXggVVNCMiBtZW1vcnkgcmVnaW9uCiAgQVJNNjQ6IGR0czogbWFydmVsbDog
YXJtYWRhLTM3eHg6IGRlY2xhcmUgVVNCMiBVVE1JIFBIWXMKICBBUk02NDogZHRzOiBtYXJ2ZWxs
OiBhcm1hZGEtMzd4eDogbGluayBVU0IgaG9zdHMgd2l0aCB0aGVpciBQSFlzCgpPZmVyIEhlaWZl
dHogKDEpOgogIHVzYjogaG9zdDogeGhjaTogbXZlYnU6IGFkZCByZXNldCBvbiByZXN1bWUgcXVp
cmsKCiAuLi4vYmluZGluZ3MvcGh5L3BoeS1tdmVidS11dG1pLnR4dCAgICAgICAgICAgfCAgMzgg
KysrCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQg
Ky0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzd4eC5kdHNpICB8ICAzNCAr
Ky0KIGRyaXZlcnMvcGh5L21hcnZlbGwvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAgOSAr
CiBkcml2ZXJzL3BoeS9tYXJ2ZWxsL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgIDEgKwog
ZHJpdmVycy9waHkvbWFydmVsbC9waHktbXZlYnUtYTM3MDAtdXRtaS5jICAgIHwgMjc4ICsrKysr
KysrKysrKysrKysrKwogZHJpdmVycy91c2IvY29yZS9oY2QuYyAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICA1ICsKIGRyaXZlcnMvdXNiL2NvcmUvcGh5LmMgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAyOCArKwogZHJpdmVycy91c2IvY29yZS9waHkuaCAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAyICsKIGRyaXZlcnMvdXNiL2hvc3QvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8
ICAgNCArLQogZHJpdmVycy91c2IvaG9zdC9laGNpLW9yaW9uLmMgICAgICAgICAgICAgICAgIHwg
IDQ0ICsrLQogZHJpdmVycy91c2IvaG9zdC94aGNpLW12ZWJ1LmMgICAgICAgICAgICAgICAgIHwg
IDExICsKIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdmVidS5oICAgICAgICAgICAgICAgICB8ICAg
NiArCiBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGxhdC5jICAgICAgICAgICAgICAgICAgfCAgIDcg
KwogMTQgZmlsZXMgY2hhbmdlZCwgNDQ0IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkv
cGh5LW12ZWJ1LXV0bWkudHh0CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waHkvbWFydmVs
bC9waHktbXZlYnUtYTM3MDAtdXRtaS5jCgotLSAKMi4xOS4xCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
