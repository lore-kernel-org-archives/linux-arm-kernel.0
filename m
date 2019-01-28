Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18806C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:10:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA2A2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PSbrqUo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA2A2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1+DHzgaYzL3/g8b095V1f0cTC3+Qfz0Xfm2nbgXpudQ=; b=PSbrqUo7HhHDIP
	2jt6u/0XB6Mcf7dSFAFNCmC2TWU5GracNuvs2M1BbvWrniRRHww9M0A3t+XDniOLOzjwW9ji8EMBD
	H7EcrhCleVGO54Uzs+oYxi5BYF2I+1J2rlQIcIEmH9XSP2iTzQP94RylrhjbCum4Hppdb8bLTSo84
	MasGycgqYLdGiAqX1yqoja/m17X7CLoq6moEekjW6nXecNy2uCpBnB2sfbXrkWllwW1GPLWsnoCNR
	oJANUbGE6aGfBrXiKGQjVOo6ngLXWYsj9GQpbxvLYU18R8687er+TWXCddnQcGbuSzvIaOUOxhcTC
	ysrwhjrkbIzDPi4neFVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goAQO-0000JD-R3; Mon, 28 Jan 2019 17:10:20 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goACK-00089J-A0
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:55:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6E3D15BE;
 Mon, 28 Jan 2019 08:55:47 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com
 [10.1.195.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44CEB3F7B4;
 Mon, 28 Jan 2019 08:55:45 -0800 (PST)
From: Quentin Perret <quentin.perret@arm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com,
 liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
 mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org
Subject: [PATCH 6/7] arm64: dts: juno: Add cpu dynamic-power-coefficient
 information
Date: Mon, 28 Jan 2019 16:55:21 +0000
Message-Id: <20190128165522.31749-7-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128165522.31749-1-quentin.perret@arm.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_085548_856177_43E8E389 
X-CRM114-Status: GOOD (  11.67  )
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
cmVxIGRyaXZlciwgbGlrZSB0aGUgc2NwaSBkcml2ZXIgdXNlZCBvbiBKdW5vIGJvYXJkcywgd2hp
Y2gKcHJvdmlkZSB0aGUgRW5lcmd5IE1vZGVsIHdpdGggcG93ZXIgY29zdCBpbmZvcm1hdGlvbiB2
aWEgdGhlIFBNX09QUApvZl9kZXZfcG1fb3BwX2dldF9jcHVfcG93ZXIoKSBmdW5jdGlvbiwgZG8g
bmVlZCB0aGUKZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCAoQykgaW4gdGhlIGRldmljZSB0cmVl
LgoKTWV0aG9kIHVzZWQgdG8gb2J0YWluIHRoZSBDIHZhbHVlOgpDIGlzIGNvbXB1dGVkIGJ5IG1l
YXN1cmluZyBlbmVyZ3kgKEUpIGNvbnN1bXB0aW9uIG9mIGEgZnJlcXVlbmN5IGRvbWFpbgooRkQp
IG92ZXIgYSAxMHMgcnVudGltZSAodCkgc3lzYmVuY2ggd29ya2xvYWQgcnVubmluZyBhdCBlYWNo
IE9wZXJhdGluZwpQZXJmb3JtYW5jZSBQb2ludCAoT1BQKSBhZmZpbmUgdG8gMSBvciAyIENQVXMg
b2YgdGhhdCBGRCB3aGlsZSB0aGUgb3RoZXIKQ1BVcyBvZiB0aGUgc3lzdGVtIGFyZSBob3RwbHVn
Z2VkIG91dC4KQnkgZGVmaW5pdGlvbiBhbGwgQ1BVcyBvZiBhIEZEIGhhdmUgdGhlIHRoZSBzYW1l
IG1pY3JvLWFyY2hpdGVjdHVyZS4gQW4KT1BQIGlzIGNoYXJhY3Rlcml6ZWQgYnkgYSBjZXJ0YWlu
IGZyZXF1ZW5jeSAoZikgYW5kIHZvbHRhZ2UgKFYpIHZhbHVlLgpUaGUgY29ycmVzcG9uZGluZyBw
b3dlciB2YWx1ZXMgKFApIGFyZSBjYWxjdWxhdGVkIGJ5IGRpdmlkaW5nIHRoZSBkZWx0YQpvZiB0
aGUgRSB2YWx1ZXMgYmV0d2VlbiB0aGUgcnVucyB3aXRoIDIgYW5kIDEgQ1BVcyBieSB0LgoKV2l0
aCBuIGRhdGEgdHVwbGVzIChQLCBmLCBWKSwgbiBlcXVhbCB0byBudW1iZXIgb2YgT1BQcyBmb3Ig
dGhpcwpmcmVxdWVuY3kgZG9tYWluLCB3ZSBjYW4gc29sdmUgQyBieToKClAgPSBQc3RhdCArIFBk
eW4KClAgPSBQc3RhdCArIENWwrJmCgpDeCA9IChQeCAtIFAxKS8oVnjCsmZ4IC0gVjHCsmYxKSB3
aXRoIHggPSB7MiwgLi4uLCBufQoKVGhlIEMgdmFsdWUgaXMgdGhlIGFyaXRobWV0aWMgbWVhbiBv
dXQgb2Yge0MyLCAuLi4sIENufS4KClNpbmNlIERWRlMgaXMgYnJva2VuIG9uIEp1bm8gcjEsIG5v
IGR5bmFtaWMtcG93ZXItY29lZmZpY2llbnQKaW5mb3JtYXRpb24gaGFzIGJlZW4gYWRkZWQgdG8g
aXRzIGR0cyBmaWxlLgoKU2lnbmVkLW9mZi1ieTogRGlldG1hciBFZ2dlbWFubiA8ZGlldG1hci5l
Z2dlbWFubkBhcm0uY29tPgpTaWduZWQtb2ZmLWJ5OiBRdWVudGluIFBlcnJldCA8cXVlbnRpbi5w
ZXJyZXRAYXJtLmNvbT4KLS0tCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2FybS9qdW5vLXIyLmR0cyB8
IDYgKysrKysrCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2FybS9qdW5vLmR0cyAgICB8IDYgKysrKysr
CiAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2FybS9qdW5vLXIyLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvYXJtL2p1
bm8tcjIuZHRzCmluZGV4IGFiNzdhZGI0ZjNjMi4uNjZmMGVjNzljODY0IDEwMDY0NAotLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2FybS9qdW5vLXIyLmR0cworKysgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2FybS9qdW5vLXIyLmR0cwpAQCAtOTksNiArOTksNyBAQAogCQkJY2xvY2tzID0gPCZzY3Bp
X2R2ZnMgMD47CiAJCQljcHUtaWRsZS1zdGF0ZXMgPSA8JkNQVV9TTEVFUF8wICZDTFVTVEVSX1NM
RUVQXzA+OwogCQkJY2FwYWNpdHktZG1pcHMtbWh6ID0gPDEwMjQ+OworCQkJZHluYW1pYy1wb3dl
ci1jb2VmZmljaWVudCA9IDw0NTA+OwogCQl9OwogCiAJCUE3Ml8xOiBjcHVAMSB7CkBAIC0xMTYs
NiArMTE3LDcgQEAKIAkJCWNsb2NrcyA9IDwmc2NwaV9kdmZzIDA+OwogCQkJY3B1LWlkbGUtc3Rh
dGVzID0gPCZDUFVfU0xFRVBfMCAmQ0xVU1RFUl9TTEVFUF8wPjsKIAkJCWNhcGFjaXR5LWRtaXBz
LW1oeiA9IDwxMDI0PjsKKwkJCWR5bmFtaWMtcG93ZXItY29lZmZpY2llbnQgPSA8NDUwPjsKIAkJ
fTsKIAogCQlBNTNfMDogY3B1QDEwMCB7CkBAIC0xMzMsNiArMTM1LDcgQEAKIAkJCWNsb2NrcyA9
IDwmc2NwaV9kdmZzIDE+OwogCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZDUFVfU0xFRVBfMCAmQ0xV
U1RFUl9TTEVFUF8wPjsKIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDw0ODU+OworCQkJZHluYW1p
Yy1wb3dlci1jb2VmZmljaWVudCA9IDwxNDA+OwogCQl9OwogCiAJCUE1M18xOiBjcHVAMTAxIHsK
QEAgLTE1MCw2ICsxNTMsNyBAQAogCQkJY2xvY2tzID0gPCZzY3BpX2R2ZnMgMT47CiAJCQljcHUt
aWRsZS1zdGF0ZXMgPSA8JkNQVV9TTEVFUF8wICZDTFVTVEVSX1NMRUVQXzA+OwogCQkJY2FwYWNp
dHktZG1pcHMtbWh6ID0gPDQ4NT47CisJCQlkeW5hbWljLXBvd2VyLWNvZWZmaWNpZW50ID0gPDE0
MD47CiAJCX07CiAKIAkJQTUzXzI6IGNwdUAxMDIgewpAQCAtMTY3LDYgKzE3MSw3IEBACiAJCQlj
bG9ja3MgPSA8JnNjcGlfZHZmcyAxPjsKIAkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmQ1BVX1NMRUVQ
XzAgJkNMVVNURVJfU0xFRVBfMD47CiAJCQljYXBhY2l0eS1kbWlwcy1taHogPSA8NDg1PjsKKwkJ
CWR5bmFtaWMtcG93ZXItY29lZmZpY2llbnQgPSA8MTQwPjsKIAkJfTsKIAogCQlBNTNfMzogY3B1
QDEwMyB7CkBAIC0xODQsNiArMTg5LDcgQEAKIAkJCWNsb2NrcyA9IDwmc2NwaV9kdmZzIDE+Owog
CQkJY3B1LWlkbGUtc3RhdGVzID0gPCZDUFVfU0xFRVBfMCAmQ0xVU1RFUl9TTEVFUF8wPjsKIAkJ
CWNhcGFjaXR5LWRtaXBzLW1oeiA9IDw0ODU+OworCQkJZHluYW1pYy1wb3dlci1jb2VmZmljaWVu
dCA9IDwxNDA+OwogCQl9OwogCiAJCUE3Ml9MMjogbDItY2FjaGUwIHsKZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvYXJtL2p1bm8uZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9hcm0v
anVuby5kdHMKaW5kZXggMDhkNGJhMTcxNmMzLi45ODkwYWZkZGE3N2IgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvYXJtL2p1bm8uZHRzCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
YXJtL2p1bm8uZHRzCkBAIC05OCw2ICs5OCw3IEBACiAJCQljbG9ja3MgPSA8JnNjcGlfZHZmcyAw
PjsKIAkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmQ1BVX1NMRUVQXzAgJkNMVVNURVJfU0xFRVBfMD47
CiAJCQljYXBhY2l0eS1kbWlwcy1taHogPSA8MTAyND47CisJCQlkeW5hbWljLXBvd2VyLWNvZWZm
aWNpZW50ID0gPDUzMD47CiAJCX07CiAKIAkJQTU3XzE6IGNwdUAxIHsKQEAgLTExNSw2ICsxMTYs
NyBAQAogCQkJY2xvY2tzID0gPCZzY3BpX2R2ZnMgMD47CiAJCQljcHUtaWRsZS1zdGF0ZXMgPSA8
JkNQVV9TTEVFUF8wICZDTFVTVEVSX1NMRUVQXzA+OwogCQkJY2FwYWNpdHktZG1pcHMtbWh6ID0g
PDEwMjQ+OworCQkJZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCA9IDw1MzA+OwogCQl9OwogCiAJ
CUE1M18wOiBjcHVAMTAwIHsKQEAgLTEzMiw2ICsxMzQsNyBAQAogCQkJY2xvY2tzID0gPCZzY3Bp
X2R2ZnMgMT47CiAJCQljcHUtaWRsZS1zdGF0ZXMgPSA8JkNQVV9TTEVFUF8wICZDTFVTVEVSX1NM
RUVQXzA+OwogCQkJY2FwYWNpdHktZG1pcHMtbWh6ID0gPDU3OD47CisJCQlkeW5hbWljLXBvd2Vy
LWNvZWZmaWNpZW50ID0gPDE0MD47CiAJCX07CiAKIAkJQTUzXzE6IGNwdUAxMDEgewpAQCAtMTQ5
LDYgKzE1Miw3IEBACiAJCQljbG9ja3MgPSA8JnNjcGlfZHZmcyAxPjsKIAkJCWNwdS1pZGxlLXN0
YXRlcyA9IDwmQ1BVX1NMRUVQXzAgJkNMVVNURVJfU0xFRVBfMD47CiAJCQljYXBhY2l0eS1kbWlw
cy1taHogPSA8NTc4PjsKKwkJCWR5bmFtaWMtcG93ZXItY29lZmZpY2llbnQgPSA8MTQwPjsKIAkJ
fTsKIAogCQlBNTNfMjogY3B1QDEwMiB7CkBAIC0xNjYsNiArMTcwLDcgQEAKIAkJCWNsb2NrcyA9
IDwmc2NwaV9kdmZzIDE+OwogCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZDUFVfU0xFRVBfMCAmQ0xV
U1RFUl9TTEVFUF8wPjsKIAkJCWNhcGFjaXR5LWRtaXBzLW1oeiA9IDw1Nzg+OworCQkJZHluYW1p
Yy1wb3dlci1jb2VmZmljaWVudCA9IDwxNDA+OwogCQl9OwogCiAJCUE1M18zOiBjcHVAMTAzIHsK
QEAgLTE4Myw2ICsxODgsNyBAQAogCQkJY2xvY2tzID0gPCZzY3BpX2R2ZnMgMT47CiAJCQljcHUt
aWRsZS1zdGF0ZXMgPSA8JkNQVV9TTEVFUF8wICZDTFVTVEVSX1NMRUVQXzA+OwogCQkJY2FwYWNp
dHktZG1pcHMtbWh6ID0gPDU3OD47CisJCQlkeW5hbWljLXBvd2VyLWNvZWZmaWNpZW50ID0gPDE0
MD47CiAJCX07CiAKIAkJQTU3X0wyOiBsMi1jYWNoZTAgewotLSAKMi4yMC4xCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
