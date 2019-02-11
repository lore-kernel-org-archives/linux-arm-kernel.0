Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E472FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:17:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF8421B24
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i8aF2uE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF8421B24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BURD8xjFQzHiUKeLAGqUwPjv+jJrY3t67Hkfa7uX8JA=; b=i8aF2uE/yCrQ23
	kb+98e+PuKEKhsGv98cEjUrqaggqNWj2nc7NCvyRubUkixk3cgwjhzqHPmTuGFTuFjvSKxTSG6DEF
	Vv8g8loWi9GuSk2ihoWhRK4yiEnpLpvdxKMjCoWzTFgYNCTOY6c4TjNmDSoFtRNyTZk9pdmh2rtdY
	aPeV6XhyZRYMJ/eV5GyqEC2pjxIrD2Mx/VLJPDwc5zoX69qCb8zx1Wa6p7YDeaX65CZ7KUPRAEEZk
	KkNku+eIWLgQA9Z/2zu1CDhcZr6dS3EWc/9Je9S1RqcaQXnQJhCyX4Vf/ddWHWXoRNTwS277tPimt
	O+LorwPMY3HXRiQPgHMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtG8b-0007oy-In; Mon, 11 Feb 2019 18:17:01 +0000
Received: from gateway20.websitewelcome.com ([192.185.65.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtG8Y-0007ne-BL
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 18:16:59 +0000
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway20.websitewelcome.com (Postfix) with ESMTP id 4BAEA401252B6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 12:15:34 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id tG7Cg6hAoiQertG7CgMMb4; Mon, 11 Feb 2019 12:15:34 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=41332 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gtG7A-001yty-PL; Mon, 11 Feb 2019 12:15:33 -0600
Date: Mon, 11 Feb 2019 12:15:31 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
Message-ID: <20190211181531.GA3238@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1gtG7A-001yty-PL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:41332
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_101658_431760_F6DD0E8F 
X-CRM114-Status: UNSURE (   9.86  )
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
Cc: linux-samsung-soc@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SW4gcHJlcGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCwgbWFyayBz
d2l0Y2gKY2FzZXMgd2hlcmUgd2UgYXJlIGV4cGVjdGluZyB0byBmYWxsIHRocm91Z2guCgpUaGlz
IHBhdGNoIGZpeGVzIHRoZSBmb2xsb3dpbmcgd2FybmluZ3M6Cgpkcml2ZXJzL2Nsay9zYW1zdW5n
L2Nsay1zM2MyNDQzLmM6IEluIGZ1bmN0aW9uIOKAmHMzYzI0NDNfY29tbW9uX2Nsa19pbml04oCZ
Ogpkcml2ZXJzL2Nsay9zYW1zdW5nL2Nsay1zM2MyNDQzLmM6MzkwOjM6IHdhcm5pbmc6IHRoaXMg
c3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQogICBz
YW1zdW5nX2Nsa19yZWdpc3Rlcl9hbGlhcyhjdHgsIHMzYzI0NTBfYWxpYXNlcywKICAgXn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgICAgQVJSQVlfU0la
RShzM2MyNDUwX2FsaWFzZXMpKTsKICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmRy
aXZlcnMvY2xrL3NhbXN1bmcvY2xrLXMzYzI0NDMuYzozOTM6Mjogbm90ZTogaGVyZQogIGNhc2Ug
UzNDMjQxNjoKICBefn5+CgpXYXJuaW5nIGxldmVsIDMgd2FzIHVzZWQ6IC1XaW1wbGljaXQtZmFs
bHRocm91Z2g9MwoKTm90aWNlIHRoYXQsIGluIHRoaXMgcGFydGljdWxhciBjYXNlLCAgdGhlIGNv
ZGUgY29tbWVudCBpcyBtb2RpZmllZAppbiBhY2NvcmRhbmNlIHdpdGggd2hhdCBHQ0MgaXMgZXhw
ZWN0aW5nIHRvIGZpbmQuCgpUaGlzIHBhdGNoIGlzIHBhcnQgb2YgdGhlIG9uZ29pbmcgZWZmb3J0
cyB0byBlbmFibGUKLVdpbXBsaWNpdC1mYWxsdGhyb3VnaC4KClNpZ25lZC1vZmYtYnk6IEd1c3Rh
dm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+Ci0tLQogZHJpdmVycy9jbGsv
c2Ftc3VuZy9jbGstczNjMjQ0My5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvc2Ftc3VuZy9jbGst
czNjMjQ0My5jIGIvZHJpdmVycy9jbGsvc2Ftc3VuZy9jbGstczNjMjQ0My5jCmluZGV4IDg4NDA2
N2U0ZjFhMS4uZjM4ZjBlMjRlM2I2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Nsay9zYW1zdW5nL2Ns
ay1zM2MyNDQzLmMKKysrIGIvZHJpdmVycy9jbGsvc2Ftc3VuZy9jbGstczNjMjQ0My5jCkBAIC0z
ODksNyArMzg5LDcgQEAgdm9pZCBfX2luaXQgczNjMjQ0M19jb21tb25fY2xrX2luaXQoc3RydWN0
IGRldmljZV9ub2RlICpucCwgdW5zaWduZWQgbG9uZyB4dGlfZiwKIAkJCQlBUlJBWV9TSVpFKHMz
YzI0NTBfZ2F0ZXMpKTsKIAkJc2Ftc3VuZ19jbGtfcmVnaXN0ZXJfYWxpYXMoY3R4LCBzM2MyNDUw
X2FsaWFzZXMsCiAJCQkJQVJSQVlfU0laRShzM2MyNDUwX2FsaWFzZXMpKTsKLQkJLyogZmFsbCB0
aHJvdWdoLCBhcyBzM2MyNDUwIGV4dGVuZHMgdGhlIHMzYzI0MTYgY2xvY2tzICovCisJCS8qIGZh
bGwgdGhyb3VnaCAtIGFzIHMzYzI0NTAgZXh0ZW5kcyB0aGUgczNjMjQxNiBjbG9ja3MgKi8KIAlj
YXNlIFMzQzI0MTY6CiAJCXNhbXN1bmdfY2xrX3JlZ2lzdGVyX2RpdihjdHgsIHMzYzI0MTZfZGl2
aWRlcnMsCiAJCQkJQVJSQVlfU0laRShzM2MyNDE2X2RpdmlkZXJzKSk7Ci0tIAoyLjIwLjEKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
