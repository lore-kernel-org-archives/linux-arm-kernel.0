Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:49:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878CC2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MNBhOodd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878CC2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0Yym0H8NhmljLwE61Kog32Yrik1eMPXL6iNipK/2oLE=; b=MNBhOoddoz/Xm8
	qQyBTIkMOg4X7yWxiGQDQgW8QuQ+kg2yTEnKYsAErLCE4uBhF7xkKLrCszsMO/C2q1/RzVDPxLMAK
	+7sDq/ww+TD0t4kzcugt05miHlUaTidlvsl/VzqYQlyAQiaxt9uGOlhgjM06WMjymYPF038vV0WnE
	JFqePuCEaBK0R+BqPHvHHCiP2Z1skEM7TbRQN+7hQUsXsxIyyWQN3N/AghxP3DOoLBlht6sajofWR
	M+CZVEdkcKX+r9DOIJX/wbR/DAdHs1QGFMlwTHYkkpwXuzbcjTPHdxteKkONtKhNAbTg/dhErgXMB
	VGEkVNinfbStbNkZEcNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYv94-0003tq-C7; Mon, 17 Dec 2018 15:49:26 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYv8x-0003gi-Rt
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:49:23 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id D151D20733; Mon, 17 Dec 2018 16:49:07 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6E48A20726;
 Mon, 17 Dec 2018 16:48:57 +0100 (CET)
Date: Mon, 17 Dec 2018 16:48:57 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper
 <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v4 3/7] phy: add A3700 COMPHY support
Message-ID: <20181217164857.68df3f84@xps13>
In-Reply-To: <20181213083908.14180-4-miquel.raynal@bootlin.com>
References: <20181213083908.14180-1-miquel.raynal@bootlin.com>
 <20181213083908.14180-4-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_074920_380198_BA5F8C25 
X-CRM114-Status: GOOD (  16.16  )
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
 Evan Wang <xswang@marvell.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpbLi4uXQoKPiArCj4gK3N0YXRpYyBpbnQgbXZlYnVfYTM3MDBfY29tcGh5X3NtYyh1
bnNpZ25lZCBsb25nIGZ1bmN0aW9uLCB1bnNpZ25lZCBsb25nIGxhbmUsCj4gKwkJCQkgIHVuc2ln
bmVkIGxvbmcgbW9kZSkKPiArewo+ICsJc3RydWN0IGFybV9zbWNjY19yZXMgcmVzOwo+ICsKPiAr
CWFybV9zbWNjY19zbWMoZnVuY3Rpb24sIGxhbmUsIG1vZGUsIDAsIDAsIDAsIDAsIDAsICZyZXMp
OwoKSSByZWNlaXZlZCB0aGUgZm9sbG93aW5nIGJ1ZyByZXBvcnQgYmVjYXVzZSBJIGFkZGVkIGEg
ZGVwZW5kZW5jeSBvbgpDT01QSUxFX1RFU1QgaW4gS2NvbmZpZzoKCiAgICAgICAgY29uZmlnOiBp
Mzg2LWFsbG1vZGNvbmZpZyAoYXR0YWNoZWQgYXMgLmNvbmZpZykgY29tcGlsZXI6CiAgICAgICAg
Z2NjLTcgKERlYmlhbiA3LjMuMC0xKSA3LjMuMCByZXByb2R1Y2U6CiAgICAgICAgICAgICAgICAj
IHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8gbGludXggYnVpbGQgdHJlZQogICAgICAgICAg
ICAgICAgbWFrZSBBUkNIPWkzODYgCgogICAgICAgIEFsbCBlcnJvcnMgKG5ldyBvbmVzIHByZWZp
eGVkIGJ5ID4+KToKCiAgICAgICAgPj4gRVJST1I6ICJfX2FybV9zbWNjY19zbWMiIFtkcml2ZXJz
L3BoeS9tYXJ2ZWxsL3BoeS1tdmVidS1hMzcwMC1jb21waHkua29dIHVuZGVmaW5lZCEgIAoKVW5s
ZXNzIHNvbWVvbmUgY29tcGxhaW5zLCBJIHdpbGwgZHJvcCB0aGUgZGVwZW5kZW5jeSBvbiBDT01Q
SUxFX1RFU1QgaW4KS2NvbmZpZy4KCj4gKwo+ICsJcmV0dXJuIHJlcy5hMDsKPiArfQoKClRoYW5r
cywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
