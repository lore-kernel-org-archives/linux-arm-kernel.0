Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03A5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:40:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2F62083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IvdqRixL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2F62083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gvOg/pRKDxpXH2CHRtFGRoAj/CEMyxL3YXDa+D3UV5k=; b=IvdqRixLITZlyx
	guGUexZA7ASTFGgmkXtcr4V5i81VxQEIB/gKdgBF2fcRigc1g1SeMFZv4c4E3rBvr3e/Fe9S9LJ/A
	0No800z9uJ4aYRgItmHl9uqk673q/kwSLo5MTDE3Rj5LOdt5heR7VHcXDDZ9iRvqgls8mIZqPAQ1g
	I52ehisxSEhsErDtpB232VWaYbFGs47+VNmym3Aq6OHpQZigYv8Yet0t5GUJLeDuWRCISryARVSmY
	p70bjMBht36BRzoO81fjeJiOADn6csT3chgkkmmrb3w1y4YOzpOBiso+FR5cfm4sY1nIgF+AgpjEH
	3GDJkH6UV5zGYCxsfTfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goSgr-0004U1-2R; Tue, 29 Jan 2019 12:40:33 +0000
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goSWk-0005jY-1I
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 12:30:19 +0000
Received: from yt-mxq.gw.nic.fujitsu.com (unknown [192.168.229.66]) by
 mgwym04.jp.fujitsu.com with smtp
 id 4390_0be1_4dad01ab_808a_4867_afb2_edb9a458d90d;
 Tue, 29 Jan 2019 21:30:01 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 0B919AC00DB
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 21:30:01 +0900 (JST)
Received: from G01JPEXCHKW18.g01.fujitsu.local
 (G01JPEXCHKW18.g01.fujitsu.local [10.0.194.57])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id 1118FBD66DF;
 Tue, 29 Jan 2019 21:30:00 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw18 ([10.0.194.57]) with mapi id 14.03.0415.000; Tue, 29 Jan 2019
 21:29:59 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: 'Catalin Marinas' <catalin.marinas@arm.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'Mark
 Rutland'" <mark.rutland@arm.com>, "'linux-arm-kernel@lists.infradead.org'"
 <linux-arm-kernel@lists.infradead.org>, "'will.deacon@arm.com'"
 <will.deacon@arm.com>, "'james.morse@arm.com'" <james.morse@arm.com>
