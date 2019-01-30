Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FBCC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:06:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6508120989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lj4AxHd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6508120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=g6Lhev9Kah8QiTWHTWROtIKFNcu31V+VALfo6VQYinU=; b=Lj4AxHd8fanpp1
	zx7gWEjFFcpuEm+Oa9zll8LbGC9QJW/LWRiGRdL51E8XABNLsIJ/uhHm8I7LxiBEE4MAYPD407m6t
	XXlIxeFgk5ohVyOzovJlMwH4eXHDl3omXZSGOfPt/kJqMmlvPntsTSnnaPiTY3ornk6cqXdyNgne6
	W7xJdNuDr8sAFFvdrR3WAZ4SapBwZ0eWmYHRbpxx0poPb/aYJM4Y6HcGg/kMHlMtUrbR5+EyyanP1
	lCT5brr4dFWw9N6MnPaDvLHJ8xpwLqn1ocZyYuXDdSBeWkv+haf+mNEWAz96XccerraYViBx+Qp7Y
	QVge9JzYgDlJN+uCUC+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gotJD-0005Qe-EL; Wed, 30 Jan 2019 17:05:55 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gotIh-00051t-EU
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 17:05:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 851BF80D;
 Wed, 30 Jan 2019 09:05:22 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com
 [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 936483F589;
 Wed, 30 Jan 2019 09:05:20 -0800 (PST)
From: Quentin Perret <quentin.perret@arm.com>
To: viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 nm@ti.com, sboyd@kernel.org, mka@chromium.org
Subject: [PATCH v2 0/5] Register an Energy Model for Arm reference platforms
Date: Wed, 30 Jan 2019 17:05:01 +0000
Message-Id: <20190130170506.20450-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_090523_487112_956BA4AF 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: quentin.perret@arm.com, dietmar.eggemann@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIEVuZXJneSBNb2RlbCAoRU0pIGZyYW1ld29yayBmZWVkcyBpbnRlcmVzdGVkIHN1YnN5c3Rl
bXMgKHRoZQpzY2hlZHVsZXIvRUFTIGFzIG9mIG5vdykgd2l0aCBwb3dlciBjb3N0cyBwcm92aWRl
ZCBieSBkcml2ZXJzLiBZZXQsIG5vCmRyaXZlciBpcyBhY3R1YWxseSBkb2luZyB0aGF0IHVwc3Ry
ZWFtIHlldC4gVGhpcyBzZXJpZXMgdXBkYXRlcyBhIHNldCBvZgpDUFVGcmVxIGRyaXZlcnMgaW4g
b3JkZXIgdG8gcmVnaXN0ZXIgcG93ZXIgY29zdHMgaW4gdGhlIEVNIGZyYW1ld29yayBmb3IKc29t
ZSBvZiB0aGUgQXJtIHJlZmVyZW5jZSBwbGF0Zm9ybXMgZm9yIEVBUzogSGlrZXk5NjAsIEp1bm8g
YW5kIFRDMi4KClRoZSBzZXJpZXMgaXMgc3BsaXQgYXMgZm9sbG93czoKIC0gUGF0Y2ggMDEgaW50
cm9kdWNlcyBpbiBQTV9PUFAgYSBoZWxwZXIgZnVuY3Rpb24gd2hpY2ggZXN0aW1hdGVzIHRoZQog
ICBDUFUgcG93ZXIgdXNpbmcgdGhlIFA9Q1bCsmYgZXF1YXRpb24gYWxzbyB1c2VkIGJ5IElQQS4g
SXQgc2hvdWxkIGJlCiAgIG5vdGVkIHRoYXQgdGhpcyBpbnRyb2R1Y2VzIGR1cGxpY2F0ZSBjb2Rl
IHdpdGggSVBBLCB3aGljaCB3aWxsCiAgIGV2ZW50dWFsbHkgYmUgZml4ZWQgYnkgbWlncmF0aW5n
IElQQSB0byB1c2luZyBQTV9FTS4gVGhlIGlkZWFsIHBsYW4KICAgd291bGQgYmUgdG8gZG8gc28g
bGF0ZXIsIGluIGEgc2VwYXJhdGUgcGF0Y2ggc2VyaWVzLiBJIHdvdWxkIGluZGVlZAogICBwcmVm
ZXIgdG8ga2VlcCB0aGUgdGhlcm1hbCBhbmQgQ1BVRnJlcSBkaXNjdXNzaW9uIHNlcGFyYXRlIGF0
IHRoaXMKICAgc3RhZ2UsIGlmIGRlZW1lZCBhY2NlcHRhYmxlLgogLSBQYXRjaGVzIDAyLTA0IG1h
a2UgdXNlIG9mIHRoYXQgUE1fT1BQIGhlbHBlciBmdW5jdGlvbiBmcm9tIHRoZQogICBmb2xsb3dp
bmcgQ1BVRnJlcSBkcml2ZXJzOiBjcHVmcmVxLWR0LCBzY3BpLWNwdWZyZXEgYW5kCiAgIGFybV9i
aWdfbGl0dGxlLgogLSBQYXRjaCAwNSBtb2RpZmllcyB0aGUgU0NNSSBjcHVmcmVxIGRyaXZlciB0
byBwYXNzIHRoZSBwb3dlciBjb3N0cwogICBvYnRhaW5lZCBmcm9tIGZpcm13YXJlIHRvIFBNX0VN
LiBUaGlzIHBhdGNoIGlzIGluZGVwZW5kZW50IGZyb20gdGhlCiAgIHJlc3Qgb2YgdGhlIHNlcmll
cy4KCgpDaGFuZ2VzIHNpbmNlIHYxICgyMDE5MDEyODE2NTUyMi4zMTc0OS0xLXF1ZW50aW4ucGVy
cmV0QGFybS5jb20pOgogLSBEcm9wcGVkIHRoZSBEVCBwYXRjaGVzIHRoYXQgaGF2ZSBiZWVuIHF1
ZXVlZCBieSBTdWRlZXAKIC0gSW50cm9kdWNlZCBkZXZfcG1fb3BwX29mX3JlZ2lzdGVyX2VtKCkg
aGVscGVyIHRvIGNoZWNrIHRoZSBwcmVzZW5jZQogICBvZiB0aGUgRFQgY29lZmYgYmVmb3JlIGNh
bGxpbmcgUE1fRU0gKFZpcmVzaCwgTWF0dGhpYXMpCiAtIENvZGluZy1zdHlsZSBpbXByb3ZlbWVu
dHMgKFZpcmVzaCwgTWF0dGhpYXMpCgoKVGhhbmtzLApRdWVudGluCgoKRGlldG1hciBFZ2dlbWFu
biAoMSk6CiAgY3B1ZnJlcTogYXJtX2JpZ19saXR0bGU6IFJlZ2lzdGVyIGFuIEVuZXJneSBNb2Rl
bAoKUXVlbnRpbiBQZXJyZXQgKDQpOgogIFBNIC8gT1BQOiBJbnRyb2R1Y2UgYSBwb3dlciBlc3Rp
bWF0aW9uIGhlbHBlcgogIGNwdWZyZXE6IGR0OiBSZWdpc3RlciBhbiBFbmVyZ3kgTW9kZWwKICBj
cHVmcmVxOiBzY3BpOiBSZWdpc3RlciBhbiBFbmVyZ3kgTW9kZWwKICBjcHVmcmVxOiBzY21pOiBS
ZWdpc3RlciBhbiBFbmVyZ3kgTW9kZWwKCiBkcml2ZXJzL2NwdWZyZXEvYXJtX2JpZ19saXR0bGUu
YyB8ICA4ICsrKwogZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEtZHQuYyAgICAgfCAgOCArLS0KIGRy
aXZlcnMvY3B1ZnJlcS9zY21pLWNwdWZyZXEuYyAgIHwgMzkgKysrKysrKysrKysrLS0KIGRyaXZl
cnMvY3B1ZnJlcS9zY3BpLWNwdWZyZXEuYyAgIHwgIDkgKystLQogZHJpdmVycy9vcHAvb2YuYyAg
ICAgICAgICAgICAgICAgfCA4OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogaW5j
bHVkZS9saW51eC9wbV9vcHAuaCAgICAgICAgICAgfCAgNiArKysKIDYgZmlsZXMgY2hhbmdlZCwg
MTQ5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgotLSAKMi4yMC4xCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
