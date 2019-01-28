Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB51C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C32E2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N3cmIdug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C32E2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2te/GOMfs7sUDwt7IsM2bCHRFxd6ddVsltfwL1qr7Wg=; b=N3cmIdugqJ54AD
	+zZYC3hcbpYkmJPItOTxyKODeypsZ1K68k8k5SDzx/k6FRTrMwSITlY9EirHBPuiAqeJYbJKFFjhQ
	SHJHFT9rl0sByPTcwUUpPP34F+f/PeclVc0bRNuFmu5Fndb8BA2TrIUX1di+0W8wJdohJP+NY/+U+
	d0yGlW97w5NCBVZBADc47qtso2nNDKEoJUItM7pXGJbkyGukiB8sy+M5N7fDJ2qSOWLGclH++v2Vu
	J+B2Y7TdlJa3VGbelzAhTUAikz9vEkmHgL/GHRE4+YLUNHK4HGOzu+pfm43/QcBWvLuUfcO48codi
	hIarwXrp9HeFajwLDlkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goADs-0001E6-2v; Mon, 28 Jan 2019 16:57:24 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goACM-000828-TB
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:55:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2381EBD;
 Mon, 28 Jan 2019 08:55:50 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com
 [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 300723F59C;
 Mon, 28 Jan 2019 08:55:48 -0800 (PST)
From: Quentin Perret <quentin.perret@arm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com,
 liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
 mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org
Subject: [PATCH 7/7] arm: dts: vexpress-v2p-ca15_a7: Add cpu
 dynamic-power-coefficient information
Date: Mon, 28 Jan 2019 16:55:22 +0000
Message-Id: <20190128165522.31749-8-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128165522.31749-1-quentin.perret@arm.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_085551_193301_42C3F726 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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

RnJvbTogRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5lZ2dlbWFubkBhcm0uY29tPgoKQSBDUFVm
cmVxIGRyaXZlciwgbGlrZSB0aGUgQVJNIGJpZy5MSVRUTEUgZHJpdmVyIHVzZWQgb24gdGhlIFRD
MiBib2FyZCwKd2hpY2ggcHJvdmlkZSB0aGUgRW5lcmd5IE1vZGVsIHdpdGggcG93ZXIgY29zdCBp
bmZvcm1hdGlvbiB2aWEgdGhlClBNX09QUCBvZl9kZXZfcG1fb3BwX2dldF9jcHVfcG93ZXIoKSBm
dW5jdGlvbiwgZG8gbmVlZCB0aGUKZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCAoQykgaW4gdGhl
IGRldmljZSB0cmVlLgoKTWV0aG9kIHVzZWQgdG8gb2J0YWluIHRoZSBDIHZhbHVlOgpDIGlzIGNv
bXB1dGVkIGJ5IG1lYXN1cmluZyBlbmVyZ3kgKEUpIGNvbnN1bXB0aW9uIG9mIGEgZnJlcXVlbmN5
IGRvbWFpbgooRkQpIG92ZXIgYSAxMHMgcnVudGltZSAodCkgc3lzYmVuY2ggd29ya2xvYWQgcnVu
bmluZyBhdCBlYWNoIE9wZXJhdGluZwpQZXJmb3JtYW5jZSBQb2ludCAoT1BQKSBhZmZpbmUgdG8g
MSBvciAyIENQVXMgb2YgdGhhdCBGRCB3aGlsZSB0aGUgb3RoZXIKQ1BVcyBvZiB0aGUgc3lzdGVt
IGFyZSBob3RwbHVnZ2VkIG91dC4KQnkgZGVmaW5pdGlvbiBhbGwgQ1BVcyBvZiBhIEZEIGhhdmUg
dGhlIHRoZSBzYW1lIG1pY3JvLWFyY2hpdGVjdHVyZS4gQW4KT1BQIGlzIGNoYXJhY3Rlcml6ZWQg
YnkgYSBjZXJ0YWluIGZyZXF1ZW5jeSAoZikgYW5kIHZvbHRhZ2UgKFYpIHZhbHVlLgpUaGUgY29y
cmVzcG9uZGluZyBwb3dlciB2YWx1ZXMgKFApIGFyZSBjYWxjdWxhdGVkIGJ5IGRpdmlkaW5nIHRo
ZSBkZWx0YQpvZiB0aGUgRSB2YWx1ZXMgYmV0d2VlbiB0aGUgcnVucyB3aXRoIDIgYW5kIDEgQ1BV
cyBieSB0LgoKV2l0aCBuIGRhdGEgdHVwbGVzIChQLCBmLCBWKSwgbiBlcXVhbCB0byBudW1iZXIg
b2YgT1BQcyBmb3IgdGhpcwpmcmVxdWVuY3kgZG9tYWluLCB3ZSBjYW4gc29sdmUgQyBieToKClAg
PSBQc3RhdCArIFBkeW4KClAgPSBQc3RhdCArIENWwrJmCgpDeCA9IChQeCAtIFAxKS8oVnjCsmZ4
IC0gVjHCsmYxKSB3aXRoIHggPSB7MiwgLi4uLCBufQoKVGhlIEMgdmFsdWUgaXMgdGhlIGFyaXRo
bWV0aWMgbWVhbiBvdXQgb2Yge0MyLCAuLi4sIENufS4KClNpZ25lZC1vZmYtYnk6IERpZXRtYXIg
RWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbT4KU2lnbmVkLW9mZi1ieTogUXVlbnRp
biBQZXJyZXQgPHF1ZW50aW4ucGVycmV0QGFybS5jb20+Ci0tLQogYXJjaC9hcm0vYm9vdC9kdHMv
dmV4cHJlc3MtdjJwLWNhMTVfYTcuZHRzIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3ZleHByZXNzLXYycC1j
YTE1X2E3LmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3ZleHByZXNzLXYycC1jYTE1X2E3LmR0cwpp
bmRleCBhMmNjYWNkMDdmNGYuLjAwY2Q5ZjViZWYyZSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9v
dC9kdHMvdmV4cHJlc3MtdjJwLWNhMTVfYTcuZHRzCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3Zl
eHByZXNzLXYycC1jYTE1X2E3LmR0cwpAQCAtNDIsNiArNDIsNyBAQAogCQkJY2NpLWNvbnRyb2wt
cG9ydCA9IDwmY2NpX2NvbnRyb2wxPjsKIAkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmQ0xVU1RFUl9T
TEVFUF9CSUc+OwogCQkJY2FwYWNpdHktZG1pcHMtbWh6ID0gPDEwMjQ+OworCQkJZHluYW1pYy1w
b3dlci1jb2VmZmljaWVudCA9IDw5OTA+OwogCQl9OwogCiAJCWNwdTE6IGNwdUAxIHsKQEAgLTUx
LDYgKzUyLDcgQEAKIAkJCWNjaS1jb250cm9sLXBvcnQgPSA8JmNjaV9jb250cm9sMT47CiAJCQlj
cHUtaWRsZS1zdGF0ZXMgPSA8JkNMVVNURVJfU0xFRVBfQklHPjsKIAkJCWNhcGFjaXR5LWRtaXBz
LW1oeiA9IDwxMDI0PjsKKwkJCWR5bmFtaWMtcG93ZXItY29lZmZpY2llbnQgPSA8OTkwPjsKIAkJ
fTsKIAogCQljcHUyOiBjcHVAMiB7CkBAIC02MCw2ICs2Miw3IEBACiAJCQljY2ktY29udHJvbC1w
b3J0ID0gPCZjY2lfY29udHJvbDI+OwogCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZDTFVTVEVSX1NM
RUVQX0xJVFRMRT47CiAJCQljYXBhY2l0eS1kbWlwcy1taHogPSA8NTE2PjsKKwkJCWR5bmFtaWMt
cG93ZXItY29lZmZpY2llbnQgPSA8MTMzPjsKIAkJfTsKIAogCQljcHUzOiBjcHVAMyB7CkBAIC02
OSw2ICs3Miw3IEBACiAJCQljY2ktY29udHJvbC1wb3J0ID0gPCZjY2lfY29udHJvbDI+OwogCQkJ
Y3B1LWlkbGUtc3RhdGVzID0gPCZDTFVTVEVSX1NMRUVQX0xJVFRMRT47CiAJCQljYXBhY2l0eS1k
bWlwcy1taHogPSA8NTE2PjsKKwkJCWR5bmFtaWMtcG93ZXItY29lZmZpY2llbnQgPSA8MTMzPjsK
IAkJfTsKIAogCQljcHU0OiBjcHVANCB7CkBAIC03OCw2ICs4Miw3IEBACiAJCQljY2ktY29udHJv
bC1wb3J0ID0gPCZjY2lfY29udHJvbDI+OwogCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZDTFVTVEVS
X1NMRUVQX0xJVFRMRT47CiAJCQljYXBhY2l0eS1kbWlwcy1taHogPSA8NTE2PjsKKwkJCWR5bmFt
aWMtcG93ZXItY29lZmZpY2llbnQgPSA8MTMzPjsKIAkJfTsKIAogCQlpZGxlLXN0YXRlcyB7Ci0t
IAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
