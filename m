Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBFAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:37:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBCF214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LOrTsEbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBCF214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZlZFIb7v2aS0vS5KiA9kGEESY9pTqvS9oUTkPU4vNQo=; b=LOrTsEbH3Xxxwt
	dSFeVuswHfSKzWvNcpY/LGl3aRLdh7lJXs+HZ5ZzxYL8/+tJ05ZWM22Z7WbFVg0eFVLj4QOFhHYIe
	2W2dyUjdsHfd4Q7hEHJh93CJxIwbxdIkFJ9V1+KTNZxMcyggN+SXJDtJ2idduM6TYg/m30jU9c+eM
	OuuFDZoQUnbJIiIu+L7RjwU84lV1G/3cucI088etCCndyx57cYRYHKk24tRmV+O25phXKjfCKTpo/
	TGGVjvvtHCNmtCggCiZNWtMpbAkq5Oj/l9amWx8PgWsxQT6xlIvqJSDyEfFfwloMQEkY3uV1ky1c5
	k427l6aKr2mRHC+qynxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPpn-0004EP-RU; Tue, 29 Jan 2019 09:37:35 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPp7-0003eG-Re
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:36:57 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 4C55320A18; Tue, 29 Jan 2019 10:36:47 +0100 (CET)
Received: from localhost.localdomain
 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id D837C20654;
 Tue, 29 Jan 2019 10:36:36 +0100 (CET)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v5 0/6] A3700 USB UTMI PHY support