Subject: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum 010001
Thread-Topic: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AdS3xNmu3mhhC9MiQRq9+42ieDlaoA==
Date: Tue, 29 Jan 2019 12:29:58 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_043007_319976_9EB1D5F5 
X-CRM114-Status: GOOD (  15.47  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gc29tZSB2YXJpYW50cyBvZiB0aGUgRnVqaXRzdS1BNjRGWCBjb3JlcyB2ZXIoMS4wLCAxLjEp
LCAgDQptZW1vcnkgYWNjZXNzZXMgbWF5IGNhdXNlIHVuZGVmaW5lZCBmYXVsdCAoRGF0YSBhYm9y
dCwgREZTQz0wYjExMTExMSkuDQpUaGlzIHByb2JsZW0gd2lsbCBiZSBmaXhlZCBieSBuZXh0IHZl
cnNpb24gb2YgRnVqaXRzdS1BNjRGWC4NCg0KVGhpcyBmYXVsdCBvY2N1cnMgdW5kZXIgYSBzcGVj
aWZpYyBoYXJkd2FyZSBjb25kaXRpb24gDQp3aGVuIGEgbG9hZC9zdG9yZSBpbnN0cnVjdGlvbiBw
ZXJmb3JtIGFuIGFkZHJlc3MgdHJhbnNsYXRpb24gdXNpbmc6DQogIGNhc2UtMSAgVFRCUjBfRUwx
IHdpdGggVENSX0VMMS5ORkQwID09IDEuDQogIGNhc2UtMiAgVFRCUjBfRUwyIHdpdGggVENSX0VM
Mi5ORkQwID09IDEuDQogIGNhc2UtMyAgVFRCUjFfRUwxIHdpdGggVENSX0VMMS5ORkQxID09IDEu
DQogIGNhc2UtNCAgVFRCUjFfRUwyIHdpdGggVENSX0VMMi5ORkQxID09IDEuDQpBbmQgdGhpcyBm
YXVsdCBvY2N1cnMgY29tcGxldGVseSBzcHVyaW91cy4NCg0KU2luY2UgVENSX0VMeC5ORkQxIGlz
IHNldCB0byAnMScgYXQgdGhlIGtlcm5lbCBpbiB2ZXJzaW9ucyANCnBhc3QgNC4xNywgdGhlIGNh
c2UtMyBvciBjYXNlLTQgbWF5IGhhcHBlbi4NCg0KVGhpcyBmYXVsdCBjYW4gYmUgdGFrZW4gb25s
eSBhdCBzdGFnZS0xLCANCnNvIHRoaXMgZmF1bHQgaXMgdGFrZW4gZnJvbSBFTDAgdG8gRUwxL0VM
MiwgZnJvbSBFTDEgdG8gRUwxLCANCm9yIGZyb20gRUwyIHRvIEVMMi4NCg0KSSB3b3VsZCBsaWtl
IHRvIHBvc3QgYSB3b3JrYXJvdW5kIHRvIGF2b2lkIHRoaXMgcHJvYmxlbSBvbiANCmV4aXN0aW5n
IEZ1aml0c3UtQTY0RlggdmVyc2lvbi4NCg0KVGhlcmUgYXJlIDIgcG9pbnRzIGluIHRoaXMgd29y
a2Fyb3VuZC4NClBvaW50MTogdHJhcCBmcm9tIEVMMSB0byBFTDEsIEVMMiB0byBFTDINClNldCAn
MCcgdG8gVENSX0VMeC5ORkQxaW4ga2VybmVsLWVudHJ5LCANCmFuZCBzZXQgJzEnIGluIGtlcm5l
bC1leGl0Lg0KDQpGcm9tIHRoZSB2aWV3IHBvaW50IG9mIEFSTSBzcGVjaWZpY2F0aW9uLCB0aGVy
ZSBpcyBubyBwcm9ibGVtIHRvIA0KcmVzZXQgVENSX0VMeC57TkZEMCxORkQxfSB3aGlsZSBpbiBF
TDEvRUwyLCBiZWNhdXNlIA0KVENSX0VMeC57TkZEMCxORkQxfSBjb250cm9scyB3aGV0aGVyIHRv
IHBlcmZvcm0gYSB0cmFuc2xhdGlvbiANCnRhYmxlIHdhbGsgaW4gcmVzcG9uc2UgdG8gYW4gYWNj
ZXNzIGZyb20gRUwwLg0KDQpJIGNvbmZpcm1lZCB0aGF0Og0K44O7VGhlcmUgaXMgbm8gbG9hZC9z
dG9yZSBpbnN0cnVjdGlvbiBiZXR3ZWVuIA0KICB0cmFtcF92ZW50cnkgYW5kIHNldHRpbmcgVENS
X0VMeC5ORkQxIHRvICcwJy4NCuODu1RoZXJlIGlzIG5vIGxvYWQvc3RvcmUgaW5zdHJ1Y3Rpb24g
YmV0d2VlbiANCiAgc2V0dGluZyBUQ1JfRUx4Lk5GRDEgdG8gJzEnIGFuZCB0cmFtcF9leGl0Lg0K
DQpQb2ludDI6IHRyYXAgZnJvbSBFTDAgdG8gRUwxL0VMMg0KU2luY2UgdGhpcyBmYXVsdCBhbHNv
IG9jY3VycyBpbiBFTDAsDQpyZXBsYWNlIHRoZSBmYXVsdCBoYW5kbGVyIGZvciBEYXRhIGFib3J0
DQpERlNDPTBiMTExMTExIHdpdGggYSBuZXcgb25lIHRvIGlnbm9yZSB0aGlzIHVuZGVmaW5lZCBm
YXVsdC4NCkkgZ3VhcmFudGVlIHRoYXQgYSB0aHJlYWQgd2lsbCBzdG9wIGRlbGl2ZXJpbmcgdGhp
cyBmYXVsdCBjb2RlIGJ5IGlnbm9yZQ0KdGhpcyB1bmRlZmluZWQgZmF1bHQuDQoNClRoZSBoYXJk
d2FyZSBjb25kaXRpb24gd2hpY2ggY2F1c2UgdGhpcyBmYXVsdCBpcyByZXNldCBhdCBleGNlcHRp
b24gZW50cnksIA0KdGhlcmVmb3JlIGV4ZWN1dGlvbiBvZiBhdCBsZWFzdCBvbmUgaW5zdHJ1Y3Rp
b24gaXMgDQpndWFyYW50ZWVkIGJ5IHRoaXMgc2luZ2xlIHJldHJ5Lg0KDQoNClRoaXMgd29ya2Fy
b3VuZCBpcyBiYXNlZCBvbiBsaW51eC01LjAtcmMyLA0Kd2hpY2ggVENSX0VMeC5ORkQxIGlzIHNl
dCB0byAnMScgDQpvbmx5IG9uY2UgYXQgYm9vdCBzZXF1ZW5jZSwgDQphbmQgVENSX0VMeC5ORkQw
IGlzIG5vdCBzZXQgYnkga2VybmVsLg0KSSB3aWxsIHVwZGF0ZSBteSBwYXRjaCBpZiBuZXcga2Vy
bmVsIG1ha2VzIHNvbWUgY2hhbmdlcw0KYWJvdXQgVENSX0VMeC57TkZEMCxORkQxfS4NCg0KQ2hh
bmdlcyBzaW5jZSBbdjFdDQpBcyBNYXJrJ3MgcmV2aWV3Og0KDQogKiBBZG9wdGVkIGVycmF0YSBm
cmFtZXdvcmsuDQoNCkNoYW5nZXMgc2luY2UgW3YyXQ0KQXMgTWFyayBhbmQgSmFtZXMnIHJldmll
dzoNCiANCiAqIEFkZGVkIGZyYW1ld29yayB0byBjaGFuZ2UgVENSX0VMeC5ORkQxLg0KICAtIENo
YW5nZSBUQ1JfRUx4Lk5GRDEgdG8gMCB3aGVuIGVudHJ5IGtlcm5lbC4NCiAgLSBDaGFuZ2UgVENS
X0VMeC5ORkQxIHRvIDEgd2hlbiBleGl0IGtlcm5lbC4NCg0KSSBmdWxseSBhcHByZWNpYXRlIHRo
YXQgaWYgc29tZW9uZSBjYW4gdGVzdCB0aGlzIHBhdGNoIG9uIGRpZmZlcmVudCBjaGlwcyANCnRv
IHZlcml0eSBubyBoYXJtZnVsIGVmZmVjdCBvbiBvdGhlciBjaGlwcy4NCg0KSWYgdGhlcmUgaXMg
bm8gcHJvYmxlbSBvbiBvdGhlciBjaGlwcywgcGxlYXNlIG1lcmdlIHRoaXMgcGF0Y2guDQoNClRo
ZSBwYXRjaCBiYXNlZCBvbiBsaW51eC01LjAtcmMyLg0KDQpaaGFuZyBMZWkgKDEpOg0KICBBcm02
NDogQWRkIHdvcmthcm91bmQgZm9yIEZ1aml0c3UgQTY0RlggZXJyYXR1bSAwMTAwMDENCg0KIERv
Y3VtZW50YXRpb24vYXJtNjQvc2lsaWNvbi1lcnJhdGEudHh0IHwgIDEgKw0KIGFyY2gvYXJtNjQv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0K
IGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vY3B1Y2Fwcy5oICAgICAgIHwgIDMgKystDQogYXJjaC9h
cm02NC9pbmNsdWRlL2FzbS9jcHV0eXBlLmggICAgICAgfCAgNCArKysrDQogYXJjaC9hcm02NC9r
ZXJuZWwvY3B1X2VycmF0YS5jICAgICAgICAgfCAgOCArKysrKysrKw0KIGFyY2gvYXJtNjQva2Vy
bmVsL2VudHJ5LlMgICAgICAgICAgICAgIHwgMTYgKysrKysrKysrKysrKysrKw0KIGFyY2gvYXJt
NjQvbW0vZmF1bHQuYyAgICAgICAgICAgICAgICAgIHwgMTYgKysrKysrKysrKysrKysrLQ0KIGFy
Y2gvYXJtNjQvbW0vcHJvYy5TICAgICAgICAgICAgICAgICAgIHwgMjAgKysrKysrKysrKysrKysr
KysrKysNCiA4IGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQoNCi0tIA0KMS44LjMuMQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
