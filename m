Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92E5C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:40:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAFC20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LneOEt8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAFC20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IHA40jFz+VC8lWjVngkTdDuicGFqDYdQiDADcVVNyCA=; b=LneOEt8GYnDjxl
	MYj4BQuX2pN21dahUfX+vGaH8mA+rRsBCTpZUWZoT7AOsBHxcfCkcbL77YKgW+rQwFPxvvnmWNnQs
	d4laOESwZMbkL3l5XlZptlpUa4cA49b5YfN/MdyIK2JUuXMU8b6NTKO0f3ITczy+54gOaacB5ok7l
	+AXI/FFYTFXq6RsZ8QiPKJsEHcN9bCwbyVhmgpZXMk5kIN4sHZGQTiU/5qgdZ9KkWDhXLGZ/GJit6
	RiqdqGhijRp5ibxl+qYrcpw6l9icE1ZOnztEeFcIdtIZH0A+LdZJj75/A4Z+nye0+P0Oyzav51H7n
	JCBhB3UOpnxGvIkKvkoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXMXK-000398-Ky; Thu, 13 Dec 2018 08:40:02 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXMWi-0002XW-Ca
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 08:39:28 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 062782079D; Thu, 13 Dec 2018 09:39:11 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
 by mail.bootlin.com (Postfix) with ESMTPSA id 18771206FF;
 Thu, 13 Dec 2018 09:39:10 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 0/7] Add Armada 3700 COMPHY support
Date: Thu, 13 Dec 2018 09:39:01 +0100
Message-Id: <20181213083908.14180-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_003924_631839_E4EE2D78 
X-CRM114-Status: GOOD (  18.51  )
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
ZXMgc2luY2UgdjM6Cj09PT09PT09PT09PT09PT09CiogQWRkZWQgUm9iJ3MgUmV2aWV3ZWQtYnkg
dGFnIG9uIGJpbmRpbmdzLgoqIFJlYmFzZWQgb24gdG9wIG9mIHBoeSAtbmV4dCBhcyBvZiB0aGUg
MTJ0aCBvZiBEZWNlbWJlciwgMjAxOC4KKiBBZGFwdGVkIHRoZSBkcml2ZXIgdG8gc3VwcG9ydCBT
R01JSS8xMDAwQkFTRVggYW5kCiAgSFNfU0dNSUkvMjUwMEJBU0VYLgoKQ2hhbmdlcyBzaW5jZSB2
MjoKPT09PT09PT09PT09PT09PT0KKiBSZW1vdmUgcmVkdW5kYW50IGNoZWNrIG9uIGxhbmUtPnBv
cnQvYXJncy0+YXJnWzBdIGF0IHRoZSBlbmQgb2YgdGhlCiAgLT54bGF0ZSgpIGNhbGxiYWNrLiBE
byBpdCBvbiBib3RoIGFybWFkYS1jcDExMCBhbmQgYXJtYWRhLWEzNzAwCiAgQ09NUEhZIGRyaXZl
cnMuCiogUHV0IG15IFNvQiBhcyBhdXRob3Igb2YgdGhlIHBhdGNoIGZpcnN0IHdoZW4gYSBwYXRj
aCBpcyBjby1kZXZlbG9wZWQuCgpDaGFuZ2VzIHNpbmNlIHYxOgo9PT09PT09PT09PT09PT09PQoq
IEZpeCB3cm9uZyBjaGVjayBpbiAtPnhsYXRlKCkuCiogQXBwbHkgdGhlIHNhbWUgZml4IHRvIHRo
ZSBjcDExMCBjb21waHkgZHJpdmVyIGZyb20gd2hpY2ggdGhlIGEzNzAwCiAgZHJpdmVyIGlzIGJh
c2VkLgoqIEFkZGVkIGNyZWRpdCB0byBHcmVnb3J6IEphc3pjenlrIGZvciBoaXMgd29yay4KKiBB
ZGRlZCBTdWdnZXN0ZWQtYnkgdGFnIHRvIHRoZSBwYXRjaCBhZGRpbmcgdGhlIENPTVBIWSBEVCBu
b2RlLgoKCkdyemVnb3J6IEphc3pjenlrICgxKToKICBwaHk6IGVudW1lcmF0ZSBTQVRBIFBIWSBt
b2RlCgpNaXF1ZWwgUmF5bmFsICg2KToKICBwaHk6IG12ZWJ1LWNwMTEwLWNvbXBoeTogZml4IHBv
cnQgY2hlY2sgaW4gLT54bGF0ZSgpCiAgcGh5OiBhZGQgQTM3MDAgQ09NUEhZIHN1cHBvcnQKICBk
dC1iaW5kaW5nczogcGh5OiBtdmVidS1jb21waHk6IGV4dGVuZCB0aGUgZmlsZSB0byBkZXNjcmli
ZSBhMzcwMAogICAgYmluZGluZ3MKICBNQUlOVEFJTkVSUzogcGh5OiBhZGQgZW50cnkgZm9yIEFy
bWFkYSAzNzAwIENPTVBIWSBkcml2ZXIKICBBUk02NDogZHRzOiBtYXJ2ZWxsOiBhcm1hZGEtMzd4
eDogZml4IFNBVEEgbm9kZSBzY29wZQogIEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zN3h4
OiBkZWNsYXJlIHRoZSBDT01QSFkgbm9kZQoKIC4uLi9iaW5kaW5ncy9waHkvcGh5LW12ZWJ1LWNv
bXBoeS50eHQgICAgICAgICB8ICA2NSArKystCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDYgKwogYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2Fy
bWFkYS0zN3h4LmR0c2kgIHwgIDMxICstCiBkcml2ZXJzL3BoeS9tYXJ2ZWxsL0tjb25maWcgICAg
ICAgICAgICAgICAgICAgfCAgMTAgKwogZHJpdmVycy9waHkvbWFydmVsbC9NYWtlZmlsZSAgICAg
ICAgICAgICAgICAgIHwgICAxICsKIGRyaXZlcnMvcGh5L21hcnZlbGwvcGh5LW12ZWJ1LWEzNzAw
LWNvbXBoeS5jICB8IDMxOCArKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvcGh5L21hcnZlbGwv
cGh5LW12ZWJ1LWNwMTEwLWNvbXBoeS5jICB8ICAgMiAtCiBpbmNsdWRlL2xpbnV4L3BoeS9waHku
aCAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogOCBmaWxlcyBjaGFuZ2VkLCA0MTkgaW5z
ZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9w
aHkvbWFydmVsbC9waHktbXZlYnUtYTM3MDAtY29tcGh5LmMKCi0tIAoyLjE5LjEKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