Date: Tue, 29 Jan 2019 10:36:29 +0100
Message-Id: <20190129093635.4321-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_013654_174795_AA5093CA 
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
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VVNCMiBvbiBBMzcwMCBvbmx5IHdvcmtzIGJlY2F1c2UgVS1Cb290IGluaXRpYWxpemVzIHRoZSBV
VE1JIFBIWXMgKG9uZQp3aXJlZCB0byBlYWNoIFVTQiBjb250cm9sbGVyKS4gV2hpbGUgdGhlcmUg
aXMgbm8gaXNzdWUgd2l0aCByZWd1bGFyCnVzZSwgdGhpcyBhcmNoaXRlY3R1cmUgZG9lcyBub3Qg
YWxsb3cgc3VzcGVuZCB0byBSQU0gdG8gd29yayBhcyB0aGUKUEhZcyBtdXN0IGJlIHJlLWluaXRp
YWxpemVkIGF0IHJlc3VtZS4gSW4gb3JkZXIgdG8gc3VwcG9ydCB0aGlzCmZlYXR1cmUsIHRoaXMg
c2VyaWVzIGFkZHMgYSBVVE1JIFBIWSBkcml2ZXIgZm9yIHRoZSBBMzcwMCBTb0MuCgpUaGUgQTM3
MDAgZGV2aWNlIHRyZWUgaXMgdXBkYXRlZCB0byByZWZlcmVuY2UgdGhlIFBIWXMuCgpUaGFua3Ms
Ck1pcXXDqGwKCkNoYW5nZXMgc2luY2UgdjQ6Cj09PT09PT09PT09PT09PT09CiogRHJvcCBVU0Ig
cGF0Y2hlcyBhcyB0aGV5IGhhdmUgYmVlbiBzZW50IGluIGEgc2VwYXJhdGUgc2VyaWVzLiBObwog
IHJlYWwgZnVuY3Rpb25hbCBjaGFuZ2VzIHNpbmNlIHRoZSB2NCB0aG91Z2gsIGtpbmQgb2YgYSBy
ZXNlbmQgb2YgdGhlCiAgUEhZIHBhdGNoZXMgZnJvbSB0aGUgIkEzNzAwIFVTQiBTMlJBTSBzdXBw
b3J0IiBzZXJpZXMuCgpDaGFuZ2VzIHNpbmNlIHYzOgo9PT09PT09PT09PT09PT09PQoqIEJpbmRp
bmdzOiBhcyBzdWdnZXN0ZWQgYnkgR3JlZ29yeSBhbmQgUm9iLCB1c2VkIHRoZSAiLW1pc2MiIHN1
ZmZpeAogIGluc3RlYWQgb2YgIi1taXNjZWxsYW5lb3VzIiBhbmQgcHJlZml4ZWQgdGhlIGNvbXBh
dGlibGUgd2l0aAogICJhcm1hZGEtMzcwMCIgdG8gZm9sbG93IHdoYXQgaGFzIGJlZW4gdXNlZCBm
b3IgdGhlIG90aGVyIElQcyBvZiB0aGUKICBzYW1lIFNvQyAoYW5kIGFkZGVkIFJvYidzIGFjayku
CgpDaGFuZ2VzIHNpbmNlIHYyOgo9PT09PT09PT09PT09PT09PQoqIFR5cG9zCiogVVRNSSBQSFkg
YmluZGluZ3M6CiAgPiBOZXcgbmFtZSBmb3IgdGhlIFVTQjIgaG9zdC9QSFkgc3lzY29ucyAoKyBj
aGFuZ2VzIGluIHRoZSBEVCkuCiAgPiBDbGVhcmx5IHN0YXRlIHRoYXQgdGhlIFBIWXMgYXJlIGRp
ZmZlcmVudCBiZXR3ZWVuIE9URyBhbmQKICAgIGhvc3Qtb25seSBjb250cm9sbGVycy4KKiBVVE1J
IFBIWSBkcml2ZXI6CiAgPiBVc2UgR0VOTUFTSyBtYWNyby4KICA+IFJlbW92ZWQgdXNlbGVzcyBj
aGVja3Mgb24gZHJpdmVyIGRhdGEgcmV0cmlldmFsLgogID4gRHJvcHBlZCB0aGUgZW1wdHkgLT5y
ZW1vdmUoKSBob29rLgogID4gVXBkYXRlZCB0aGUgbGljZW5jZSBtYWNybyB0byBtYXRjaCB0aGUg
U1BEWCB0YWcuCiAgPiBVc2VkIHRoZSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoKSBoZWxwZXIu
CiAgPiBSZW1vdmVkIHRoZSB1c2Ugb2YgYSBsb2NhbCB2YXJpYWJsZSBpbiB0aGUgLT5wcm9iZSgp
IGZvciB0aGUKICAgIGRyaXZlcidzIG9wZXJhdGlvbnMuCiAgPiBGaXhlZCB0aGUgZHJpdmVyIGNv
LWF1dGhvcjogSWdhbCwgbm90IEV2YW4uCgpDaGFuZ2VzIHNpbmNlIHYxOgo9PT09PT09PT09PT09
PT09PQoqIEFkZCBVVE1JIFBIWSBkcml2ZXIvYmluZGluZ3MvRFQgY2hhbmdlcyB0byBicmluZyBT
MlJBTSBzdXBwb3J0IHRvCiAgYm90aCBVU0IgcG9ydHMgYXZhaWxhYmxlIG9uIHRoZSBBMzcwMCBT
b0MuCiogUmViYXNlZCBvbiB0b3Agb2YgdjUuMC1yYzEuCgoKTWlxdWVsIFJheW5hbCAoNik6CiAg
cGh5OiBhZGQgQTM3MDAgVVRNSSBQSFkgZHJpdmVyCiAgZHQtYmluZGluZ3M6IHBoeTogbXZlYnUt
dXRtaTogYWRkIFVUTUkgUEhZIGJpbmRpbmdzCiAgTUFJTlRBSU5FUlM6IHBoeTogZmlsbCBBcm1h
ZGEgMzcwMCBQSFkgZHJpdmVycyBlbnRyeQogIEFSTTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0z
N3h4OiBmaXggVVNCMiBtZW1vcnkgcmVnaW9uCiAgQVJNNjQ6IGR0czogbWFydmVsbDogYXJtYWRh
LTM3eHg6IGRlY2xhcmUgVVNCMiBVVE1JIFBIWXMKICBBUk02NDogZHRzOiBtYXJ2ZWxsOiBhcm1h
ZGEtMzd4eDogbGluayBVU0IgaG9zdHMgd2l0aCB0aGVpciBQSFlzCgogLi4uL2JpbmRpbmdzL3Bo
eS9waHktbXZlYnUtdXRtaS50eHQgICAgICAgICAgIHwgIDM4ICsrKwogTUFJTlRBSU5FUlMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICstCiBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL21hcnZlbGwvYXJtYWRhLTM3eHguZHRzaSAgfCAgMzQgKystCiBkcml2ZXJzL3BoeS9tYXJ2
ZWxsL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgIDkgKwogZHJpdmVycy9waHkvbWFydmVs
bC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgICAxICsKIGRyaXZlcnMvcGh5L21hcnZlbGwv
cGh5LW12ZWJ1LWEzNzAwLXV0bWkuYyAgICB8IDI3OCArKysrKysrKysrKysrKysrKysKIDYgZmls
ZXMgY2hhbmdlZCwgMzYyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXZlYnUt
dXRtaS50eHQKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BoeS9tYXJ2ZWxsL3BoeS1tdmVi
dS1hMzcwMC11dG1pLmMKCi0tIAoyLjE5LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
