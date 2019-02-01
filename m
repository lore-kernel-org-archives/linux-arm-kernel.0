Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBE3C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:17:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DE6218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PsOhasWT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yvxTa8or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DE6218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lxlCp+v50xW9CSjU2ZKE6F/jAxn288miPdZMoQn97lk=; b=PsOhasWTkqjLDM
	lgb8MtTUqdA2quyrlCyiNGrzn3/gsw+oDKFO8Anzsn520KsoYKZFwqp+e+Mp6TSlfTHpr2fHrLGms
	yc7LfWU+7E0U/HLXFCj3WryQuKKV4mw7s8/l0DUZVKtGGBsOeEMlyrJ8OUVOweNV7DCvD5XeidtG8
	X9/tlROT3bc1COiLy29dnT7508v1PCmePMgpKwOspiOmYuCVw90RTBE9kdnAucot2xtCCDBkCBvdH
	axGfkK+AnU5SZrp6GdA0cqyrZYreJgYWaEmBfmP1+YQuTwppU/2JdlikANrOA58HFgcRnbnxNJbO9
	pKaWe/+aQ7LEkY2WPJ2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpeJq-0001gI-IK; Fri, 01 Feb 2019 19:17:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpeJe-0001XI-VN
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 19:17:32 +0000
Received: from localhost.localdomain (80-123-14-12.adsl.highway.telekom.at
 [80.123.14.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0E38F218FF;
 Fri,  1 Feb 2019 19:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549048650;
 bh=f2oLzNDn2Cfvbgc3FgNMiKRTjjx2dAb6tJN6awhcr/s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=yvxTa8or+KJj/AjfMIp+ig/t3j3gWmnFnf5ovOhhTg1SjfId/c5Zd7IazQjPcEKVp
 UbyI8IkBBKiAxWQoF13w8MBtrNRrVuorLJIwA1jBS8qp9AzqpKeV4shrO0o3RoFwjx
 ioZc6qxMEblEDolV9HK3boVMNpLxndq4aoGIohWM=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm@kernel.org
Subject: [GIT PULL 2/2] ARM: dts: samsung: exynos and s5pv210 for v5.1
Date: Fri,  1 Feb 2019 20:17:20 +0100
Message-Id: <20190201191720.20464-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201191720.20464-1-krzk@kernel.org>
References: <20190201191720.20464-1-krzk@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_111731_021528_D2B542A2 
X-CRM114-Status: GOOD (  13.57  )
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
Cc: linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBiZmVmZmQxNTUyODM3NzJiYmU3OGM2
YTA1ZGVjN2MwMTI4ZWU1MDBjOgoKICBMaW51eCA1LjAtcmMxICgyMDE5LTAxLTA2IDE3OjA4OjIw
IC0wODAwKQoKYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6CgogIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2tyemsvbGludXguZ2l0
IHRhZ3Mvc2Ftc3VuZy1kdC01LjEKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBlYzMz
NzQ1YmNjYzhmMzM2OTU3Yzc1MWY0MTUzNDIxY2M5ZWY1YTU0OgoKICBBUk06IGR0czogZXh5bm9z
OiBGaXggcGluY3RybCBkZWZpbml0aW9uIGZvciBlTU1DIFJUU04gbGluZSBvbiBPZHJvaWQgWDIv
VTMgKDIwMTktMDEtMjUgMjA6MTg6MTAgKzAxMDApCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClNhbXN1bmcgRFRTIEFSTSBj
aGFuZ2VzIGZvciB2NS4xCgoxLiBFeHRlbmQgc3VwcG9ydCBmb3IgQXJpZXMgZmFtaWx5IG9mIG1v
YmlsZSBkZXZpY2VzIChlLmcuIFNhbXN1bmcKICAgR2FsYXh5IFMpIGJhc2VkIG9uIFM1UHYyMTAg
U29DOiBEUk0gUm90YXRvciwgRklNRCwgUFdNIHZpYnJhdG9yLAogICBwb3dlciBvZmYsIHRvdWNo
c2NyZWVuLCBCcm9hZGNvbSBCQ000MzI5IEJsdWV0b290aCBhbmQgY3B1ZnJlcS4KMi4gUmVtb3Zl
IGhhcmRjb2RlZCBib290YXJncyBvbiBHYWxheHkgUyBmYW1pbHkgKHByb3BlciBzdXBwb3J0IGlu
CiAgIFUtQm9vdCkuCjMuIEZpeCBtaW5vciBEVEMgd2FybmluZ3MuCjQuIEZpeCBFeHlub3M0NDEy
IE9kcm9pZCBYMi9VMyBjb25mbGljdGluZyBlTU1DIEdQSU8gc2V0dGluZ3MgYW5kIHJlZ3VsYXRv
cgogICBwcm9wZXJ0aWVzLgo1LiBGaXggdGhlIGVNTUMgUlRTTiBwaW4gYnJlYWtpbmcgcHJvcGVy
IHJlYm9vdCBvbiBYMi4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSm9uYXRoYW4gQmFra2VyICgxKToKICAgICAgQVJNOiBk
dHM6IHM1cHYyMTA6IEFkZCBzdXBwb3J0IGZvciBtb3JlIGRldmljZXMgcHJlc2VudCBvbiBBcmll
cwoKS3J6eXN6dG9mIEtvemxvd3NraSAoMik6CiAgICAgIEFSTTogZHRzOiBzNXB2MjEwOiBGaXgg
b25lbmFuZCdzIHVuaXQgYWRkcmVzcyBmb3JtYXQgd2FybmluZwogICAgICBBUk06IGR0czogczNj
MjQxNjogRml4IHh0aSBub2RlJ3MgbWlzc2luZyByZWcgcHJvcGVydHkgd2FybmluZwoKTWFyZWsg
U3p5cHJvd3NraSAoMyk6CiAgICAgIEFSTTogZHRzOiBleHlub3M6IEZpeCBjb25mbGljdGluZyBm
aXhlZC1yZWd1bGF0b3IgR1BJTyBmbGFncyBhbmQgcHJvcGVydGllcwogICAgICBBUk06IGR0czog
ZXh5bm9zOiBGaXggZU1NQyByZWd1bGF0b3IgcHJvcGVydGllcyBvbiBPZHJvaWQgVTMgYm9hcmRz
CiAgICAgIEFSTTogZHRzOiBleHlub3M6IEZpeCBwaW5jdHJsIGRlZmluaXRpb24gZm9yIGVNTUMg
UlRTTiBsaW5lIG9uIE9kcm9pZCBYMi9VMwoKUGF3ZcWCIENobWllbCAoNSk6CiAgICAgIEFSTTog
ZHRzOiBzNXB2MjEwOiBBZGQgbm9kZSBmb3IgZXh5bm9zLXJvdGF0b3IKICAgICAgQVJNOiBkdHM6
IHM1cHYyMTA6IFVzZSBjb3JyZWN0IGZpbWQgdmFyaWFudAogICAgICBBUk06IGR0czogczVwdjIx
MDogUmVtb3ZlIGhhcmRjb2RlZCBib290YXJncyBvbiBHYWxheHkgUyBhbmQgRmFzY2luYXRlIDRH
CiAgICAgIEFSTTogZHRzOiBzNXB2MjEwOiBBZGQgcmVzZXJ2ZWQgbWVtb3J5IGZvciBNRkMgb24g
QXJpZXMKICAgICAgQVJNOiBkdHM6IHM1cHYyMTA6IEFkZCBETUMgbm9kZXMKCiBhcmNoL2FybS9i
b290L2R0cy9leHlub3M0NDEyLW9kcm9pZC1jb21tb24uZHRzaSB8IDE0ICsrLS0KIGFyY2gvYXJt
L2Jvb3QvZHRzL2V4eW5vczQ0MTItb2Ryb2lkeC5kdHMgICAgICAgIHwgIDIgKy0KIGFyY2gvYXJt
L2Jvb3QvZHRzL2V4eW5vczUyNTAtYXJuZGFsZS5kdHMgICAgICAgIHwgIDIgKy0KIGFyY2gvYXJt
L2Jvb3QvZHRzL3MzYzI0MTYtc21kazI0MTYuZHRzICAgICAgICAgIHwgIDUgKy0KIGFyY2gvYXJt
L2Jvb3QvZHRzL3M1cHYyMTAtYXJpZXMuZHRzaSAgICAgICAgICAgIHwgOTAgKysrKysrKysrKysr
KysrKysrKysrKysrKwogYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC1mYXNjaW5hdGU0Zy5kdHMg
ICAgICAgfCAgNyAtLQogYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC1nYWxheHlzLmR0cyAgICAg
ICAgICAgfCAgNyAtLQogYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC5kdHNpICAgICAgICAgICAg
ICAgICAgfCAyNSArKysrKystCiA4IGZpbGVzIGNoYW5nZWQsIDEyNSBpbnNlcnRpb25zKCspLCAy
NyBkZWxldGlvbnMoLSkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
