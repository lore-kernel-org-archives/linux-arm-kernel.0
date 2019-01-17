Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3ACC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:00:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDE120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lsxAVA5Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WhD4Mw2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDE120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a+VdR6koZ6T2pomlELIZkAspdONhA9lguBpdkuf3Llw=; b=lsxAVA5Z0U8/gc
	Rg+G1Olp2AQHLuxX+coOAYsx/RBFtbMG1hYZD9YCdAfswGdhQUi0kP4txJMz3YQDQ1aVIKhI4GuOr
	5goYlwc1r8IYkBrqLenHfOdECFHemPze+HoggxqImuv+MjI4MY4nDTb+HTYUA4O9OgvsYRlVG3jvf
	crDABLIzMvLiucbn5qOtFklDcBFMpnIecs8MorqQnsRNbeynLVWTwlczjvLIefCQ1/jpxfxmNOuqG
	mlZt88mWCicWMAQdFKlwMR3CHWgqPbtNxjEk6S8aBA/EIDR+axpujNnsxbk9ORcW6NdcRCemmhjYS
	9zHv2DQIMqnUiDb6lY/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkEcP-0002HF-Fg; Thu, 17 Jan 2019 20:50:29 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkEcM-0001Wh-W0
 for linux-arm-kernel@bombadil.infradead.org; Thu, 17 Jan 2019 20:50:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KAtIDHr7iL8t0cPK7N9xfb1WgflrRK/w+FCpuVV4q90=; b=WhD4Mw2yudsStpgVn/dpWot09Z
 pI5NjRcZnfY7V708i+xPBZuHTOYOCunnK2R2UKmGnuAE546+MFmU/yTmB+9QinpOB9GYYgZRZyT1o
 J4BngIED5QEXm7jKVnBHkwv+6gtx+Wqgrj68pDqCyxbxhgwqwAe6NuvhNxUdYh/q7Z/Q7pJjpgEVd
 dZqG2s8I6pGtqA4yW5ZAr0MSt0XwI7LafzyKZ1QIpAZa37lN8iUJW/6T6B2yAWUvxzYrg3BPHsu+d
 5LHh1hAP2u0N2o7qSSE9Y5Lja71HRL1ND0mKoNALEQtPRz4BiRnman9tuvENEPVKaWBBRb6bBBLRE
 aUv1uTSg==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkENm-0006ny-2L
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 20:35:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C97B2169E;
 Thu, 17 Jan 2019 12:35:21 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0903C3F819;
 Thu, 17 Jan 2019 12:35:19 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v4 25/25] KVM: arm64/sve: Document KVM API extensions for SVE
