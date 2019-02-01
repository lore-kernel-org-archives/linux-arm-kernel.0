Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB80C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:31:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7132184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PWXNqPOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7132184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XBvm4QzbSBlgjV3H4fpmv60ofEx9DvewYNfwPPH+tFA=; b=PWXNqPOe66pYYa
	PPC2IYGXRXMeH5wqd1YfWkOfVWky7kr52nW5sI+GhSffo3B2nFt8uIatQYVuAwY2AdWGepav6kxAp
	x0n3ujXWbM+FUVJK9X88tzqJSvuT/gzyCUdhontvhZ+quDhgjQm4pS9abMRmLZ9O3PEzXQ6ivglkL
	zWCAHFbxM2Btqf2rBhDdH6KC0jM7Xe+66g4jNG1JSeWBV1hbpCrXkQaLAh2NNib0a9RJpBcz3Dwat
	7Rarj5Pwzk4pj7DX3679gWThb1O0hVH0TKntbGVYr5WEn7IjWshnahefSwPHz2KtEyd4S+7z5GxRP
	MFZrj3XRNBAn3wNlwBIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpVAH-0002gj-Dd; Fri, 01 Feb 2019 09:31:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpVAC-0002fg-SI
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 09:31:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F08615BE;
 Fri,  1 Feb 2019 01:31:08 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com
 [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B7513F71E;
 Fri,  1 Feb 2019 01:31:06 -0800 (PST)
From: Quentin Perret <quentin.perret@arm.com>
To: viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 nm@ti.com, sboyd@kernel.org, mka@chromium.org
Subject: [PATCH v3 0/5] Register an Energy Model for Arm reference platforms
Date: Fri,  1 Feb 2019 09:30:56 +0000
Message-Id: <20190201093101.31869-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_013108_919302_E0D06380 
X-CRM114-Status: GOOD (  12.72  )
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
cy4KCkNoYW5nZXMgc2luY2UgdjIgKDIwMTkwMTMwMTcwNTA2LjIwNDUwLTEtcXVlbnRpbi5wZXJy
ZXRAYXJtLmNvbSkKIC0gQWRkZWQgY29tbWVudCB0byBleHBsYWluIHdoeSB3ZSBjaGVjayBvbmx5
IHRoZSBkeW5hbWljLXBvd2VyLWNvZWZmCiAgIHByb3BlcnR5IGFuZCBub3Qgdm9sdGFnZXMgaW4g
ZGV2X3BtX29wcF9vZl9yZWdpc3Rlcl9lbSgpIChWaXJlc2gpCiAtIEZpeGVkIGNvbW1lbnRzL2Rv
Y3N0cmluZ3Mgb2YgbmV3IGZ1bmN0aW9ucyBpbiBvcHAvb2YuYyAoTWF0dGhpYXMpCiAtIEFkZGVk
IE1hdHRoaWFzJyBUZXN0ZWQtYnkgdG8gcGF0Y2ggMDEKCkNoYW5nZXMgc2luY2UgdjEgKDIwMTkw
MTI4MTY1NTIyLjMxNzQ5LTEtcXVlbnRpbi5wZXJyZXRAYXJtLmNvbSk6CiAtIERyb3BwZWQgdGhl
IERUIHBhdGNoZXMgdGhhdCBoYXZlIGJlZW4gcXVldWVkIGJ5IFN1ZGVlcAogLSBJbnRyb2R1Y2Vk
IGRldl9wbV9vcHBfb2ZfcmVnaXN0ZXJfZW0oKSBoZWxwZXIgdG8gY2hlY2sgdGhlIHByZXNlbmNl
CiAgIG9mIHRoZSBEVCBjb2VmZiBiZWZvcmUgY2FsbGluZyBQTV9FTSAoVmlyZXNoLCBNYXR0aGlh
cykKIC0gQ29kaW5nLXN0eWxlIGltcHJvdmVtZW50cyAoVmlyZXNoLCBNYXR0aGlhcykKClRoYW5r
cywKUXVlbnRpbgoKRGlldG1hciBFZ2dlbWFubiAoMSk6CiAgY3B1ZnJlcTogYXJtX2JpZ19saXR0
bGU6IFJlZ2lzdGVyIGFuIEVuZXJneSBNb2RlbAoKUXVlbnRpbiBQZXJyZXQgKDQpOgogIFBNIC8g
T1BQOiBJbnRyb2R1Y2UgYSBwb3dlciBlc3RpbWF0aW9uIGhlbHBlcgogIGNwdWZyZXE6IGR0OiBS
ZWdpc3RlciBhbiBFbmVyZ3kgTW9kZWwKICBjcHVmcmVxOiBzY3BpOiBSZWdpc3RlciBhbiBFbmVy
Z3kgTW9kZWwKICBjcHVmcmVxOiBzY21pOiBSZWdpc3RlciBhbiBFbmVyZ3kgTW9kZWwKCiBkcml2
ZXJzL2NwdWZyZXEvYXJtX2JpZ19saXR0bGUuYyB8ICA4ICsrKwogZHJpdmVycy9jcHVmcmVxL2Nw
dWZyZXEtZHQuYyAgICAgfCAgOCArKy0KIGRyaXZlcnMvY3B1ZnJlcS9zY21pLWNwdWZyZXEuYyAg
IHwgMzkgKysrKysrKysrKysrLQogZHJpdmVycy9jcHVmcmVxL3NjcGktY3B1ZnJlcS5jICAgfCAg
OSArKy0KIGRyaXZlcnMvb3BwL29mLmMgICAgICAgICAgICAgICAgIHwgOTYgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUvbGludXgvcG1fb3BwLmggICAgICAgICAgIHwg
IDYgKysKIDYgZmlsZXMgY2hhbmdlZCwgMTU3IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0p
CgotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
