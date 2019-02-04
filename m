Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6518EC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:10:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CE02082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tt+ME/YA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CE02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5dQrjUt9qDg3K3Aa4WD+Oqn7uxBBYxpSOJz1OrnsjOU=; b=tt+ME/YAOpPE5T
	uSnYKUtBVrrFrU69e4Y1Pn61P7kU9nppLJuhgThbpPIZaB+diQSeejPT6eGGjMApx1fpAe0YxyfM8
	WrMgcaD6/bPnV1r+oAlISAeupb/oGoKrTEbn+vCPGgeOkjSCeITHOzkgblk8S5fGstk2Zuk6QERZe
	kYZPQaa5GEACOC3y9pO3n72irJdO4kpFtrP/E0cK4xmcmdxk+pLIERl6MmBzXmanlW3/+Nwm6QAXD
	HKw6DX415Lg7TUsihVnx1R5Ol8pXcpW1qD7+yNR2vY4C1J1eo5RXUGFqn8R2Q1NBG5ZjfJ4mkoon3
	6lJnUnzbot0iDXmTINvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqc8b-0008Uh-3x; Mon, 04 Feb 2019 11:10:05 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqc8X-0008Ip-Cu
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 11:10:02 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B71FA78;
 Mon,  4 Feb 2019 03:09:59 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com
 [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29B223F675;
 Mon,  4 Feb 2019 03:09:57 -0800 (PST)
From: Quentin Perret <quentin.perret@arm.com>
To: viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 nm@ti.com, sboyd@kernel.org, mka@chromium.org
Subject: [PATCH v4 0/5] Register an Energy Model for Arm reference platforms
Date: Mon,  4 Feb 2019 11:09:47 +0000
Message-Id: <20190204110952.16025-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_031001_441675_7FB1C884 
X-CRM114-Status: GOOD (  12.40  )
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
cy4KCgpDaGFuZ2VzIHNpbmNlIHYzICgyMDE5MDIwMTA5MzEwMS4zMTg2OS0xLXF1ZW50aW4ucGVy
cmV0QGFybS5jb20pCiAtIE1vdmVkIHRoZSBPUFAgY291bnQgaW5zaWRlIGRldl9wbV9vcHBfb2Zf
cmVnaXN0ZXJfZW0oKSAoTWF0dGhpYXMsCiAgIFN1ZGVlcCkKCkNoYW5nZXMgc2luY2UgdjIgKDIw
MTkwMTMwMTcwNTA2LjIwNDUwLTEtcXVlbnRpbi5wZXJyZXRAYXJtLmNvbSkKIC0gQWRkZWQgY29t
bWVudCB0byBleHBsYWluIHdoeSB3ZSBjaGVjayBvbmx5IHRoZSBkeW5hbWljLXBvd2VyLWNvZWZm
CiAgIHByb3BlcnR5IGFuZCBub3Qgdm9sdGFnZXMgaW4gZGV2X3BtX29wcF9vZl9yZWdpc3Rlcl9l
bSgpIChWaXJlc2gpCiAtIEZpeGVkIGNvbW1lbnRzL2RvY3N0cmluZ3Mgb2YgbmV3IGZ1bmN0aW9u
cyBpbiBvcHAvb2YuYyAoTWF0dGhpYXMpCiAtIEFkZGVkIE1hdHRoaWFzJyBUZXN0ZWQtYnkgdG8g
cGF0Y2ggMDEKCkNoYW5nZXMgc2luY2UgdjEgKDIwMTkwMTI4MTY1NTIyLjMxNzQ5LTEtcXVlbnRp
bi5wZXJyZXRAYXJtLmNvbSk6CiAtIERyb3BwZWQgdGhlIERUIHBhdGNoZXMgdGhhdCBoYXZlIGJl
ZW4gcXVldWVkIGJ5IFN1ZGVlcAogLSBJbnRyb2R1Y2VkIGRldl9wbV9vcHBfb2ZfcmVnaXN0ZXJf
ZW0oKSBoZWxwZXIgdG8gY2hlY2sgdGhlIHByZXNlbmNlCiAgIG9mIHRoZSBEVCBjb2VmZiBiZWZv
cmUgY2FsbGluZyBQTV9FTSAoVmlyZXNoLCBNYXR0aGlhcykKIC0gQ29kaW5nLXN0eWxlIGltcHJv
dmVtZW50cyAoVmlyZXNoLCBNYXR0aGlhcykKClRoYW5rcywKUXVlbnRpbgoKRGlldG1hciBFZ2dl
bWFubiAoMSk6CiAgY3B1ZnJlcTogYXJtX2JpZ19saXR0bGU6IFJlZ2lzdGVyIGFuIEVuZXJneSBN
b2RlbAoKUXVlbnRpbiBQZXJyZXQgKDQpOgogIFBNIC8gT1BQOiBJbnRyb2R1Y2UgYSBwb3dlciBl
c3RpbWF0aW9uIGhlbHBlcgogIGNwdWZyZXE6IGR0OiBSZWdpc3RlciBhbiBFbmVyZ3kgTW9kZWwK
ICBjcHVmcmVxOiBzY3BpOiBSZWdpc3RlciBhbiBFbmVyZ3kgTW9kZWwKICBjcHVmcmVxOiBzY21p
OiBSZWdpc3RlciBhbiBFbmVyZ3kgTW9kZWwKCiBkcml2ZXJzL2NwdWZyZXEvYXJtX2JpZ19saXR0
bGUuYyB8ICAyICsKIGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLWR0LmMgICAgIHwgIDIgKwogZHJp
dmVycy9jcHVmcmVxL3NjbWktY3B1ZnJlcS5jICAgfCAzOSArKysrKysrKysrKystCiBkcml2ZXJz
L2NwdWZyZXEvc2NwaS1jcHVmcmVxLmMgICB8ICAzICsKIGRyaXZlcnMvb3BwL29mLmMgICAgICAg
ICAgICAgICAgIHwgOTkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUv
bGludXgvcG1fb3BwLmggICAgICAgICAgIHwgIDYgKysKIDYgZmlsZXMgY2hhbmdlZCwgMTQ4IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
