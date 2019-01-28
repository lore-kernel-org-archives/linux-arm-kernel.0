Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50471C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:55:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F14D2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k4KO4Fao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F14D2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=D5OZEwk0yVpWSxJfioau6rPiRQIcvZkbchq39rOHtes=; b=k4KO4Fao8nOzJf
	1a85CAq1LN/ZWyheMbOWBoDN2J53AbuUG3Mw5d23QhIJWsWBqFjp4agPpJ+H9EsFCeNjQPr7BM5gD
	FKbK4HYX6sNPWIAHozcU7N2lpw97gfsK3OsoRQARTVIERZJkBylKcWphTsirER3TvYl1s1dqDAc1U
	r+q5sXMI6F7PZo1WZSAMvQwRYmQEH+0vJaNluMbTpce+IiQan0kvB8iWFK5jgt6acfZmd8DHN6Chu
	8A5SCopBgKs4C8ZAvFOI4iT7thi1ndzdNJpI1qJdXfaAbh46oKNOFvsyr9g7vGhrYIyTOqSl8xoAK
	9Hdjic0Y+p/JkF2K5Fpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goAC7-0007uI-El; Mon, 28 Jan 2019 16:55:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goAC4-0007t5-PX
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:55:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FDBBEBD;
 Mon, 28 Jan 2019 08:55:30 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com
 [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C16DC3F59C;
 Mon, 28 Jan 2019 08:55:27 -0800 (PST)
From: Quentin Perret <quentin.perret@arm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com,
 liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
 mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org
Subject: [PATCH 0/7] Register an Energy Model for Arm reference platforms
Date: Mon, 28 Jan 2019 16:55:15 +0000
Message-Id: <20190128165522.31749-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_085532_885400_1264F869 
X-CRM114-Status: GOOD (  12.04  )
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
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, quentin.perret@arm.com, mka@chromium.org,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIEVuZXJneSBNb2RlbCAoRU0pIGZyYW1ld29yayBmZWVkcyBpbnRlcmVzdGVkIHN1YnN5c3Rl
bXMgKHRoZQpzY2hlZHVsZXIvRUFTIGFzIG9mIG5vdykgd2l0aCBwb3dlciBjb3N0cyBwcm92aWRl
ZCBieSBkcml2ZXJzLiBZZXQsIG5vCmRyaXZlciBpcyBhY3R1YWxseSBkb2luZyB0aGF0IHVwc3Ry
ZWFtIHlldC4gVGhpcyBzZXJpZXMgdXBkYXRlcyBhIHNldCBvZgpDUFVGcmVxIGRyaXZlcnMgYW5k
IERUIGZpbGVzIGluIG9yZGVyIHRvIHJlZ2lzdGVyIHBvd2VyIGNvc3RzIGluIHRoZSBFTQpmcmFt
ZXdvcmsgZm9yIHNvbWUgb2YgdGhlIEFybSByZWZlcmVuY2UgcGxhdGZvcm1zIGZvciBFQVM6IEhp
a2V5OTYwLApKdW5vIGFuZCBUQzIuCgpUaGUgc2VyaWVzIGlzIHNwbGl0IGFzIGZvbGxvd3M6Cgog
KiBQYXRjaCAwMSBpbnRyb2R1Y2VzIGluIFBNX09QUCBhIGhlbHBlciBmdW5jdGlvbiB3aGljaCBl
c3RpbWF0ZXMgdGhlCiAgIENQVSBwb3dlciB1c2luZyB0aGUgUD1DVsKyZiBlcXVhdGlvbiBhbHNv
IHVzZWQgYnkgSVBBLiBJdCBzaG91bGQgYmUKICAgbm90ZWQgdGhhdCB0aGlzIGludHJvZHVjZXMg
ZHVwbGljYXRlIGNvZGUgd2l0aCBJUEEsIHdoaWNoIHdpbGwKICAgZXZlbnR1YWxseSBiZSBmaXhl
ZCBieSBtaWdyYXRpbmcgSVBBIHRvIHVzaW5nIFBNX0VNLiBUaGUgaWRlYWwgcGxhbgogICB3b3Vs
ZCBiZSB0byBkbyBzbyBsYXRlciwgaW4gYSBzZXBhcmF0ZSBwYXRjaCBzZXJpZXMuIEkgd291bGQg
aW5kZWVkCiAgIHByZWZlciB0byBrZWVwIHRoZSB0aGVybWFsIGFuZCBDUFVGcmVxIGRpc2N1c3Np
b24gc2VwYXJhdGUgYXQgdGhpcwogICBzdGFnZSwgaWYgZGVlbWVkIGFjY2VwdGFibGUuCgogKiBQ
YXRjaGVzIDAyLTA0IG1ha2UgdXNlIG9mIHRoYXQgUE1fT1BQIGhlbHBlciBmdW5jdGlvbiBmcm9t
IHRoZQogICBmb2xsb3dpbmcgQ1BVRnJlcSBkcml2ZXJzOiBjcHVmcmVxLWR0LCBzY3BpLWNwdWZy
ZXEgYW5kCiAgIGFybV9iaWdfbGl0dGxlLgoKICogUGF0Y2ggMDUgbW9kaWZpZXMgdGhlIFNDTUkg
Y3B1ZnJlcSBkcml2ZXIgdG8gcGFzcyB0aGUgcG93ZXIgY29zdHMKICAgb2J0YWluZWQgZnJvbSBm
aXJtd2FyZSB0byBQTV9FTS4KCiAqIFBhdGNoZXMgMDYtMDcgcHJvdmlkZSB0aGUgZHluYW1pYy1w
b3dlci1jb2VmZmljaWVudCB2YWx1ZXMgZm9yIEp1bm8KICAgYW5kIFRDMi4KClRoYW5rcywKUXVl
bnRpbgoKRGlldG1hciBFZ2dlbWFubiAoMyk6CiAgY3B1ZnJlcTogYXJtX2JpZ19saXR0bGU6IFJl
Z2lzdGVyIGFuIEVuZXJneSBNb2RlbAogIGFybTY0OiBkdHM6IGp1bm86IEFkZCBjcHUgZHluYW1p
Yy1wb3dlci1jb2VmZmljaWVudCBpbmZvcm1hdGlvbgogIGFybTogZHRzOiB2ZXhwcmVzcy12MnAt
Y2ExNV9hNzogQWRkIGNwdSBkeW5hbWljLXBvd2VyLWNvZWZmaWNpZW50CiAgICBpbmZvcm1hdGlv
bgoKUXVlbnRpbiBQZXJyZXQgKDQpOgogIFBNIC8gT1BQOiBJbnRyb2R1Y2UgYSBwb3dlciBlc3Rp
bWF0aW9uIGhlbHBlcgogIGNwdWZyZXE6IGR0OiBSZWdpc3RlciBhbiBFbmVyZ3kgTW9kZWwKICBj
cHVmcmVxOiBzY3BpOiBSZWdpc3RlciBhbiBFbmVyZ3kgTW9kZWwKICBjcHVmcmVxOiBzY21pOiBS
ZWdpc3RlciBhbiBFbmVyZ3kgTW9kZWwKCiBhcmNoL2FybS9ib290L2R0cy92ZXhwcmVzcy12MnAt
Y2ExNV9hNy5kdHMgfCAgNSArKwogYXJjaC9hcm02NC9ib290L2R0cy9hcm0vanVuby1yMi5kdHMg
ICAgICAgIHwgIDYgKysrCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2FybS9qdW5vLmR0cyAgICAgICAg
ICAgfCAgNiArKysKIGRyaXZlcnMvY3B1ZnJlcS9hcm1fYmlnX2xpdHRsZS5jICAgICAgICAgICB8
IDEwICsrKysKIGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLWR0LmMgICAgICAgICAgICAgICB8ICA3
ICsrLQogZHJpdmVycy9jcHVmcmVxL3NjbWktY3B1ZnJlcS5jICAgICAgICAgICAgIHwgMzYgKysr
KysrKysrKysrLQogZHJpdmVycy9jcHVmcmVxL3NjcGktY3B1ZnJlcS5jICAgICAgICAgICAgIHwg
IDggKystCiBkcml2ZXJzL29wcC9vZi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA2MCAr
KysrKysrKysrKysrKysrKysrKysrCiBpbmNsdWRlL2xpbnV4L3BtX29wcC5oICAgICAgICAgICAg
ICAgICAgICAgfCAgNSArKwogOSBmaWxlcyBjaGFuZ2VkLCAxNDAgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkKCi0tIAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
