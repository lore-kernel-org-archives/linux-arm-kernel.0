Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738BBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:03:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F772147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hpk1wHql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F772147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GCB9Tg/AeBIcETvEeKtHCLq2oOhua0JKngYhMxMagxg=; b=hpk1wHqlhyOKnx
	8nPsy2KcofzTfkCrTLw9bBoNqUoPbtJ1bqeewnMEs/9r7jxPasyAtlfyp0jHafFVFI4Zi5KxFRKex
	EbAG8PkZiMqrKsTNwZZ4jOVbkcxI5tmc6dbCdlo3dAVCj4f7dUeV3RNf8RIyjmdik7PnnBmHtSo7j
	/xVU2QmRreQrIE5ESn5u0QHR62ge+YfGQbP/9H6vaNJvCvIOrwIHL38rHXMwb29VMx/XW63EUNFtv
	Q3H5iX+krlnWnaAYK+PS+eVcG2RQ/SaAugRqeblT/Q7mpg2p+uVpLiSXkQUvPqF0xKlkIh8q2S+pQ
	xDd5orERAJ8APX1pbg3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8nw-0002Lk-Ao; Tue, 19 Feb 2019 17:03:36 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8mh-0000gI-8W
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 17:02:24 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 766276000D;
 Tue, 19 Feb 2019 17:02:16 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 7/7] ARM: dts: at91: sama5d3: switch to new sckc bindings
Date: Tue, 19 Feb 2019 18:02:00 +0100
Message-Id: <20190219170200.3608-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
References: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_090219_898761_E60599FD 
X-CRM114-Status: GOOD (  12.32  )
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
Cc: devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

UmVtb3ZlIHRoZSBjaGlsZCBub2RlcyBvZiB0aGUgc2NrYyBhcyB0aGV5IGFyZSBub3QgbmVjZXNz
YXJ5IGFueW1vcmUuCgpBbHNvLCBzd2l0Y2ggdG8gdGhlIG5ldyBhdG1lbCxzYW1hNWQzLXNja2Mg
Y29tcGF0aWJsZSBzdHJpbmcgdG8gdXNlIHRoZQpwcm9wZXIgc3RhcnR1cCB0aW1lIGZvciB0aGUg
UkMgb3NjaWxsYXRvciAoNTAwIMK1cyBpbnN0ZWFkIG9mIDc1KS4KClNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4KLS0tCiBhcmNo
L2FybS9ib290L2R0cy9hdDkxLXdiNTBuLmR0c2kgfCAgMiArLQogYXJjaC9hcm0vYm9vdC9kdHMv
c2FtYTVkMy5kdHNpICAgIHwgMjcgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAyIGZpbGVz
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS13YjUwbi5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5
MS13YjUwbi5kdHNpCmluZGV4IDg1NjkyYzhlZjJiMS4uNGVkODUwMGE1Y2I4IDEwMDY0NAotLS0g
YS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXdiNTBuLmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvYXQ5MS13YjUwbi5kdHNpCkBAIC00Miw3ICs0Miw3IEBACiAJY2xvY2stZnJlcXVlbmN5ID0g
PDEyMDAwMDAwPjsKIH07CiAKLSZzbG93X29zYyB7CismY2xrMzJrIHsKIAlhdG1lbCxvc2MtYnlw
YXNzOwogfTsKIApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMy5kdHNpIGIv
YXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMy5kdHNpCmluZGV4IDE0MDhmYTRhNjJlNC4uMDVmNjU1
NGQ0MTc3IDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9zYW1hNWQzLmR0c2kKKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMy5kdHNpCkBAIC0xMzcwLDMwICsxMzcwLDExIEBACiAJ
CQkJc3RhdHVzID0gImRpc2FibGVkIjsKIAkJCX07CiAKLQkJCXNja2NAZmZmZmZlNTAgewotCQkJ
CWNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTl4NS1zY2tjIjsKKwkJCWNsazMyazogc2NrY0Bm
ZmZmZmU1MCB7CisJCQkJY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQzLXNja2MiOwogCQkJCXJl
ZyA9IDwweGZmZmZmZTUwIDB4ND47Ci0KLQkJCQlzbG93X3JjX29zYzogc2xvd19yY19vc2Mgewot
CQkJCQljb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05eDUtY2xrLXNsb3ctcmMtb3NjIjsKLQkJ
CQkJI2Nsb2NrLWNlbGxzID0gPDA+OwotCQkJCQljbG9jay1mcmVxdWVuY3kgPSA8MzI3Njg+Owot
CQkJCQljbG9jay1hY2N1cmFjeSA9IDw1MDAwMDAwMD47Ci0JCQkJCWF0bWVsLHN0YXJ0dXAtdGlt
ZS11c2VjID0gPDc1PjsKLQkJCQl9OwotCi0JCQkJc2xvd19vc2M6IHNsb3dfb3NjIHsKLQkJCQkJ
Y29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOXg1LWNsay1zbG93LW9zYyI7Ci0JCQkJCSNjbG9j
ay1jZWxscyA9IDwwPjsKLQkJCQkJY2xvY2tzID0gPCZzbG93X3h0YWw+OwotCQkJCQlhdG1lbCxz
dGFydHVwLXRpbWUtdXNlYyA9IDwxMjAwMDAwPjsKLQkJCQl9OwotCi0JCQkJY2xrMzJrOiBzbG93
Y2sgewotCQkJCQljb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05eDUtY2xrLXNsb3ciOwotCQkJ
CQkjY2xvY2stY2VsbHMgPSA8MD47Ci0JCQkJCWNsb2NrcyA9IDwmc2xvd19yY19vc2MgJnNsb3df
b3NjPjsKLQkJCQl9OworCQkJCWNsb2NrcyA9IDwmc2xvd194dGFsPjsKKwkJCQkjY2xvY2stY2Vs
bHMgPSA8MD47CiAJCQl9OwogCiAJCQlydGNAZmZmZmZlYjAgewotLSAKMi4yMC4xCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
