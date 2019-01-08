Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E80C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:32:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CDC20827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nfa6aqNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CDC20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9g3JYaiA9eNMEH8MrEdQ7tjhQ/8d3mc9n9hehCBSBic=; b=nfa6aqNvz+TN7H
	FaApEZBUia+g+2wUZZi8lO2TK4Cygi+ryUFMYUBp2isiDjl1Wb+742UD7iel2FvXZ7yj8fTIex9mh
	czamhb8TPndC+vlravg+NJMW7DsHQIKMesvU9n28DwA0p2R3sdyTQ7pCquYX7VIUdLwStpXMSs5Wu
	DJpxv2GqJfDszaGuSeUmi1IhHDLG60qm0y9wcJS7nPGmk3OQMDUaHGji+ZQxBWZzXoRFv7YImTgdT
	KaoHW96ofvHkkntfpzabDDcBtXttoEhqWO7OtxlKPgLO02kt/ari99xz3XrjspiP2u1DUK9d4fgqr
	qc0dvIXXVbyzP/BpHRhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gguIU-0007zu-6l; Tue, 08 Jan 2019 16:32:10 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gguHy-0007WX-LH
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:31:41 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 52EEE20A1D; Tue,  8 Jan 2019 17:31:36 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id E7C2420763;
 Tue,  8 Jan 2019 17:31:25 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 0/7] Add Armada 3700 COMPHY support