Date: Thu, 17 Jan 2019 20:33:39 +0000
Message-Id: <1547757219-19439-26-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
References: <1547757219-19439-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_203522_424338_EFA9DD23 
X-CRM114-Status: GOOD (  16.84  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Julien Grall <Julien.Grall@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBwYXRjaCBhZGRzIHNlY3Rpb25zIHRvIHRoZSBLVk0gQVBJIGRvY3VtZW50YXRpb24gZGVz
Y3JpYmluZwp0aGUgZXh0ZW5zaW9ucyBmb3Igc3VwcG9ydGluZyB0aGUgU2NhbGFibGUgVmVjdG9y
IEV4dGVuc2lvbiAoU1ZFKQppbiBndWVzdHMuCgpTaWduZWQtb2ZmLWJ5OiBEYXZlIE1hcnRpbiA8
RGF2ZS5NYXJ0aW5AYXJtLmNvbT4KCi0tLQoKQ2hhbmdlcyBzaW5jZSBSRkMgdjM6CgogKiBSZXdy
b3RlIHRoZSBidWxrIG9mIHRoZSBkb2N1bWVudGF0aW9uIHRvIGRvY3VtZW50IHRoZSBuZXcgdmVj
dG9yCiAgIGxlbmd0aCBzZXQgY29udHJvbCBpbnRlcmZhY2UgdmlhIEtWTV9SRUdfQVJNNjRfU1ZF
X1ZMUywgYW5kIGRlc2NyaWJlCiAgIHRoZSBuZXcgdmNwdSBpbml0IC8gcmVnaXN0ZXIgYWNjZXNz
IHNlbWFudGljcy4KCiAqIEZpeCBkb2N1bWVudGF0aW9uIHJlZ2FyZGluZyB3aGljaCBTVkUgWm4g
cmVnaXN0ZXIgYml0cyBtdXN0IGJlCiAgIGFjY2Vzc2VkIGluIG9yZGVyIHRvIGdldCBhdCBWbiBv
biBhbiBTVkUtZW5hYmxlZCB2Y3B1LgotLS0KIERvY3VtZW50YXRpb24vdmlydHVhbC9rdm0vYXBp
LnR4dCB8IDYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQogMSBmaWxl
IGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi92aXJ0dWFsL2t2bS9hcGkudHh0IGIvRG9jdW1lbnRhdGlvbi92aXJ0dWFs
L2t2bS9hcGkudHh0CmluZGV4IGNiMTVmMmEuLmQ0NWU5M2MgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50
YXRpb24vdmlydHVhbC9rdm0vYXBpLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL3ZpcnR1YWwva3Zt
L2FwaS50eHQKQEAgLTE4NTYsNiArMTg1Niw3IEBAIFBhcmFtZXRlcnM6IHN0cnVjdCBrdm1fb25l
X3JlZyAoaW4pCiBSZXR1cm5zOiAwIG9uIHN1Y2Nlc3MsIG5lZ2F0aXZlIHZhbHVlIG9uIGZhaWx1
cmUKIEVycm9yczoKICDCoEVOT0VOVDogwqDCoG5vIHN1Y2ggcmVnaXN0ZXIKKyDCoEVQRVJNOiDC
oMKgwqByZWdpc3RlciBhY2Nlc3MgZm9yYmlkZGVuIGZvciBhcmNoaXRlY3R1cmUtZGVwZW5kZW50
IHJlYXNvbnMKICDCoEVJTlZBTDogwqDCoG90aGVyIGVycm9ycywgc3VjaCBhcyBiYWQgc2l6ZSBl
bmNvZGluZyBmb3IgYSBrbm93biByZWdpc3RlcgogCiBzdHJ1Y3Qga3ZtX29uZV9yZWcgewpAQCAt
MjExMCwxMyArMjExMSwyMCBAQCBTcGVjaWZpY2FsbHk6CiAgIDB4NjAzMCAwMDAwIDAwMTAgMDA0
YyBTUFNSX1VORCAgICA2NCAgc3BzcltLVk1fU1BTUl9VTkRdCiAgIDB4NjAzMCAwMDAwIDAwMTAg
MDA0ZSBTUFNSX0lSUSAgICA2NCAgc3BzcltLVk1fU1BTUl9JUlFdCiAgIDB4NjA2MCAwMDAwIDAw
MTAgMDA1MCBTUFNSX0ZJUSAgICA2NCAgc3BzcltLVk1fU1BTUl9GSVFdCi0gIDB4NjA0MCAwMDAw
IDAwMTAgMDA1NCBWMCAgICAgICAgIDEyOCAgZnBfcmVncy52cmVnc1swXQotICAweDYwNDAgMDAw
MCAwMDEwIDAwNTggVjEgICAgICAgICAxMjggIGZwX3JlZ3MudnJlZ3NbMV0KKyAgMHg2MDQwIDAw
MDAgMDAxMCAwMDU0IFYwICAgICAgICAgMTI4ICBmcF9yZWdzLnZyZWdzWzBdICAgICgqKQorICAw
eDYwNDAgMDAwMCAwMDEwIDAwNTggVjEgICAgICAgICAxMjggIGZwX3JlZ3MudnJlZ3NbMV0gICAg
KCopCiAgICAgLi4uCi0gIDB4NjA0MCAwMDAwIDAwMTAgMDBkMCBWMzEgICAgICAgIDEyOCAgZnBf
cmVncy52cmVnc1szMV0KKyAgMHg2MDQwIDAwMDAgMDAxMCAwMGQwIFYzMSAgICAgICAgMTI4ICBm
cF9yZWdzLnZyZWdzWzMxXSAgICgqKQogICAweDYwMjAgMDAwMCAwMDEwIDAwZDQgRlBTUiAgICAg
ICAgMzIgIGZwX3JlZ3MuZnBzcgogICAweDYwMjAgMDAwMCAwMDEwIDAwZDUgRlBDUiAgICAgICAg
MzIgIGZwX3JlZ3MuZnBjcgogCisoKikgVGhlc2UgZW5jb2RpbmdzIGFyZSBub3QgYWNjZXB0ZWQg
Zm9yIFNWRS1lbmFibGVkIHZjcHVzLiAgU2VlCisgICAgS1ZNX0FSTV9WQ1BVX0lOSVQuCisKKyAg
ICBUaGUgZXF1aXZhbGVudCByZWdpc3RlciBjb250ZW50IGNhbiBiZSBhY2Nlc3NlZCB2aWEgYml0
cyBbMTI3OjBdIG9mCisgICAgdGhlIGNvcnJlc3BvbmRpbmcgU1ZFIFpuIHJlZ2lzdGVycyBpbnN0
ZWFkIGZvciB2Y3B1cyB0aGF0IGhhdmUgU1ZFCisgICAgZW5hYmxlZCAoc2VlIGJlbG93KS4KKwog
YXJtNjQgQ0NTSURSIHJlZ2lzdGVycyBhcmUgZGVtdWx0aXBsZXhlZCBieSBDU1NFTFIgdmFsdWU6
CiAgIDB4NjAyMCAwMDAwIDAwMTEgMDAgPGNzc2Vscjo4PgogCkBAIC0yMTI2LDYgKzIxMzQsNTAg
QEAgYXJtNjQgc3lzdGVtIHJlZ2lzdGVycyBoYXZlIHRoZSBmb2xsb3dpbmcgaWQgYml0IHBhdHRl
cm5zOgogYXJtNjQgZmlybXdhcmUgcHNldWRvLXJlZ2lzdGVycyBoYXZlIHRoZSBmb2xsb3dpbmcg
Yml0IHBhdHRlcm46CiAgIDB4NjAzMCAwMDAwIDAwMTQgPHJlZ25vOjE2PgogCithcm02NCBTVkUg
cmVnaXN0ZXJzIGhhdmUgdGhlIGZvbGxvd2luZyBiaXQgcGF0dGVybnM6CisgIDB4NjA4MCAwMDAw
IDAwMTUgMDAgPG46NT4gPHNsaWNlOjU+ICAgWm4gYml0c1syMDQ4KnNsaWNlICsgMjA0NyA6IDIw
NDgqc2xpY2VdCisgIDB4NjA1MCAwMDAwIDAwMTUgMDQgPG46ND4gPHNsaWNlOjU+ICAgUG4gYml0
c1syNTYqc2xpY2UgKyAyNTUgOiAyNTYqc2xpY2VdCisgIDB4NjA1MCAwMDAwIDAwMTUgMDYwIDxz
bGljZTo1PiAgICAgICAgRkZSIGJpdHNbMjU2KnNsaWNlICsgMjU1IDogMjU2KnNsaWNlXQorICAw
eDYwNjAgMDAwMCAwMDE1IGZmZmYgICAgICAgICAgICAgICAgIEtWTV9SRUdfQVJNNjRfU1ZFX1ZM
UyBwc2V1ZG8tcmVnaXN0ZXIKKworVGhlc2UgcmVnaXN0ZXJzIGFyZSBvbmx5IGFjY2Vzc2libGUg
b24gdmNwdXMgZm9yIHdoaWNoIFNWRSBpcyBlbmFibGVkLgorU2VlIEtWTV9BUk1fVkNQVV9JTklU
IGZvciBkZXRhaWxzLgorCitLVk1fUkVHX0FSTTY0X1NWRV9WTFMgaXMgYSBwc2V1ZG8tcmVnaXN0
ZXIgdGhhdCBhbGxvd3MgdGhlIHNldCBvZiB2ZWN0b3IKK2xlbmd0aHMgc3VwcG9ydGVkIGJ5IHRo
ZSB2Y3B1IHRvIGJlIGRpc2NvdmVyZWQgYW5kIGNvbmZpZ3VyZWQgYnkKK3VzZXJzcGFjZS4gIFdo
ZW4gdHJhbnNmZXJyZWQgdG8gb3IgZnJvbSB1c2VyIG1lbW9yeSB2aWEgS1ZNX0dFVF9PTkVfUkVH
CitvciBLVk1fU0VUX09ORV9SRUcsIHRoZSB2YWx1ZSBvZiB0aGlzIHJlZ2lzdGVyIGlzIG9mIHR5
cGUgX191NjRbOF0sIGFuZAorZW5jb2RlcyB0aGUgc2V0IG9mIHZlY3RvciBsZW5ndGhzIGFzIGZv
bGxvd3M6CisKK19fdTY0IHZlY3Rvcl9sZW5ndGhzWzhdOworCitpZiAodnEgPj0gU1ZFX1ZRX01J
TiAmJiB2cSA8PSBTVkVfVlFfTUFYICYmCisgICAgKCh2ZWN0b3JfbGVuZ3Roc1sodnEgLSAxKSAv
IDY0XSA+PiAoKHZxIC0gMSkgJSA2NCkpICYgMSkpCisJLyogVmVjdG9yIGxlbmd0aCB2cSAqIDE2
IGJ5dGVzIHN1cHBvcnRlZCAqLworZWxzZQorCS8qIFZlY3RvciBsZW5ndGggdnEgKiAxNiBieXRl
cyBub3Qgc3VwcG9ydGVkICovCisKKyhTZWUgRG9jdW1lbnRhdGlvbi9hcm02NC9zdmUudHh0IGZv
ciBhbiBleHBsYW5hdGlvbiBvZiB0aGUgInZxIgorbm9tZW5jbGF0dXJlLikKKworS1ZNX1JFR19B
Uk02NF9TVkVfVkxTIGlzIG9ubHkgYWNjZXNzaWJsZSBhZnRlciBLVk1fQVJNX1ZDUFVfSU5JVC4K
K0tWTV9BUk1fVkNQVV9JTklUIGluaXRpYWxpc2VzIGl0IHRvIHRoZSBiZXN0IHNldCBvZiB2ZWN0
b3IgbGVuZ3RocyB0aGF0Cit0aGUgaG9zdCBzdXBwb3J0cy4KKworVXNlcnNwYWNlIG1heSBzdWJz
ZXF1ZW50bHkgbW9kaWZ5IGl0IGlmIGRlc2lyZWQgdW50aWwgdGhlIHZjcHUKK2NvbmZpZ3VyYXRp
b24gaXMgZmluYWxpemVkIGJ5IGFjY2Vzc2luZyB0aGUgZ3Vlc3QncyBTVkUgcmVnaXN0ZXJzLCBv
cgorZW51bWVyYXRpbmcgdGhlbSB2aWEgS1ZNX0dFVF9SRUdfTElTVCwgb3Igc2V0dGluZyB0aGUg
Y3B1IHJ1bm5pbmcgdmlhCitLVk1fUlVOLgorCitBcGFydCBmcm9tIHNpbXBseSByZW1vdmluZyBh
bGwgdmVjdG9yIGxlbmd0aHMgZnJvbSB0aGUgaG9zdCBzZXQgdGhhdAorZXhjZWVkIHNvbWUgdmFs
dWUsIHN1cHBvcnQgZm9yIGFyYml0cmFyaWx5IGNob3NlbiBzZXRzIG9mIHZlY3RvciBsZW5ndGhz
CitpcyBoYXJkd2FyZS1kZXBlbmRlbnQgYW5kIG1heSBub3QgYmUgYXZhaWxhYmxlLiAgQXR0ZW1w
dGluZyB0byBjb25maWd1cmUKK2FuIGludmFsaWQgc2V0IG9mIHZlY3RvciBsZW5ndGhzIHZpYSBL
Vk1fU0VUX09ORV9SRUcgd2lsbCBmYWlsIHdpdGgKK0VJTlZBTC4KKworQWZ0ZXIgdGhlIHZjcHUn
cyBjb25maWd1cmF0aW9uIGlzIGZpbmFsaXplZCwgZnVydGhlciBhdHRlbXB0cyB0byB3cml0ZQor
dGhpcyByZWdpc3RlciB3aWxsIGZhaWwgd2l0aCBFUEVSTS4KKwogCiBNSVBTIHJlZ2lzdGVycyBh
cmUgbWFwcGVkIHVzaW5nIHRoZSBsb3dlciAzMiBiaXRzLiAgVGhlIHVwcGVyIDE2IG9mIHRoYXQg
aXMKIHRoZSByZWdpc3RlciBncm91cCB0eXBlOgpAQCAtMjE4MCw2ICsyMjMyLDcgQEAgUGFyYW1l
dGVyczogc3RydWN0IGt2bV9vbmVfcmVnIChpbiBhbmQgb3V0KQogUmV0dXJuczogMCBvbiBzdWNj
ZXNzLCBuZWdhdGl2ZSB2YWx1ZSBvbiBmYWlsdXJlCiBFcnJvcnM6CiAgwqBFTk9FTlQ6IMKgwqBu
byBzdWNoIHJlZ2lzdGVyCisgwqBFUEVSTTogwqDCoMKgcmVnaXN0ZXIgYWNjZXNzIGZvcmJpZGRl
biBmb3IgYXJjaGl0ZWN0dXJlLWRlcGVuZGVudCByZWFzb25zCiAgwqBFSU5WQUw6IMKgwqBvdGhl
ciBlcnJvcnMsIHN1Y2ggYXMgYmFkIHNpemUgZW5jb2RpbmcgZm9yIGEga25vd24gcmVnaXN0ZXIK
IAogVGhpcyBpb2N0bCBhbGxvd3MgdG8gcmVjZWl2ZSB0aGUgdmFsdWUgb2YgYSBzaW5nbGUgcmVn
aXN0ZXIgaW1wbGVtZW50ZWQKQEAgLTI2NzIsNiArMjcyNSw4IEBAIFBvc3NpYmxlIGZlYXR1cmVz
OgogCSAgRGVwZW5kcyBvbiBLVk1fQ0FQX0FSTV9QU0NJXzBfMi4KIAktIEtWTV9BUk1fVkNQVV9Q
TVVfVjM6IEVtdWxhdGUgUE1VdjMgZm9yIHRoZSBDUFUuCiAJICBEZXBlbmRzIG9uIEtWTV9DQVBf
QVJNX1BNVV9WMy4KKwktIEtWTV9BUk1fVkNQVV9TVkU6IEVuYWJsZXMgU1ZFIGZvciB0aGUgQ1BV
IChhcm02NCBvbmx5KS4KKwkgIERlcGVuZHMgb24gS1ZNX0NBUF9BUk1fU1ZFLgogCiAKIDQuODMg
S1ZNX0FSTV9QUkVGRVJSRURfVEFSR0VUCi0tIAoyLjEuNAoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
