Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA78C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:18:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB70020878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ui8VAkmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB70020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xqgJlPv88y1kH+8lusOnDKOev93/REn2dTjtA8gr64k=; b=Ui8VAkmDUODKQW
	6ex4zH0k31/wi0XNJqXhG3qLqTbcIgY+fl9gteGtiTfXPe0JvEMZHfDbGZwXPr+ic0Y3ZmaZu4So+
	YFyqk29USZ2nDe/4r1nHy0qnXmLdsEuUYZnaYeBEhDzaB4PZbMYnOWwbBl0G9irzkg5fhA44ElLlI
	UDc+w5jLtfvoSgaOaRw1cSxfVihehsXKDg6nMMj8cYIE3Rl2vJhRTj738fFCKdNb1nh8dwSJmfCGO
	NiqF5jMcH5EDelKsCVUpz/TIjxeyYzRiR3qvMwkgHt5kVUuWdIyl2T6bN3deS0zmcH645dh0UCk8I
	mRDxl7yb35u+fTP3XxSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGCr-0000uf-Pz; Tue, 04 Dec 2018 19:18:05 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGCf-0000lJ-Pu
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:17:55 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8AB0620A5A; Tue,  4 Dec 2018 20:17:42 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8E59E20717;
 Tue,  4 Dec 2018 20:17:31 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 0/8] Add Armada 3700 COMPHY support
Date: Tue,  4 Dec 2018 20:17:22 +0100
Message-Id: <20181204191730.11516-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_111754_015477_5317C0EF 
X-CRM114-Status: GOOD (  17.79  )
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
ZXMgc2luY2UgdjI6Cj09PT09PT09PT09PT09PT09CiogUmVtb3ZlIHJlZHVuZGFudCBjaGVjayBv
biBsYW5lLT5wb3J0L2FyZ3MtPmFyZ1swXSBhdCB0aGUgZW5kIG9mIHRoZQogIC0+eGxhdGUoKSBj
YWxsYmFjay4gRG8gaXQgb24gYm90aCBhcm1hZGEtY3AxMTAgYW5kIGFybWFkYS1hMzcwMAogIENP
TVBIWSBkcml2ZXJzLgoqIFB1dCBteSBTb0IgYXMgYXV0aG9yIG9mIHRoZSBwYXRjaCBmaXJzdCB3
aGVuIGEgcGF0Y2ggaXMgY28tZGV2ZWxvcGVkLgoKQ2hhbmdlcyBzaW5jZSB2MToKPT09PT09PT09
PT09PT09PT0KKiBGaXggd3JvbmcgY2hlY2sgaW4gLT54bGF0ZSgpLgoqIEFwcGx5IHRoZSBzYW1l
IGZpeCB0byB0aGUgY3AxMTAgY29tcGh5IGRyaXZlciBmcm9tIHdoaWNoIHRoZSBhMzcwMAogIGRy
aXZlciBpcyBiYXNlZC4KKiBBZGRlZCBjcmVkaXQgdG8gR3JlZ29yeiBKYXN6Y3p5ayBmb3IgaGlz
IHdvcmsuCiogQWRkZWQgU3VnZ2VzdGVkLWJ5IHRhZyB0byB0aGUgcGF0Y2ggYWRkaW5nIHRoZSBD
T01QSFkgRFQgbm9kZS4KCgpHcnplZ29yeiBKYXN6Y3p5ayAoMSk6CiAgcGh5OiBlbnVtZXJhdGUg
U0FUQSBQSFkgbW9kZQoKTWlxdWVsIFJheW5hbCAoNyk6CiAgcGh5OiBtdmVidS1jcDExMC1jb21w
aHk6IGZpeCBzcGVsbGluZyBpbiBzdHJ1Y3R1cmUgbmFtZQogIHBoeTogbXZlYnUtY3AxMTAtY29t
cGh5OiBmaXggcG9ydCBjaGVjayBpbiAtPnhsYXRlKCkKICBwaHk6IGFkZCBBMzcwMCBDT01QSFkg
c3VwcG9ydAogIGR0LWJpbmRpbmdzOiBwaHk6IG12ZWJ1LWNvbXBoeTogZXh0ZW5kIHRoZSBmaWxl
IHRvIGRlc2NyaWJlIGEzNzAwCiAgICBiaW5kaW5ncwogIE1BSU5UQUlORVJTOiBwaHk6IGFkZCBl
bnRyeSBmb3IgQXJtYWRhIDM3MDAgQ09NUEhZIGRyaXZlcgogIEFSTTY0OiBkdHM6IG1hcnZlbGw6
IGFybWFkYS0zN3h4OiBmaXggU0FUQSBub2RlIHNjb3BlCiAgQVJNNjQ6IGR0czogbWFydmVsbDog
YXJtYWRhLTM3eHg6IGRlY2xhcmUgdGhlIENPTVBIWSBub2RlCgogLi4uL2JpbmRpbmdzL3BoeS9w
aHktbXZlYnUtY29tcGh5LnR4dCAgICAgICAgIHwgIDY1ICsrKystCiBNQUlOVEFJTkVSUyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKwogYXJjaC9hcm02NC9ib290L2R0
cy9tYXJ2ZWxsL2FybWFkYS0zN3h4LmR0c2kgIHwgIDMxICstCiBkcml2ZXJzL3BoeS9tYXJ2ZWxs
L0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgMTAgKwogZHJpdmVycy9waHkvbWFydmVsbC9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgICAxICsKIGRyaXZlcnMvcGh5L21hcnZlbGwvcGh5
LW12ZWJ1LWEzNzAwLWNvbXBoeS5jICB8IDI3NCArKysrKysrKysrKysrKysrKysKIGRyaXZlcnMv
cGh5L21hcnZlbGwvcGh5LW12ZWJ1LWNwMTEwLWNvbXBoeS5jICB8ICAgNiArLQogaW5jbHVkZS9s
aW51eC9waHkvcGh5LmggICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKIDggZmlsZXMgY2hh
bmdlZCwgMzc3IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvcGh5L21hcnZlbGwvcGh5LW12ZWJ1LWEzNzAwLWNvbXBoeS5jCgotLSAKMi4x
OS4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