Date: Tue,  8 Jan 2019 17:31:17 +0100
Message-Id: <20190108163124.6409-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_083139_188934_62AA0E7F 
X-CRM114-Status: GOOD (  19.40  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpUaGlzIHNlcmllcyBhZGRzIGEgbmV3IGRyaXZlciB0byBzdXBwb3J0IEFybWFkYSAz
NzAwIENPTVBIWSBJUC4KVGhlIHNlcmllcyBoYXMgYmVlbiB0ZXN0ZWQgb24gYW4gRVNQUkVTU09i
aW4gd2l0aCBTQVRBLCBQQ0llCmFuZCBVU0IzIGhvc3QuIEZvciB0aGlzIHB1cnBvc2UsIHBhdGNo
IDEgZW51bWVyYXRlcyB0aGUgU0FUQSBQSFkKbW9kZS4gVGhlIFNHTUlJIFBIWSBtb2RlIHRoYXQg
aXMgc3VwcG9ydGVkIGJ5IHRoZSBJUCBoYXMgYmVlbiB3cml0dGVuCih1c2VzIFNNQyBjYWxscyBh
bnl3YXkpIGJ1dCBjb3VsZCBub3QgYmUgdGVzdGVkIG9uIHRoaXMgcGxhdGZvcm0uCgpUaHJlZSBz
ZXJpZXMgd2lsbCBmb2xsb3cgdG8gYWRkIFBIWSBzdXBwb3J0IChvciBhdCBsZWFzdCBhIFBIWSBu
b2RlcwppbiB0aGUgQTM3MDAvRVNQUkVTU09iaW4gZGV2aWNlIHRyZWVzKSB0byB0aGUgTVZFQlUg
QUhDSSBkcml2ZXIsIHRoZQpBYXJkdmFyayBQQ0kgY29udHJvbGxlciBkcml2ZXIgYW5kIHRoZSBN
VkVCVSB4SENJIGRyaXZlci4gQWxsIHRoaXMgaXMKbmVlZGVkIGluIG9yZGVyIHRvIGFjaGlldmUg
c3VzcGVuZCB0byBSQU0gb24gdGhpcyBwbGF0Zm9ybS4KClRoYW5rcywKTWlxdcOobAoKCkNoYW5n
ZXMgc2luY2UgdjQ6Cj09PT09PT09PT09PT09PT09CiogRml4ZWQgZXJyb3IgaW4gdGhlIGRyaXZl
ciBwcm9iZSB3aGVyZSBQSFlfSU5URVJGQUNFX01PREVfTkEgd2FzCiAgYXNzaWduZWQgdG8gbGFu
ZS0+bW9kZSBpbnN0ZWFkIG9mIGxhbmUtPnN1Ym1vZGUuCiogQ29tcGlsZS1pbiB0aGUgZHJpdmVy
IGJ5IGRlZmF1bHQgKGRlcGVuZHMgb24gQVJDSF9NVkVCVSkuCiogQWRkIGRlcGVuZGVuY3kgb24g
SEFWRV9BUk1fU01DQyBpbiBLY29uZmlnLgoKQ2hhbmdlcyBzaW5jZSB2MzoKPT09PT09PT09PT09
PT09PT0KKiBBZGRlZCBSb2IncyBSZXZpZXdlZC1ieSB0YWcgb24gYmluZGluZ3MuCiogUmViYXNl
ZCBvbiB0b3Agb2YgcGh5IC1uZXh0IGFzIG9mIHRoZSAxMnRoIG9mIERlY2VtYmVyLCAyMDE4Lgoq
IEFkYXB0ZWQgdGhlIGRyaXZlciB0byBzdXBwb3J0IFNHTUlJLzEwMDBCQVNFWCBhbmQKICBIU19T
R01JSS8yNTAwQkFTRVguCgpDaGFuZ2VzIHNpbmNlIHYyOgo9PT09PT09PT09PT09PT09PQoqIFJl
bW92ZSByZWR1bmRhbnQgY2hlY2sgb24gbGFuZS0+cG9ydC9hcmdzLT5hcmdbMF0gYXQgdGhlIGVu
ZCBvZiB0aGUKICAtPnhsYXRlKCkgY2FsbGJhY2suIERvIGl0IG9uIGJvdGggYXJtYWRhLWNwMTEw
IGFuZCBhcm1hZGEtYTM3MDAKICBDT01QSFkgZHJpdmVycy4KKiBQdXQgbXkgU29CIGFzIGF1dGhv
ciBvZiB0aGUgcGF0Y2ggZmlyc3Qgd2hlbiBhIHBhdGNoIGlzIGNvLWRldmVsb3BlZC4KCkNoYW5n
ZXMgc2luY2UgdjE6Cj09PT09PT09PT09PT09PT09CiogRml4IHdyb25nIGNoZWNrIGluIC0+eGxh
dGUoKS4KKiBBcHBseSB0aGUgc2FtZSBmaXggdG8gdGhlIGNwMTEwIGNvbXBoeSBkcml2ZXIgZnJv
bSB3aGljaCB0aGUgYTM3MDAKICBkcml2ZXIgaXMgYmFzZWQuCiogQWRkZWQgY3JlZGl0IHRvIEdy
ZWdvcnogSmFzemN6eWsgZm9yIGhpcyB3b3JrLgoqIEFkZGVkIFN1Z2dlc3RlZC1ieSB0YWcgdG8g
dGhlIHBhdGNoIGFkZGluZyB0aGUgQ09NUEhZIERUIG5vZGUuCgoKR3J6ZWdvcnogSmFzemN6eWsg
KDEpOgogIHBoeTogZW51bWVyYXRlIFNBVEEgUEhZIG1vZGUKCk1pcXVlbCBSYXluYWwgKDYpOgog
IHBoeTogbXZlYnUtY3AxMTAtY29tcGh5OiBmaXggcG9ydCBjaGVjayBpbiAtPnhsYXRlKCkKICBw
aHk6IGFkZCBBMzcwMCBDT01QSFkgc3VwcG9ydAogIGR0LWJpbmRpbmdzOiBwaHk6IG12ZWJ1LWNv
bXBoeTogZXh0ZW5kIHRoZSBmaWxlIHRvIGRlc2NyaWJlIGEzNzAwCiAgICBiaW5kaW5ncwogIE1B
SU5UQUlORVJTOiBwaHk6IGFkZCBlbnRyeSBmb3IgQXJtYWRhIDM3MDAgQ09NUEhZIGRyaXZlcgog
IEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zN3h4OiBmaXggU0FUQSBub2RlIHNjb3BlCiAg
QVJNNjQ6IGR0czogbWFydmVsbDogYXJtYWRhLTM3eHg6IGRlY2xhcmUgdGhlIENPTVBIWSBub2Rl
CgogLi4uL2JpbmRpbmdzL3BoeS9waHktbXZlYnUtY29tcGh5LnR4dCAgICAgICAgIHwgIDY1ICsr
Ky0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNiAr
CiBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3eHguZHRzaSAgfCAgMzEgKy0K
IGRyaXZlcnMvcGh5L21hcnZlbGwvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAxMiArCiBk
cml2ZXJzL3BoeS9tYXJ2ZWxsL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgIDEgKwogZHJp
dmVycy9waHkvbWFydmVsbC9waHktbXZlYnUtYTM3MDAtY29tcGh5LmMgIHwgMzE4ICsrKysrKysr
KysrKysrKysrKwogZHJpdmVycy9waHkvbWFydmVsbC9waHktbXZlYnUtY3AxMTAtY29tcGh5LmMg
IHwgICAyIC0KIGluY2x1ZGUvbGludXgvcGh5L3BoeS5oICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMSArCiA4IGZpbGVzIGNoYW5nZWQsIDQyMSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMo
LSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1hMzcw
MC1jb21waHkuYwoKLS0gCjIuMTkuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
